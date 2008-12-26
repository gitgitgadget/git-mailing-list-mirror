From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Managing several threads of the same project in GIT
Date: Fri, 26 Dec 2008 12:50:34 +0100
Message-ID: <adf1fd3d0812260350h6da65cf0p164b52407ce6767@mail.gmail.com>
References: <loom.20081226T110416-269@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pggrd <git@paggard.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 12:51:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGBET-0002T8-V1
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 12:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYLZLuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYLZLuh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 06:50:37 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34710 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbYLZLug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 06:50:36 -0500
Received: by bwz14 with SMTP id 14so13661472bwz.13
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 03:50:34 -0800 (PST)
Received: by 10.103.171.6 with SMTP id y6mr3814151muo.31.1230292234286;
        Fri, 26 Dec 2008 03:50:34 -0800 (PST)
Received: by 10.103.219.16 with HTTP; Fri, 26 Dec 2008 03:50:34 -0800 (PST)
In-Reply-To: <loom.20081226T110416-269@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103934>

2008/12/26 pggrd <git@paggard.com>:
> Hello,
>
> I've been studying GIT for some time already, but still have not figured out if
> it can be used for the scenario like this:
>
> for example:
>
> I have a project, which divides to threads aiming to different clients

I suppose what you call threads are branches in git.

> most of the code in the project is shared between the threads
> in certain files there are different code parts to meet client requirements
> but even those files share the rest of the code
>
> What I need to be able to do is:
> - to get code for any thread I like at any time
> - to be able to develop each thread separately
> - to be able to merge certain changes from one thread to another, at the same
> time without loosing the changes specific to the thread, and keep track of merge
> history
>

Git works best with convergent branches, so all branches should have
more or less the same code.

What you can do is to have different configuration for each client (or
Makefile variables), in the same way git supports different
architectures, different sha1 implementations, etc. All the code is
there and you just choose which one to use.

Santi
