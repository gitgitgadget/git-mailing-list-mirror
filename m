From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/12] Create ref-filter from for-each-ref
Date: Thu, 11 Jun 2015 21:37:47 +0530
Message-ID: <5579B253.4020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 18:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z351K-0004o1-SQ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbbFKQHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:07:54 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34449 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbbFKQHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:07:53 -0400
Received: by pabli10 with SMTP id li10so2395763pab.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=rKhES+mbkIolE7LmHazgFMFgGfTeVt/xtZExjwE8Deg=;
        b=zFZlFefLRO98Gik8lVYPmdxjgwlh02hYuaNTWNkfC/LhwC+tWzn/u4vpzZuhcEhw9Q
         eK81xQGeMfGksY8Ve4mI8Fijqy/8gyeSDuTYqHK8x9kQgGFj4XBSiBehNRLYMnZembFf
         WNBpVcUgdFvJ4PZ4Tc1NoQ3nFOG8LUwEbKgouS7fG26npAd8FU5OsqM2KTrHbA3Idgj2
         K40g1Qn1rZlK1zUNhex0AxXJI5KTvlJb3rFSAKBpdt0pbQJDw91G9oVnGT8FQxelQr0m
         M8OANPJdYNSSsWMei7sYsgVCLcZCfyNzVzsM1dP/1FoQx9VUfq4KslSirSqRw+nG0nm4
         Whcg==
X-Received: by 10.66.229.65 with SMTP id so1mr15852552pac.92.1434038873230;
        Thu, 11 Jun 2015 09:07:53 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id us3sm1121361pbc.94.2015.06.11.09.07.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 09:07:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271423>

The previous version of this patch can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/270922

Changes found in this version:
*    Various changes to the 'filter_refs()' function.
*    Split 'for-each-ref: clean up code' into two commits.
*    Other small changes.

-- 
Regards,
Karthik
