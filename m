From: larsxschneider@gmail.com
Subject: [PATCH v1] t9821: use test_config
Date: Thu,  3 Sep 2015 11:34:46 +0200
Message-ID: <1441272887-72633-1-git-send-email-larsxschneider@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 11:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXQv1-0005Om-8n
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 11:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbbICJev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 05:34:51 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33177 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbbICJeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 05:34:50 -0400
Received: by wicmc4 with SMTP id mc4so13352434wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Tfzxkcoj7mcOm09SQJNFYoDUYcmGZTJ9JcL0aN1eTEQ=;
        b=OFfhlzstHlaZ3j3EA+KUS4Fwn2T9U0kZAv03+REIy44Bq6cJJR9+Kxs3cFKHJaq8QT
         awwIKwSQyP3iWIKO8CKpG6dnsF1kjFVWtlBSFWt02bwHcuLRmVoPGBEapd+RBDIS5utO
         xQc5Wsgero+q0DWK0mdUhs81gCt5Nz+66U3/RH4xL/Z8vJL6nOSvgz/es74IZ+2wpneg
         +bms1oRhU3oRd9gvnZHDgdsa0tbIgynGW4uJEEEh3Rupcz+igIEuumv6dC6x981kf+gv
         RtnIXnIN1RM8XXmGa605p+mQWTIKjOCNMjfq/2AarWmhIMzk7I1zixWm9u6oq2Ofr+2h
         AUSg==
X-Received: by 10.180.215.8 with SMTP id oe8mr4849400wic.0.1441272889304;
        Thu, 03 Sep 2015 02:34:49 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id uc12sm8016047wib.13.2015.09.03.02.34.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 02:34:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277191>

From: Lars Schneider <larsxschneider@gmail.com>

Thanks Remi for pointing out test_config to me!

Cheers,
Lars

Lars Schneider (1):
  t9821: use test_config

 t/t9821-git-p4-path-variations.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--
1.9.5 (Apple Git-50.3)
