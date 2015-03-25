From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/2] cat-file: add a '--literally' option
Date: Wed, 25 Mar 2015 12:49:39 +0530
Message-ID: <5512618B.2060402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 08:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YafbQ-000686-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 08:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbbCYHTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 03:19:44 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33392 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbCYHTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 03:19:43 -0400
Received: by pdnc3 with SMTP id c3so19665434pdn.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=gKsAUIQICp7ujRcE858KbWxOCD5m29aCpvA2xrju8RA=;
        b=kuc1F8DZzRChOu9QxnZfC60DQ7+afnClBUkTiEu294CvlaabG62/kxXqSgPANjNDBU
         kx4tGA60uzLE4ClFx5Fd7XdTAE7eC8czSgGZD/m2rX90XjzDL0opQPwW1d4q7gl1shFW
         8yrgN7BgpTVuj2NhhkVrOfobpUrnkytbSKatzhE6Y+6GV9Kd21YttiGzhJV1uVxuuQbj
         JVXidG70zM3vdFQSdsU6WHXMBUKHCY+SFljsayfqzMTw6SMJwlG1fa0Js4XQi8R45KJT
         a8nzUVhbsfzc7bGBcCEGxrQkqcdssn2ftdDo7OSDzapL+l2GdJQlKyutcCofAcDeGYjP
         AGsA==
X-Received: by 10.70.31.66 with SMTP id y2mr14744504pdh.118.1427267983273;
        Wed, 25 Mar 2015 00:19:43 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id sm5sm1425885pac.10.2015.03.25.00.19.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 00:19:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266268>

Based on Junios and Erics suggestion I have made various
changes over the previous iteration of the patch[1].

Changes are :
* polishing of code and commit messages.

Thanks to Junio and Eric for their suggestions and guidance.

Reference:
[1]: http://thread.gmane.org/gmane.comp.version-control.git/265604
