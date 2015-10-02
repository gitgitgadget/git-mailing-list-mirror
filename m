From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule-parallel-fetch: make some file local symbols static
Date: Fri, 02 Oct 2015 10:45:30 -0700
Message-ID: <xmqqmvw15flx.fsf@gitster.mtv.corp.google.com>
References: <560D20E2.4060601@ramsayjones.plus.com>
	<CAGZ79kZzLtK7+rHRG_misaa9=fWF+oyeryBa+kbD3F+EB=3LMQ@mail.gmail.com>
	<560D7EE2.8060403@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 19:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4On-0001nl-24
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbbJBRpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:45:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35181 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbbJBRpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:45:32 -0400
Received: by pacfv12 with SMTP id fv12so114438342pac.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gb9Kz4VH5UECceQJr9ZDfSP7NrKFYz+O6UL2m34pr50=;
        b=zeCYPG//o7iJTu0rVqGh0aphnFthtHrv95kKN7L7U4kFMQ8ho2FZpgUH8BDg7PvM20
         aFotY8m9XeAl0rVf+y/cZHqJJ1GW/ZmSRH4GteIK1nzBK1hMvlLoFcBXpAiWKg4y1ZlT
         FWaUWPQUoPvI/GeEl32sdp+m6vJF9IGlK1ptmxCARWyNLmKc9Zyy9EKYRA6EXLPNplYl
         3/7A5szJV7tdazaA0n3jaI/TsY997Z76uUwnkVGJZ32Xoi/+6acjIBucmZ9CniaVjznD
         4+ebV6DVq8jYBVTp/8Ng3RbLA8tOjeRF4kePTt386gHa2DV3RD2zKUvEPIYebr8O7frA
         xQBg==
X-Received: by 10.68.218.137 with SMTP id pg9mr21729816pbc.160.1443807932146;
        Fri, 02 Oct 2015 10:45:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id tk4sm13102113pab.45.2015.10.02.10.45.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 10:45:31 -0700 (PDT)
In-Reply-To: <560D7EE2.8060403@ramsayjones.plus.com> (Ramsay Jones's message
	of "Thu, 1 Oct 2015 19:43:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278937>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> I thought I had this in yesterdays reroll (v6). Oh you're referring to
>> the version
>> from the 28th (I forgot to label them v5 I suppose).
>
> Ah! I thought I'd seen it on the list. (I thought I was going crazy) ;-)
> Sorry, my fault. I just assumed that today's pu branch would have your
> latest patches - I didn't actually check that.

Sometimes I take a one-day vacation ;-)

Thanks.
