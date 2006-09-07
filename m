From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] autoconf: iconv
Date: Thu, 7 Sep 2006 13:47:31 +0200
Message-ID: <200609071347.32152.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 13:49:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLIN7-0004Zk-PF
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 13:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWIGLsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 07:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWIGLsi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 07:48:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:62491 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751340AbWIGLsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 07:48:36 -0400
Received: by nf-out-0910.google.com with SMTP id o25so422615nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 04:48:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IL7p+tzyob2aqmac1tkN5p/5k0PWdpUWlJtHjOl8uRB0MffHRmlDxt2WWFwf2T+iNLkRaLXIFMWHb3E+zkdjXjg6wofXuwc27ayF/CQ9+aTaYh2nx8nuWZcPPmDkFDa3EoGG5lFM/1hgFJy17DvBGtQMpVw5Yxyr1HqcPnlogkg=
Received: by 10.48.48.18 with SMTP id v18mr2395234nfv;
        Thu, 07 Sep 2006 04:48:34 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c10sm3234658nfb.2006.09.07.04.48.33;
        Thu, 07 Sep 2006 04:48:34 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26628>

Those two patches add support for remaining iconv related compilation
variables, namely NO_ICONV and ICONVDIR to configure.ac.  First patch
sets NO_ICONV if no iconv implementation was found (autodetection),
second adds --without-iconv/--with-iconv=PATH option to generated
./configure script (user input).

This series is based on my earlier autoconf series "[PATCH 0/5] Some
autoconf patches", but with little editing of config.mak.in patch in
the PATCH 2/2 they could be applied on top of 'next' branch.

Shortlog:
 [PATCH 1/2] autoconf: Set NO_ICONV if iconv is found neither in libc, nor in libiconv
 [PATCH 2/2] autoconf: Add support for setting NO_ICONV and ICONVDIR

Diffstat:
 config.mak.in |    2 +-
 configure.ac  |   18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
