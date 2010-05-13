From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: git-svn uses uninitialized value $lc_rev at line 1141
Date: Thu, 13 May 2010 02:06:53 -0300
Message-ID: <4BEB88ED.3080609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 07:07:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCQdU-0000q9-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 07:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab0EMFG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 01:06:59 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:32977 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0EMFG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 01:06:58 -0400
Received: by qyk1 with SMTP id 1so1068458qyk.5
        for <git@vger.kernel.org>; Wed, 12 May 2010 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=3WrPNNzvnD2Uo8yfJSoHA/56R871vwZbOn9GxJw/FjY=;
        b=tqMHPdz/jhwU24EKMfe2XB1kcoJohDz20fLw5AZkKDOHH5IIXY3oZK8fA1z0eVJh2q
         ju9K9Qx9ZZ9lxjAHZJoWBuFVYVTjRmRistHfWRsEpolKPRI36JPruw8DPFunx7V6DmiE
         6zHf4Ft4V1sbNk1Gz4LWul8hCX6Uo/BHM2NjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=LpkGGa99dZBaUXil3oqOELlpiiHaaap4a8UERXoDTyCxt2qnjCXdWOx5lN+xRh0cCW
         qTplIm/fs2hWzLqhseNguGXa+5Bh0WWyIOti4JcZ4dwnxh5pzUTBo5pPmnF6PlaM6aIs
         n9LbN1W+7sUKxWdoHWWKxLmOVJDMPzV7PJXd4=
Received: by 10.224.107.138 with SMTP id b10mr5773888qap.93.1273727216995;
        Wed, 12 May 2010 22:06:56 -0700 (PDT)
Received: from [192.168.0.2] (hlfxns0169w-142177058040.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.177.58.40])
        by mx.google.com with ESMTPS id 23sm557466qyk.3.2010.05.12.22.06.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 22:06:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146977>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm using git version 1.7.1, and found a tiny bug:

mikelifeguard@arbour:~/git/perlwikibot (master)$ git svn info
Use of uninitialized value $lc_rev in concatenation (.) or string at
/usr/lib/git-core/git-svn line 1141.
...normal `git svn info` output...

Cheers,
- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvriOcACgkQst0AR/DaKHsqSwCgzgLfkFDO+5PLedIi8Ud1s9eH
I3YAn1vr0abiUaxCDX8NfL0KPWwTgnF2
=TOzT
-----END PGP SIGNATURE-----
