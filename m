From: Luke Diamand <luke@diamand.org>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Mon, 23 Nov 2015 09:06:32 +0000
Message-ID: <5652D718.9070201@diamand.org>
References: <20151120140937.GA17079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 10:07:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0n5A-00086X-44
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 10:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbbKWJGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 04:06:34 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38058 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbbKWJGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 04:06:31 -0500
Received: by wmec201 with SMTP id c201so95482509wme.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=IRSkS0k6NIFvKFTHXHVpXBA9IL8Fm+a6q86guirxmLA=;
        b=BdYrnLlGGMPvaJemL7Go+qo1iPMtQuXTeulspbEKNdseZr2aH3QTDatopK7ZCK74dN
         2CFRx9zHKneAZnDv066Nk81eQMHmSvbWczcDqMD3QsPu/CTuJ8PTMibm7dipbiOHp+hV
         w5aLC++kESG6wH/Ck/rDrYFJQnrOns53LpkMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IRSkS0k6NIFvKFTHXHVpXBA9IL8Fm+a6q86guirxmLA=;
        b=INBoH9xOrg0fSg13zx/L1N/ng82Pkjd+vza2kqN+LcJWaYsuoDqpHSrNOEZbt8MZ5u
         J7cdzOCw930y7y2s1b0FDXpmG/LlVWgXbeqleu59lCtXUpBywqXXnFumW982oWO1e3Vm
         sg120CBXKyMpuvDU7fFV6xlvvM/13RsxxHxbCcVRgM2KXteblkSpWkwSE1+pNnOFU5yh
         dLiqMHrzC34C3SSwVAnslig4Us4Gnyu38oOXBa3NYHIdVebcQDDma3T8YFghy6iZQvvv
         DprekgK3TB5qPkgsJIycQ++5VAAjbjFAR6s6uJTefZary7k2lk3WBibtB++obOjoAEH+
         MfUg==
X-Gm-Message-State: ALoCoQkvH7c9rP32P+3hpEX5gksGw6Nf6qSJA8PjsKbAS5EabRz7EOPgEzEv44lonTTGtwhbo6cV
X-Received: by 10.28.147.129 with SMTP id v123mr17980488wmd.98.1448269589974;
        Mon, 23 Nov 2015 01:06:29 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id t5sm12066224wmt.1.2015.11.23.01.06.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Nov 2015 01:06:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20151120140937.GA17079@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281577>

On 20/11/15 14:09, Jeff King wrote:
> What's cooking in git.git (Nov 2015, #03; Fri, 20)
> --------------------------------------------------
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>

<snip>

>
>   Some commits need better explanation.
>
>   Waiting for a reroll.
>
>
> * ld/p4-detached-head (2015-09-09) 2 commits
>   - git-p4: work with a detached head
>   - git-p4: add failing test for submit from detached head

Rerolled on the 21st.

Thanks
Luke
