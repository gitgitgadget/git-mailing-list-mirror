From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] pull: allow dirty tree when rebase.autostash enabled
Date: Wed, 22 Jul 2015 12:42:17 -0700
Message-ID: <xmqqvbdcq8rq.fsf@gitster.dls.corp.google.com>
References: <1434538880-15608-1-git-send-email-me@ikke.info>
	<1436046158-19426-1-git-send-email-me@ikke.info>
	<xmqqd205yq98.fsf@gitster.dls.corp.google.com>
	<20150707035956.GA6105@yoshi.chippynet.com>
	<20150722190724.GA11291@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:42:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzuL-0003h8-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbGVTmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:42:21 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36331 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbGVTmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:42:20 -0400
Received: by pachj5 with SMTP id hj5so143427514pac.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DVtin5vlx3NpFUWJ89kbiyGkr8JyN89t3gSF+Xx+Lxg=;
        b=zpshPIBKbhG7Zs655Fu+8yCqAMAX3J/T24cgrxpQJ80HTdjTf3MRKwvJrk1i5AaUAz
         zOiWskBHFtrbW3U6xZZy6M1RHXOBmQTTRPkiId2xgLxeFGidA6JNeYktIZ933oDzUTuT
         cruR6jJnT9Wj5x1xoAmI7X4RtjWxItyLQPlLBMooujYhZWpibsySScXFOh5xgWI2puji
         j/4NJ1rEZwYcxWKB//5ZcEMFUHpvacstLRF4GsyhJEj43WbSyG+MEd/YAa2ePE0TjN42
         qh8SJb7/m3W+FJLGv3qdPzhf7hBrCYOkbXTJdgql8pi8YlZ75bVRzuVBfKCYM4l42Eg+
         M8wQ==
X-Received: by 10.70.90.230 with SMTP id bz6mr9261729pdb.120.1437594139957;
        Wed, 22 Jul 2015 12:42:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2d07:10eb:6a1b:8773])
        by smtp.gmail.com with ESMTPSA id cq5sm4821490pad.11.2015.07.22.12.42.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jul 2015 12:42:18 -0700 (PDT)
In-Reply-To: <20150722190724.GA11291@ikke.info> (Kevin Daudt's message of
	"Wed, 22 Jul 2015 21:07:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274463>

Kevin Daudt <me@ikke.info> writes:

> On Tue, Jul 07, 2015 at 11:59:56AM +0800, Paul Tan wrote:
>
> Any news about this? Is it still waiting for something?

Paul's patch was buried in the noise and I didn't notice it.

I'd prefer to see a new feature like this, that did not exist in the
original, be done on top of the "rewrite pull in C" topic, which
will need a bit more time to mature and be merged to 'master'.

Thanks.
