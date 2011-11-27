From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: gitweb: 404 links on some blob pages
Date: Sun, 27 Nov 2011 05:03:30 +0100
Message-ID: <CAKD0UuxBO_Uj4dHr9g3zryO=03_ds0omFFnGY89_MPJGfxLZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 05:04:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUVyD-000285-Oz
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 05:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab1K0EDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 23:03:53 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41151 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab1K0EDw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 23:03:52 -0500
Received: by wwp14 with SMTP id 14so6485321wwp.1
        for <git@vger.kernel.org>; Sat, 26 Nov 2011 20:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=5d0YOeskBgntFbKHv5NmzCK+IWCugNgSW9lIXGdmdgo=;
        b=AQFcWv9XVG6Lnz/0Ixg8FxsFzNSrJa6Vcfzzxz44zjRoPjSCGYqfnw96dbhwZ5coSG
         TTS5dTSuImaPwc2BkzUiJUrTYizr46TYzIJ0DoVEuwg9/BvKkp9tp1tJKn4dJ7IbSNHr
         l9uGqDFWYrynf4Zi9LjF2F9kidAp+IolbQrrI=
Received: by 10.180.24.65 with SMTP id s1mr39860774wif.59.1322366631046; Sat,
 26 Nov 2011 20:03:51 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sat, 26 Nov 2011 20:03:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185965>

Hi,

some blob pages have broken links:

=46or example, on
https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob;f=3DClasses/Win=
dowController.m;h=3Db84d1882cb6c3a2d2058cbdd56b2280b48f1690a;hb=3Db84d1=
882cb6c3a2d2058cbdd56b2280b48f1690a
the blob_plain link for WindowController.m leads to '404 - Cannot find =
file':
https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob_plain;f=3DClass=
es/WindowController.m;hb=3Db84d1882cb6c3a2d2058cbdd56b2280b48f1690a

And the tree link for "[contactalbum.git]" leads to '404 - Reading tree=
 failed':
https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dtree;hb=3Db84d1882cb=
6c3a2d2058cbdd56b2280b48f1690a

Here's a page from git.kernel.org which shows exactly the same problem:
http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next-history.git=
;a=3Dblob;f=3Ddrivers/Makefile;h=3D91077ac6b1564a21449a155cde1b84d6678d=
6e13;hb=3D91077ac6b1564a21449a155cde1b84d6678d6e13


J=C3=BCrgen

--
http://blog.blackdown.de/
http://www.flickr.com/photos/jkreileder/
