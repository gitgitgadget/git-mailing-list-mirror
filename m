From: Mitch Tishmack <mitcht.git@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 01:11:11 -0600
Message-ID: <AD012876-3B4A-41EE-8CCB-F60D5C812903@gmail.com>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org> <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com> <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org> <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 08:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFOvJ-00029H-MQ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 08:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbYAQHL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 02:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbYAQHL5
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 02:11:57 -0500
Received: from hs-out-0708.google.com ([64.233.178.251]:20891 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbYAQHL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 02:11:56 -0500
Received: by hs-out-2122.google.com with SMTP id 54so377622hsz.5
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 23:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=D2QyBM7IbDHmh5XcXNLZgXY6i5ZKlD5k7vWRSUF/jbE=;
        b=tYj++2wMOpR5FT5r2Qs1PZD2bT6uL3vdcRt58yLeb+BmwOjYsHx9KJ0mwNO6p152zgjwRegcdiKMVq5xUEYXsHihn+tx99v85C2j8nHnnhNAcVNC9bzP+0QQWPZQYOslCjMa7h4CxWmEBTvSMf8dcaL1LIIswTGA/ZY7+cfn0ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=KsDzLXhaIFEvdcQQsuWe5skblq+mdvorN0cSrJ8RsIxXWNwaQCSNd+nt51mr/LY5wg5mVvLHxaf1zpcu9AZhXS2Hp0RbKmaeDOsF8+1LQsYCwT1OTKIgprOJfbpwl1PPL5VKabaXSTI4MPaTDoZutK2s+6v3Jj8EaMSC72CA9yI=
Received: by 10.150.192.7 with SMTP id p7mr384466ybf.21.1200553912636;
        Wed, 16 Jan 2008 23:11:52 -0800 (PST)
Received: from ?10.0.1.10? ( [24.118.142.205])
        by mx.google.com with ESMTPS id 13sm2907167wrl.7.2008.01.16.23.11.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 23:11:50 -0800 (PST)
In-Reply-To: <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70835>

I was going to post this earlier, but wanted to search the archives =20
first. Here are the commands assuming you don't want to or can't =20
partition a drive and format as ufs (I don't care for HFS+ much). I =20
can't believe I didn't find the command in the git list archives, so =20
voil=E0:

$ hdiutil create -size 300m -fs UFS foo.dmg
=2E....................................................................=
=2E.........
created: /Users/mitch/foo.dmg
$ hdiutil attach foo.dmg
/dev/disk2          	GUID_partition_scheme          =09
/dev/disk2s1        	Apple_UFS                      	/Volumes/untitled
$ cd /Volumes/untitled && git clone git://git.kernel.org/pub/scm/git/=20
git.git
=2E.. snipped ...
$ cd git && git status
# On branch master
nothing to commit (working directory clean)

After git clone in HFS+ land...
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	gitweb/test/Ma=CC=88rchen
nothing added to commit but untracked files present (use "git add" to =20
track)

Should I just add this to the wiki? Then we can all go back to =20
ignoring the insane filesystems.

Mitch


On Jan 17, 2008, at 12:13 AM, Geert Bosch wrote:

> For those on Mac OS X: it is possible to create a case-sensitive HFS=20
> + partition and
> use it with git. You even can just create a disk image and mount it. =
=20
> However,
> I wouldn't quite try to use it as startup filesystem...
>
>  -Geert
>
> PS. I'm working on a proposal/patch for addressing the UFS/case =20
> sensitivity issues.
>    Will try to mail something later this week.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
