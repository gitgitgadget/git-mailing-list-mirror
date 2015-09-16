From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 11:20:18 -0700
Message-ID: <xmqqlhc6ql99.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
	<55F8643D.6040800@ramsayjones.plus.com>
	<20150915184211.GA31939@sigill.intra.peff.net>
	<CAGZ79kb5qWnOnJGY8JR3Z9UqT2xp390A6-LvNudBk=e3N2W41Q@mail.gmail.com>
	<20150916094517.GA13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:20:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHJk-0002Iq-BS
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbbIPSUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:20:22 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33975 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbIPSUU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:20:20 -0400
Received: by padhy16 with SMTP id hy16so215945636pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DjS96t4qzx2XpH6GzXQL1GKJ5I+3Rg+x9eQOcnjT3D8=;
        b=VMuAs18LOiVulDlDhNypZMSVfd4JAV0wB2ST1GxWMfzuzy6+8bcghaq/Wihv132e5A
         FZe0gwlFVENsjPCvujOi1aRf+44fjNtMSVi6l+Em2KNq8Gli0Il5G5/EHrKNzL56uBSe
         D0CL2+B4ftRIjJIY8Jhr8Hx7qyL/Z6tOzo+Ow65+lWEP3uBTnrCBxPJUWIHq/gbXpgFL
         U8e2EKXzsMxcW6o9Gz7YKSyh3IwjETtSJ1sj2tkK2hGCNA9pd/ERbg9i8J6aeQ56i6Dt
         GKIDkv/+LqGXFqFtEWWxsGquCVUbWFcysT8W4sEu0ppwpf1jI8y7fE/7TdettdYGHOpc
         1K8g==
X-Received: by 10.68.230.33 with SMTP id sv1mr63389542pbc.160.1442427620087;
        Wed, 16 Sep 2015 11:20:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id xv12sm29234636pac.38.2015.09.16.11.20.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 11:20:19 -0700 (PDT)
In-Reply-To: <20150916094517.GA13966@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 05:45:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278044>

Jeff King <peff@peff.net> writes:

> I think a core file is even more useful than a backtrace. Having BUG()
> call abort() would be even more useful, I think.

Sounds like a plan ;-)
Thanks.
