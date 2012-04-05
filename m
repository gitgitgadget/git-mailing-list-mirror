From: =?ISO-8859-1?Q?Jos=E9_Mar=EDa_Escart=EDn_Esteban?= 
	<ripero84@gmail.com>
Subject: Static gitweb content when using pathinfo
Date: Thu, 05 Apr 2012 15:54:27 +0200
Message-ID: <4F7DA413.2020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 15:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFn94-0006XU-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 15:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab2DENye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 09:54:34 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38395 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2DENyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 09:54:33 -0400
Received: by wejx9 with SMTP id x9so877346wej.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=JGuLF0PghZqpjt/sK/seCn765kCbrRvXC+p+zO1YSrw=;
        b=cBq29yIB+G1UGItbfHs9JbVRJorEKNCzOCv0e5wNJN+55TsidlvGRoiA8oN4UC5E4z
         ZmlpUpzaYFdQc//VM9SkfYY98kWig+Oy3qBEVQSt0IW4cYuWbDMwavjRcsKQoyvQclMV
         QzztlhyRIZGW3IA683bZkPOmNep6scJnKkzNtCceRPrB2pEDOjl3373AvwAnvQCRoLV2
         JfVaWxEPb7NXa/ug9AliSJsT9nm7GCK0/UYZz4ELPm0OXAtdOCmDNUlE+t+hE+Lb6psV
         QGESYLYC2/KB7+p7uSPHlK1f1wHLohEvpaCbPxVJNiX4vdqeF5pR8dqzO+CsYtAPPWfz
         uuUw==
Received: by 10.180.88.199 with SMTP id bi7mr5119701wib.12.1333634072162;
        Thu, 05 Apr 2012 06:54:32 -0700 (PDT)
Received: from [192.168.3.8] (AToulouse-552-1-140-126.w83-203.abo.wanadoo.fr. [83.203.91.126])
        by mx.google.com with ESMTPS id gg2sm17355737wib.7.2012.04.05.06.54.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 06:54:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194774>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm running gitweb in a server.example.com/gitweb/ scenario.  If I don't enable
pathinfo everything works fine, but when I enable pathinfo the static content
stops showing up in the browser.

I'm not an HTML or perl expert, but I think that this may be due to a missing
slash in the construction of the base tag:  Using the upstream script I am getting

<base href="http://server.example.com/gitweb" />

and no static content.  Once I tune the script to add a final slash to the url

<base href="http://server.example.com/gitweb/" />

the static content shows up again.

Maybe I'm doing something wrong (am I?), and possibly this can be solved from
the web server side, but maybe it also makes some sense to include in the script
some check that the url used in the base tag ends with a slash.  In that case,
given my lack of perl skills, I would be really grateful if somebody implemented it.

Thank you for your attention.

Greetings,

	E.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk99pBMACgkQY+7weQMem3y28wCeOotCIgFF8sT4LKgq599IhB/E
0qcAn2dri0Z61PjV90bxfBG1QMFD3c75
=6PBz
-----END PGP SIGNATURE-----
