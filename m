From: Phil Susi <psusi@ubuntu.com>
Subject: Merge after rename
Date: Thu, 09 Jul 2015 16:44:35 -0400
Message-ID: <559EDD33.50906@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:49:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDIkD-0008RA-B5
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 22:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbbGIUr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 16:47:56 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33472 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbbGIUpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 16:45:16 -0400
Received: by ykeo3 with SMTP id o3so126044305yke.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=MhHXf6LGfGvuNA9EkRWcPH1vNQwmt2wEVn/oGuq6OnI=;
        b=V6maTBfynrfRTcdig5/brGWsadRxGrKLTi38xALLG3F9gLJajJk5YG3BlaBxCvUV+U
         44yhYSG0x76X4CX+Mu9imU9mYCRqnPBu1NNlP97Oe2eZDC9vOzd9P2Rko5BVKQJLAWJf
         HInKk1H2b9qu9KNzeDH5LD5Hoz0ckRtfwmi3crxMargPrYCI8cNavNSrVk8c/Wm3utZ+
         dw+4qgUOnjEnmOlZ9f7HpktLAuv9cBODZolPV+WuaqBZo0urAftGUFKDSOQIbbIhs4TF
         pvQBpMZUv9j//90X9KYWEbO0dRr/jzY2ygHmM5IDUSd9Kmc/527K9PxQsGrTQajt80bM
         VLSg==
X-Received: by 10.170.170.6 with SMTP id m6mr19628919ykd.102.1436474715829;
        Thu, 09 Jul 2015 13:45:15 -0700 (PDT)
Received: from [10.1.1.233] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by smtp.googlemail.com with ESMTPSA id r205sm6531547ywr.25.2015.07.09.13.45.14
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 13:45:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273776>

I'm trying to cherry pick an old change from an old branch onto the 
current master, and since the old change, the directory structure was 
altered and the modified files were moved.  Instead of detecting the new 
location of the file and applying the changes to it, git is re-adding 
the old file at the old location in its entirety.  How can I get it to 
correctly notice the rename and merge the changes in at the file's new 
location?
