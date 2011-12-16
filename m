From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Fri, 16 Dec 2011 12:51:19 -0500
Message-ID: <4EEB8517.2030304@gmail.com>
References: <20111216110000.GA15676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 18:51:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbbwY-000461-8c
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 18:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760288Ab1LPRvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 12:51:25 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:52078 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760264Ab1LPRvY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 12:51:24 -0500
Received: by qadb15 with SMTP id b15so2134928qad.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eklfjIprciDbJYkSfGUS2t54iOBELq1Rc7F1SHwZdoA=;
        b=JJ/LsNHcMNUZhhOCYbjF5zlUOuegGekzF9H43kltjt9P8FFQi76ZJmkLur5dzbkint
         t+htFLM+ctFNp6e08OD0BVs/VfgJZZRSRnpvV8x/dRtj254dh3pQk/UfhqqY07gS6kLM
         OJ450Ai0z9bARROmRSPApXhVuEaNhKZ2CBPW4=
Received: by 10.224.96.72 with SMTP id g8mr13406029qan.56.1324057883331;
        Fri, 16 Dec 2011 09:51:23 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-122-88.washdc.fios.verizon.net. [173.79.122.88])
        by mx.google.com with ESMTPS id ev4sm20853994qab.9.2011.12.16.09.51.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 09:51:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20111216110000.GA15676@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187291>

On 12/16/2011 06:00 AM, Jeff King wrote:

> +	"*.m diff=objc",

Please don't do this: Matlab files also use .m as a suffix, and there is 
little to no compatibility between objective c and Matlab syntax.

Mark
