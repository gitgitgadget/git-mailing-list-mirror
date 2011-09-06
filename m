From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: git-svn and mergeinfo
Date: Tue, 6 Sep 2011 09:52:56 -0400
Organization: White Oak Technologies
Message-ID: <20110906095256.205dd5d0@robyn.woti.com>
References: <20110829132052.0ad7a088@robyn.woti.com>
	<4E5F4987.5040205@alum.mit.edu>
	<20110901104327.14d4dba6@robyn.woti.com>
	<1315313800.9839.10.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Carlos =?UTF-8?B?TWFydMOtbg==?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Sep 06 15:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0w5R-00052P-7s
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 15:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab1IFNxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 09:53:00 -0400
Received: from mail02.woti.us ([66.92.158.6]:35446 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753209Ab1IFNw6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 09:52:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id E4312504D37EC;
	Tue,  6 Sep 2011 09:52:57 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1PkgvQ0ZbY5; Tue,  6 Sep 2011 09:52:57 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 5BBEA504D37EA;
	Tue,  6 Sep 2011 09:52:57 -0400 (EDT)
In-Reply-To: <1315313800.9839.10.camel@bee.lab.cmartin.tk>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180800>

On Tue, 06 Sep 2011 14:56:38 +0200
Carlos Mart=C3=ADn Nieto <cmn@elego.de> wrote:

> You can also save the mergeinfo to a file, add the line, and use
> --mergeinfo=3D$(cat /tmp/some-file) to set it. It is indeed awkward, =
but
> blindly replacing every space with a newline is not always the right
> option. If a merged directory contains a space, this change will brea=
k
> the mergeinfo, even if you're properly quoting your variable or using
> the $(cat /some/file) method.
>=20
> Cheers,
>    cmn

Ah, a situation I neglected to consider! Perhaps we should revert this
patch, since I worked up the initiative to write an
auto-populating-mergeinfo patch for git-svn anyhow.

Bryan Jacobs
