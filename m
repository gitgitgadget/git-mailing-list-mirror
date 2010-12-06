From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 0/6] web--browse cleanup and extensions
Date: Mon,  6 Dec 2010 18:49:44 +0100
Message-ID: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 18:51:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfDJ-0006OV-Dn
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0LFRuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:50:00 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab0LFRt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:49:57 -0500
Received: by wyb28 with SMTP id 28so12273585wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cPCC04TX51D2YtfBOmVfV3W9McgAchZppARvmlJki5U=;
        b=ZGICCdaE/EBty7E+TnR2AqWegn46GlTLitcvDpSNgzU1wuavEYBNrmuqCA6NoE3/6t
         iwH7o4WUowvp0iL9dazMmdzpCBmEn9/jcquHcDMU36HwCa8jKoIr8XimrYjN1Sfa40h+
         e56CGp012T3iapVBEw3kx9QfK5XTEnsXUUTxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wvT8DabC7i/A9BK5UFuHNkAA4uRh0qi750dqpkp82zT9gFPvQI1c1LumOoa71gBXu7
         hJqWUkVfa2rwKnofm4UtS3jXXgPKmZIOpyoB6SLVYedITeykfm0bvy90GY820GycMzWr
         MXGWi5daOTb+KpYhnkJuRSkMJTAp8gIeIT4NU=
Received: by 10.227.128.70 with SMTP id j6mr6093958wbs.53.1291657796573;
        Mon, 06 Dec 2010 09:49:56 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id y15sm2480717weq.30.2010.12.06.09.49.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:49:55 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163010>

Differences from the previous revision of this patchset:

* the CodingGuidelines patch was dropped, since it's merged in next
* the chromium support patch had some stylistic changes suggested by Junio
* the *www-browser patch adds support for detecting konqueror and kfmclient,
  which required some changes to the version string retrieval code; also,
  readlink is only used if available.

Giuseppe Bilotta (6):
  web--browse: coding style
  web--browse: split valid_tool list
  web--browse: support opera, seamonkey and elinks
  web--browse: better support for chromium
  web--browse: use *www-browser if available
  web--browse: look at the BROWSER env var

 Documentation/git-web--browse.txt |   10 ++
 git-web--browse.sh                |  302 ++++++++++++++++++++++++++-----------
 2 files changed, 225 insertions(+), 87 deletions(-)

-- 
1.7.3.2.664.g294b8.dirty
