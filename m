From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Sun, 03 May 2015 19:58:36 +0530
Message-ID: <55463094.9040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 03 16:28:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yousw-0004Sv-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 16:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbbECO2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 10:28:42 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34860 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbECO2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 10:28:41 -0400
Received: by pdbqd1 with SMTP id qd1so140602446pdb.2
        for <git@vger.kernel.org>; Sun, 03 May 2015 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=PSBiWQdjS5Q3b0Nv/xFBqqGtfq3u22kS914sUVuLgsk=;
        b=dMyF6caZiyNqXV88YjRLSFD4K4b+NSe1BwhDOlqTbixs45n+2Bg1aMqnxBPyZn3fHz
         dWVrvTSFxK3EXNLhm8JYBQ5GSLVR6G1LHvWUAYy6YQBCWWAfu+AozThruABcs/PtJ9oM
         CAnPbDdENgsQuBOlDdqrZcCghRLVqgPbLoVQpgtHIYz47kPt8Z0TCNVVIyVnFEvCcRVd
         +SQxnLLPPCEzuYdls4bU3mlsutcRicEnVFxZcfq0DtE3wgo3m0XBKfZhZYfLUdTsBK/y
         acqGd4PnXjzFvaZnQTj9Gd7UaF4+O7Ygp2ljdrTPWJ8LyBfZBRRhMYR//gZyMbIJ26lF
         jB5w==
X-Received: by 10.68.253.162 with SMTP id ab2mr34652482pbd.62.1430663320495;
        Sun, 03 May 2015 07:28:40 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id d7sm10107135pdn.47.2015.05.03.07.28.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 07:28:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268262>

Version 9 of this patch series can be found here :
http://thread.gmane.org/gmane.comp.version-control.git/267960

Changes made :

* fold the documentation commit with the previous commit.
* Increase test coverage to check for large header types.
* Add a status check in sha1_loose_object_info().
* Grammatical changes.

Thanks to Junio, Eric, Phil for suggestions on v9.
