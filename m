From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/3] cat-file: add "--literally" option
Date: Thu, 05 Mar 2015 23:46:48 +0530
Message-ID: <54F89D90.6090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 19:17:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTaKP-0002YC-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 19:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbbCESQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 13:16:53 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38024 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbCESQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 13:16:52 -0500
Received: by pdbfl12 with SMTP id fl12so37040331pdb.5
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 10:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=flnXL+TvxuD6iD+oXhfnKpQZE+JvEj9qWoBxuMWvxpk=;
        b=a2LmxiaZDt/Hl1zfum96qARmpj8AQ919LRh+LgeeaHQCx3xaj4LSbQuNJQiFhmF1At
         u5E54vpEBCwYFLgBgFAOkgUBTuLxnMumHM3gUKWAZeDuE3srobL+GfD1DWiVEq53De4V
         f4V6hXecR8sDerjNIJRZRDLzwA6iQ7P9GAjHpht9GLbiBEowOl7T3ruW/D8EwtASGumL
         Mp3Rqph/WX6/IBeQNYp6IaUDGzvfioONwpIMQl1F+/ShnKeh6btWYh+rzTCEdH3PkLlG
         ycr2q3TVHMoFnne4TRVXQ2wX2+f2qYjE8hBph9vqmrJCOYlPIYMgbXpUFTVpqrG0uzjT
         K0UA==
X-Received: by 10.70.96.36 with SMTP id dp4mr18172550pdb.98.1425579411991;
        Thu, 05 Mar 2015 10:16:51 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id rk5sm7594531pab.37.2015.03.05.10.16.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 10:16:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264853>

Third version of the patch submitted to add "-literlly" option
to "cat-file"
http://article.gmane.org/gmane.comp.version-control.git/264383

Thanks to Eric, Junio and David for suggesting changes on my
first version.

Thanks to Junio for suggestions on my second version.

Changes from previous version :

* Made sure no end-user printing is taking place in
   sha1_file.c, now the printing takes place in cat-file.c
* Did not credit Junio on whose work i based my patch,
   Propoer credits given in the commit message in v3.
