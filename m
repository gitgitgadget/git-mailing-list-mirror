From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 11:22:10 +0200
Message-ID: <adf1fd3d0907140222t6762d4f7s417f56905492cbba@mail.gmail.com>
References: <200907140811.24174.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 11:23:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQeDv-00015P-ST
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 11:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZGNJWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 05:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbZGNJWP
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 05:22:15 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58320 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbZGNJWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 05:22:12 -0400
Received: by fxm18 with SMTP id 18so2683460fxm.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 02:22:10 -0700 (PDT)
Received: by 10.204.103.145 with SMTP id k17mr6195617bko.10.1247563330057; 
	Tue, 14 Jul 2009 02:22:10 -0700 (PDT)
In-Reply-To: <200907140811.24174.Karlis.Repsons@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123234>

2009/7/14 K=C4=81rlis Repsons <karlis.repsons@gmail.com>:
> Hello,
> git is just great with its possibility of decentralised using, but ho=
w can it
> be done, given, that participants are all across the internet? IPv6? =
How is
> it done with kernel?

I don't think "truly decentralised" is what you want[1]. For me, truly
decentralised is when all the repositories are equal, and in
particular there is no central repository to sync with.

Normally there is a "social" central repository, be it controlled by
one person (like the linux kernel) or by multiple people (like the
gnome git repositories). It does not mean it is not decentralised,
many people can (and do) have repositories spread across the internet
and the central repository can be moved from one place to another.

In a "truly decentralised" setup, every repository can sync any other
repository. So you just provide a public repository and sync with the
rest of repositories. It does not scale with a large number of
repositories, so it is easier just to declare some of the repositories
as central (like the Linus' repository and the subsystem
repositories).

In the linux kernel setup, there is a central repository, Linus'
repository, with its public repository at kernel.org, and the
subsystem repositories (x86, mm, usb,...) normally at kernel.org but
they can be anywhere else. Everybody syncs with Linus' repository, and
when you work in a specific subsystem you sync with the central one
and/or the subsystem repository.

HTH,
Santi
