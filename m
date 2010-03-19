From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: dcommit-ing from a split repo
Date: Fri, 19 Mar 2010 18:52:35 -0300
Message-ID: <4BA3F223.1090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 22:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsk84-0003N7-BL
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 22:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab0CSVwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 17:52:45 -0400
Received: from mail-iw0-f176.google.com ([209.85.223.176]:58092 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab0CSVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 17:52:41 -0400
Received: by iwn6 with SMTP id 6so387350iwn.4
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=4jOsayHyQJ9wNaFD03hWlXsQA22tCrVuqwuvTvoxeB0=;
        b=V5A3q6J4s7p0ugQdaV4vmoUuSWjmW6EiEzq4Tu14+6XdSY1NYIM7Z8OB4EizRCRZvz
         BUpJFApq3sY9rnnEhOQ8aQueO/4C8NfG75veTD+AFJLayoaru/qGVuq5JZ/CGEIZuv8R
         AunqU+XEaSLn91M1SlrftsaCxCEVWIu0ih6oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=Jiptu309R67uARz37n5+LtyIpeVbA/jXqX9rHcv6YjvzZnxCoYgMrFU+VqSOsf7FfE
         HAvg5p3EYhaF0avk+9z4DlLJ/RMe4GK4hhRCUn+h7q9cJIG/60lK0VLm0MHazHuGcbcI
         5dHDUQx9LOtbuw/zjTlOJ090EiB2rnGFlIoD8=
Received: by 10.231.167.204 with SMTP id r12mr1497947iby.31.1269035560568;
        Fri, 19 Mar 2010 14:52:40 -0700 (PDT)
Received: from [192.168.0.4] (hlfxns0169w-142068093155.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.68.93.155])
        by mx.google.com with ESMTPS id c21sm873746ibr.4.2010.03.19.14.52.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 14:52:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142654>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I've used git-svn to clone a SVN repo which has multiple projects in it.
Then, I split it with git-filter-branch. I guess these split
repositories don't have the information about SVN, so doing git-svn
dcommit fails.

Is it possible to provide the required information so a dcommit will go
to the right path in the SVN repo?

Thanks for your help,
- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuj8iAACgkQst0AR/DaKHtfCACfUDCISoPYFCURDcIpM7q3/p7F
eKYAoLY6klwff0KVIJmf4DYg2T0fYhzJ
=gjfS
-----END PGP SIGNATURE-----
