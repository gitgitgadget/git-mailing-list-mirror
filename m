From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH 0/2] Create a shared config file
Date: Sat, 27 Nov 2010 09:00:41 -0600
Message-ID: <cover.1290870041.git.nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 16:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMMne-0006E8-NB
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 16:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab0K0PeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 10:34:09 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65383 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab0K0PeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 10:34:06 -0500
Received: by iwn35 with SMTP id 35so661819iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:date:subject
         :to;
        bh=eJwh481VfzpMUryrVLavfcOXGeAw0ATzTuvEULODeus=;
        b=wdxBfmfkITTqalPvSwJtMZDkQ9KzqT37uZNta2+f4htLi82qHZuKHuSPwqxL8uLpNq
         xVExuMXw27+hBDqbmHssVCjj4Shdv1A1oE8dLtGrQ0GNmtNhGeSOTDpg5R3ec3ZQCteI
         euRnwtCjbbiDN+5OPYJ5POdNa3X5RO2gGys20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=gf2c3k25DwC+MdkdPbwawDAHCvDu0Ck7GgYvljAGxAEc9nuf2b7bFhvLNLOnBjMas9
         nXImTwKLhFRm/ndEbvJiZkeBaYiMEpMoe4W6tBiAyhYZ05siLFMKyUzSpBULp7MrAnXu
         spr9jGC9rG20aiyB0wdgWShSIpGV5vY9OmLF8=
Received: by 10.231.182.13 with SMTP id ca13mr3070421ibb.16.1290872045215;
        Sat, 27 Nov 2010 07:34:05 -0800 (PST)
Received: from localhost (ppp-70-226-163-137.dsl.mdsnwi.ameritech.net [70.226.163.137])
        by mx.google.com with ESMTPS id i16sm3483791ibl.12.2010.11.27.07.34.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 07:34:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162309>

Configuration should normally be on a per-repository or per-user basis.  There
are cases where it would be helpful to have a project share configuration
across repositories and between developers.  Normally this happens only via
e-mail or IRC or by word-of-mouth.  The solution implemented by these patches
is to have a .gitconfig file in the toplevel of the repository.

This is not a finished implementation, as I have no tests written.  Instead,
this is ``one way to do it.''

Nathan W. Panike (2):
  Add support for a shared config file
  Document toplevel .gitconfig file

 Documentation/config.txt |   11 ++++++++++
 builtin/config.c         |    9 +++++++-
 config.c                 |   49 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
1.7.3.2.347.gd33a62
