From: "V.Krishn" <vkrishn4@gmail.com>
Subject: Stalled git cloning and possible solutions
Date: Fri, 30 Aug 2013 01:18:19 +0530
Message-ID: <201308300118.19166.vkrishn4@gmail.com>
Reply-To: vkrishn4@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 22:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF8P9-0000oh-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 22:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab3H2UBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 16:01:15 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:35011 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab3H2UBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 16:01:15 -0400
Received: by mail-qe0-f50.google.com with SMTP id s14so476815qeb.23
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:reply-to:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=F1iqVYKB7gFytV2Q7mQFziPuc6C3bcoOWW0ivl4Tbtw=;
        b=CJOp1jpoCEMrG6+QTEsi8DDPTwYmbkv3SjJjPC4/j0X1DX9tugY0pEXd4rdi7mlieH
         aVdqtfBhELLTUJ0btEPlsuM0yVwJbLuHU1PfJR+cxWjOfFSUTeLTcNfM+LduPJWWhIeP
         MH7xW+t3/B9O41YqAr2Y+UgxylMPaKUBm76a7dWHAbMJB5vfEvgVrmAl9zWsDvUUA6/l
         qiEQ+EYUfxHQqybFbv+gNXpAqnihFGHIARSGUzDsun8bjjpbaCt04nDvLBDKlrNAAQGO
         5Dy6ULzKDdLVMUDdRaD4LEQ/FWEhj8CE/G9Z7molKo3zau8NZkRUiaBMZXCwk8Iviqau
         SpHQ==
X-Received: by 10.224.69.2 with SMTP id x2mr7055653qai.77.1377806474262;
        Thu, 29 Aug 2013 13:01:14 -0700 (PDT)
Received: from microknoppix.localnet ([117.227.33.153])
        by mx.google.com with ESMTPSA id y6sm46468040qaj.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 13:01:13 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/3.3.7-64; KDE/4.7.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233353>

Hi,

Quite sometimes when cloning a large repo stalls, hitting Ctrl+c cleans what 
been downloaded, and process needs re-start.

Is there a way to recover or continue from already downloaded files during 
cloning ?
Please point me to an archive url if solution exists. (though I continue to 
search through them as I email this)

Can there be something like:
git clone <url> --use-method=rsync

-- 
Regards.
V.Krishn
