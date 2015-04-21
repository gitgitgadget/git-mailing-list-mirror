From: Adam <adamgsteel@gmail.com>
Subject: Regular Rebase Failure
Date: Tue, 21 Apr 2015 11:16:16 -0600
Message-ID: <553685E0.8010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 19:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykbmc-0001ni-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbbDURQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:16:21 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35518 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbbDURQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:16:20 -0400
Received: by oign205 with SMTP id n205so158475487oig.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=8Yij3QjtTccG5JoNm9EJ00uhnekE29G7/IzwSU8Zpu4=;
        b=a+Ux9C351HBtQzaOA8DUrh+359qRXR8dTIJtVOx1g/f78CIkR4qx23aRdWwhA6GSnY
         WhZn9niAsMDhKZD4DGqNF1VCkOXlIzgcKf3cdjIOYqW5u35nniNp1UffTLupP7UVWMod
         INyuii39zhRgpz3dk+2WD41I/jEY6Zm8TyA5gegcMZ6tg/DwkV99c29aF4AHpI0TUUdq
         6w656t+dYSsVPmbCVpdamKNc5aVcmAqKRronOQaVmSxsGD3w3EdgzCCCISyED5tMCYkp
         2oSH+o6VFTT5o39nMnlS0KuQM0VkBYm/ahoDHDeLh37osQllblSp8H6aiP+pRflFY1bu
         Rkfw==
X-Received: by 10.182.80.103 with SMTP id q7mr20012973obx.18.1429636579993;
        Tue, 21 Apr 2015 10:16:19 -0700 (PDT)
Received: from Adams-MacBook-Pro-3.local ([128.177.172.2])
        by mx.google.com with ESMTPSA id xs4sm1552862obc.12.2015.04.21.10.16.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 10:16:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267534>

About two weeks ago I started getting a regular rebase failure. I get this
error several times a day and at least once a day I lose work to it.
---
fatal: Unable to create '/Users/asteel/path/to/repo/.git/index.lock': File
exists.

If no other git process is currently running, this probably means a

git process crashed in this repository earlier. Make sure no other git

process is running and remove the file manually to continue.

Could not apply 71a...
---
The weird part is that the file does not exist

Any ideas? Thanks!
