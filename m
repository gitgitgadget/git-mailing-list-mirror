From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] fsck: print progress
Date: Sat, 05 Nov 2011 12:15:48 -0700
Message-ID: <4EB58B64.3070304@gmail.com>
References: <20111103211819.GA17341@sigill.intra.peff.net> <1320376242-27851-1-git-send-email-pclouds@gmail.com> <4EB4EB70.40801@gmail.com> <CACsJy8CEh6x1O0AHpiErZ_+T2hGwjRZofygmsgVX8_WXV7uDTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 20:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMm3V-0000yo-HP
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 20:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab1KETPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 15:15:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35053 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab1KETPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 15:15:52 -0400
Received: by iage36 with SMTP id e36so4007553iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UTXw90F53ItbnO9qjKS1oqWlOVNkGfXGszjXZkjLObc=;
        b=BsvP5ureciC09ffPNbBE/ghXUpgVjBzK1zcSMf9oQAUCc8bkIi/CdrdsVjqMHfgLSa
         tgyuAbiHV/vIx2j1JMdRd0BDF0l1RPyECk8xanML1qaUAST61GJheitGO7owo0ESwyY1
         RuqUwTi3/NYuSNKp4Kx+z84EXgyJg/HePpVDA=
Received: by 10.231.6.102 with SMTP id 38mr6463966iby.62.1320520551918;
        Sat, 05 Nov 2011 12:15:51 -0700 (PDT)
Received: from [192.168.2.10] (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id b3sm20812502pbl.8.2011.11.05.12.15.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 12:15:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110911 Thunderbird/6.0
In-Reply-To: <CACsJy8CEh6x1O0AHpiErZ_+T2hGwjRZofygmsgVX8_WXV7uDTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184873>

On 11/05/2011 02:02 AM, Nguyen Thai Ngoc Duy wrote:
> 
> "-q" in fetch-options.txt can be converted to "--no-progress or
> --verbose". How about this?
> 
> --progress::
> --no-progress::
> 	Progress status is reported on the standard error stream by
> 	default when it is attached to a terminal, unless
> 	--no-progress or --verbose is specified. --progress forces
> 	progress status even if the standard error stream is not
> 	directed to a terminal.

Looks good.
