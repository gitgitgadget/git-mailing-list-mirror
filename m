From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2016, #04; Wed, 20)
Date: Tue, 26 Jan 2016 10:47:57 +0100
Message-ID: <C1F7518D-3898-4F53-8BAD-60B5648D4B5B@gmail.com>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:48:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO0EJ-000780-FP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbcAZJsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:48:04 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33122 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933692AbcAZJsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 04:48:00 -0500
Received: by mail-wm0-f54.google.com with SMTP id 123so98281829wmz.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eiIKN8XW6p4aY0II+S1PjFjPDHstYcbNlcoRAye2HnM=;
        b=e0dzPJfxMsT2tgOL6Dea7XIr7FZLqWe9C+bGPAmlIxuL2ToUS+77g3Dypi6k4/YJws
         UG8CXSdrjMTbcceLb5JwsXIzm4CRDLcDZHmue9rlUGEblIMAnC0klQNPGr+5CxvSCMTc
         MEUs2wQuQCCpbRMfc/QwPEphohDsuAiuZt6OYm8Oi4PjSTwj19vzYrn0a411urbk0a3a
         Nc+ddBYeZCBNa78Ihg+QZXrkYK5W8gjsuC0NO8imGWcGB71bG5DC/dOCH5XnIiFz9sVU
         bT4Ky1DrOgoAnX4ySaRMQHXFj4E8UpxEbjCjGf9viqBh3AuhjpxtnMTe+145vLaJxDO8
         6IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=eiIKN8XW6p4aY0II+S1PjFjPDHstYcbNlcoRAye2HnM=;
        b=QJvjHAkaVBoNN1UFJdM5gYFSNQTaOMew7cXqUyIxrSpBpDa9c4cshYLCdZ6P7vEE5Y
         nPEI9/hi5bsIBFLbppN+ZG1ibOimoA09erYFYb7U5/NP6nLE1KFIuSxQXeMCiviWEs+N
         I63sPmmIqdq/k84qeVkwYaLWA7IgTgdmOq+lq3rR8rs2MWtghiiQsvLAL4SyJHcY4tWB
         xnO+9OA/oW2LlykgcO9K86XAu8Bt9QTQRjjK4lCNb3Esqlxuc7FNXwAWFoXw2zHUcAot
         EOzfZBv7fztbhZngxCSXBJ6KE8nXYE5m/96W6Vpv1UMX64VrMlSZi5pNO+muGtQogDac
         VDQg==
X-Gm-Message-State: AG10YOSVK5/zD2OBNqSm09iLHKhnF4NvIO/4pmTZZ6WfWnW7rUYDxrIOZGHtkHJNJGgiNQ==
X-Received: by 10.28.180.193 with SMTP id d184mr21937808wmf.64.1453801679029;
        Tue, 26 Jan 2016 01:47:59 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA9B5.dip0.t-ipconnect.de. [80.139.169.181])
        by smtp.gmail.com with ESMTPSA id i2sm561819wjx.42.2016.01.26.01.47.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 01:47:58 -0800 (PST)
In-Reply-To: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284797>

On 21 Jan 2016, at 00:33, Junio C Hamano <gitster@pobox.com> wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> The tip of 'master' now has second batch of topics merged, some of
> which should later be merged to 'maint'.  There are a few topics
> that are v2.7.0 regression fixes still cooking outside 'master',
> which also need to be merged to 'maint' for the maintenance release.
> 
> You can find the changes described here in the integration branches of the
> repositories listed at
> 
>    http://git-blame.blogspot.com/p/git-public-repositories.html

Hi Junio,

Did you miss the topic "submodule: extend die message on failed checkout with depth argument" or do you not agree with it ($gmane/282779)? Stefan Beller reviewed the commits ($gmane/283666 and $gmane/283851).

Thanks,
Lars