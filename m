From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/3] cat-file: add "--literally" option
Date: Tue, 03 Mar 2015 15:40:19 +0530
Message-ID: <54F5888B.7040400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:10:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSjme-0003nL-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 11:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbbCCKK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 05:10:26 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:37702 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbbCCKKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 05:10:23 -0500
Received: by pdbnh10 with SMTP id nh10so21447541pdb.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 02:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=nUblw9vQ2jg5RjwUfnEs+q1NRgFaxrYVvnvQTpSvz0M=;
        b=KzufgTqXJXBPioUbj/0AtdLU6dc90qAHv3PTolXMbddUTD1nJOAwBaelbyx008mTD5
         47r9wZkxMjIDsT2jNgcN4y8VyE3/ANL7ncglJhkwqPy1zF2XYgmjjxYLw+3OejbdQnvD
         c4Ftv7IsYFLLAiPH28uE6yXwBSs8pM6CDxO3eECXULrg6zCnOG2GSnyL0GDmpqM9PJGs
         G4pPL+qpU2ZXJo+LiY0vW2JT420IGne+8gTfu2eEYowSX7P+j/1JQ39Va4L034iryyHU
         iv1ZcOMiG4S5GRXS1laZON3Y1XUo41IqcD0EeLGXtniqN70p1pa5YMkSBGBWLYufcQg5
         W0aw==
X-Received: by 10.66.55.74 with SMTP id q10mr54921270pap.94.1425377423289;
        Tue, 03 Mar 2015 02:10:23 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id fx10sm489290pac.35.2015.03.03.02.10.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 02:10:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264642>

Second version of the patch submitted to add "-literlly" option
to "cat-file"
http://article.gmane.org/gmane.comp.version-control.git/264383

Thanks to Eric, Junio and David for suggesting changes on my
first version.
