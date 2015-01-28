From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v9 0/1] http: Add Accept-Language header if possible
Date: Wed, 28 Jan 2015 21:04:36 +0900
Message-ID: <1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:57:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGeMC-0004g6-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbbA2B5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:57:14 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34477 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbbA2B5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:57:13 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so32506809pad.10
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 17:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cho/eYFvORKEppZVMiSZXbuPrhiCXntJ2ji1ZsPDbrg=;
        b=ZZCxCkOTi7CUl2c+yUX8nBNQeZawyMCBcynb092jPywPuQe63UAEd8FELoiZq9PFoV
         U0yuHT7s7qrNfg8iuOyM6towozi3gtQGrdgtDbgy94CqowDUmsEcD770PbRWbO7/FE6L
         uwcLOtP4kcpI+HV9kxVfc/QUFltI5ghLO1HcnHrP/lFCEOP8LhOzo7RtFSCQtvPjvzbv
         iWb9a8XjhVBn5FIn1B9Owk0xmMWrY/3XXpl27rDZTw2n5NzDWvsIGj7Gdfin+3WrUXoL
         w9IExi0RxlQRhWC1Ls64VOwjumemQe+6d3a6e/YxWA81r4rMtUYfCJDTstuTg3DW3CEV
         LyWQ==
X-Received: by 10.68.57.165 with SMTP id j5mr5295696pbq.70.1422446686600;
        Wed, 28 Jan 2015 04:04:46 -0800 (PST)
Received: from gmail.com ([111.91.137.67])
        by mx.google.com with ESMTPSA id fr11sm4614680pad.1.2015.01.28.04.04.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Jan 2015 04:04:45 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.3.0.rc1.32.g7a36c04
In-Reply-To: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263131>

From: Yi EungJun <eungjun.yi@navercorp.com>

Change since v8

Apply Junio's patch: Use an array of char* instead of strbuf for language_tags.

Yi EungJun (1):
  http: Add Accept-Language header if possible

 http.c                     | 147 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  42 +++++++++++++
 3 files changed, 191 insertions(+)

-- 
2.3.0.rc1.32.g7a36c04
