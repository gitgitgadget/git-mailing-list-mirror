From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Sun, 12 Jun 2011 12:28:47 -0400
Message-ID: <4DF4E93F.1020707@gmail.com>
References: <4DEB495F.9080900@kdbg.org> <1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com> <1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 18:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVnXP-0001OD-SO
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 18:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab1FLQ2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 12:28:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64207 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab1FLQ2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 12:28:53 -0400
Received: by iwn34 with SMTP id 34so3284557iwn.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ejxj0Av/fFWu43BT0n6EKPf4cstLV6zIfpj4qHLINyY=;
        b=tQ6tusAzfwO5NWbAs7ZcclHQSZ0AqZtoa3yrPmrELFqNzwP8JmNLUE2dWKU110POMy
         OpKOueCx2H263PxRxTnjI+s+gNVL9kG5uLujyaxfR+tDtE/qMEjOtBiYD8PNVakUEmwO
         xhfiPAtlYR6bhF+UfOKwgNvQAIlgzfs0mvowU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YCj+Uj6H4DP+2M2hSp2abYhn1VP4S+Jo5s2zJTDjCehD2ltAEnXa2AHFmmJspysPmK
         P4DXZWGeXo/oUG6X9leLdaUq0Ym2zkcFpZk3IZh54ZsAd0CiPnPXLyId63AaLpPVwb5d
         Y+d9/ktsn3zgILM9oRO0oh0Zcr36F5HRwpYG4=
Received: by 10.42.96.10 with SMTP id h10mr5821717icn.485.1307896131656;
        Sun, 12 Jun 2011 09:28:51 -0700 (PDT)
Received: from ZanarkandMac.local (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id in11sm2357559ibb.39.2011.06.12.09.28.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:28:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175662>

Any chance we can look into getting this patch into git?

http://permalink.gmane.org/gmane.comp.version-control.git/175185
