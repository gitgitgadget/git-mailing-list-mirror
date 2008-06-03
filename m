From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr
Date: Tue, 03 Jun 2008 02:59:38 +0200
Message-ID: <4844977A.60003@gmail.com>
References: <1212276975-27428-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 03:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3KtP-0004oR-PB
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 03:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYFCA7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 20:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYFCA7g
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:59:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:22267 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbYFCA7f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:59:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so890069fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=YG5bhvVsUG+ePHgZx57U2RmiCOuqJ+8Q65LyiSZRVPc=;
        b=K/pDmRAC1Nce914znl/hLaGunlYrBo0Zl2MWFXRtNkKLv8tX0pvUl52zViQSAV1jkThJ6B/Z2XA1K0lczfgPGqHCBltOF29QHMJijO7pb4t0R2Xa6gseIhPyV2J3pUmlj0ATfDHRhmZCcI6e2RLpn8apYl+r8F9vE8LhxcK8Bcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=d301lByaCVXGROJOZ64swlLQU9GGCPHN0SlNE4CsqFoCfDFAAzbkwEtXlCc7M4EAqQM6gZf2h5Bs5ugWUi4ZHxqTkuow7VVEd1d3Tyr4dCoB+Wyj/JV7x0zKChn7xyLnrNKjcYEwfj+TYXhZJOrDhtDLcfoEGFiFi0XGQakas/k=
Received: by 10.86.87.13 with SMTP id k13mr728147fgb.1.1212454773850;
        Mon, 02 Jun 2008 17:59:33 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id g28sm11913697fkg.1.2008.06.02.17.59.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 17:59:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212276975-27428-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83607>

Lea Wiemann wrote:
> [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr

Please don't merge this patch or the "test suite for Git.pm" patch -- 
I'll rather stay on my branch for now so I can easily rebase and change 
things.  Comments are still welcome, of course.

-- Lea
