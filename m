From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Add MinGW header files to build git with MSVC
Date: Wed, 23 Sep 2009 03:03:35 -0700 (PDT)
Message-ID: <a416a9d0-90f3-40b7-bd39-ea67ceb2e0b9@j19g2000vbp.googlegroups.com>
References: <cover.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, j6t@kdbg.org,
	lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 12:03:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqOhL-0005eH-An
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 12:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbZIWKDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2009 06:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZIWKDd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 06:03:33 -0400
Received: from mail-yx0-f165.google.com ([209.85.210.165]:60917 "EHLO
	mail-yx0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZIWKDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 06:03:33 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2009 06:03:33 EDT
Received: by yxe37 with SMTP id 37so545051yxe.33
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 03:03:36 -0700 (PDT)
Received: by 10.150.27.5 with SMTP id a5mr256131yba.16.1253700216564; Wed, 23 
	Sep 2009 03:03:36 -0700 (PDT)
In-Reply-To: <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com>
X-IP: 91.64.214.160
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.3) 
	Gecko/20090824 Firefox/3.5.3,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128978>

> From: Frank Li <lznuaa@gmail.com>
>
> Added the header files dirent.h, unistd.h and utime.h
> Add alloca.h, which simply includes malloc.h, which defines alloca
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>

[...]

> =A0create mode 100644 compat/vcbuild/include/sys/utime.h

Have you considered simply including MSVC's sys/utime.h here? From a
first glance, it seems as if it contains all required symbols.

--
Sebastian
