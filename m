From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 0/8] ref-filter: move code from for-each-ref
Date: Sat, 30 May 2015 22:45:55 +0530
Message-ID: <5569F04B.4040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 30 19:16:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YykMh-0006mJ-4b
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbbE3RQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:16:02 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36455 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbE3RQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:16:00 -0400
Received: by pacux9 with SMTP id ux9so39113935pac.3
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=vNDL7OMRES8QMsPTPO1LadJulD7ZmHaCRomSoldn8AI=;
        b=YHYyRWgbLENI6J2xdeMT/TojOeo2FconPJY5repSsQMrTY+7Nvyr0vpvWlA+iUEhqp
         5IzQdcNwhNL82W1wcX6IjnhtQCtLG4Hu1ipB3arzTqDM/qAmqLw10h6+2rd8sESGe+c1
         Il0ZZZDbfKDW4aAvCYodIAOGSPjqR2HrZ4MFVlqDx5FJtFvX3z0p13nvusSnR/fh4OO0
         Hzh14k0WPD/6BU26gv9uIf9qW8L4bA1JIpjsV1vC6uesEoXN6a4NcHFh5I+VOH44EOvK
         GMZ+9dtnLuhlGVHrfigLref0qFlWjYsddPXUUMFMKXzx93VY2SDzFhTFtyi5OSGkPyes
         DnZA==
X-Received: by 10.66.136.170 with SMTP id qb10mr25329991pab.56.1433006160225;
        Sat, 30 May 2015 10:16:00 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id v2sm9234877pdn.90.2015.05.30.10.15.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2015 10:15:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270293>

Hello,

After the third iteration of this WIP/PATCH series ($gmane/270164). This 
is a follow up.

Changes,
*	Subdivided some patches.
*	Spelling corrections.
*	Small changes.

Thanks all for suggestions.

-- 
Regards,
Karthik
