From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] cache.h: add missing NORETURN on git_die_config*()
Date: Tue, 05 Aug 2014 19:39:47 +0530
Message-ID: <53E0E5AB.9050404@gmail.com>
References: <53E0E2E0.2070709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 05 16:10:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEfR8-0006Zx-GO
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 16:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbaHEOJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 10:09:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44455 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaHEOJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 10:09:53 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so1499616pad.27
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BBD1MLBS+Z5QvKxKmcyO3Vs2CozG02MPs+G8uP3w2GE=;
        b=AmR5FGfne8YZrTtSuxw6IQsujwI9xea+Co6hF1vT982zY3zSjw2Se3JFpxVdlRKb/D
         eW6a/IoCu9JuuRq5dTRD6Axi2JRObIpHXh7iPkbu7Vf4S/HbJy1LAbX+zYAUDV+QDZCP
         hwZBs8MPOymsQlMKApeDivM2U0PAIlklrEKRTofehqqu0BKfkyc5CQB3dk6u2Qt+c9jm
         zYyvlqMWVazgETvJF+qVKzfu3xlek5kw6/6KXUz79/5KYFSUu6rxiTC7RcoYCZI2yofa
         q15jMz6TaAlRKThe/TUTIDGa9Q9u59tXnR4oQPSmiP64O29+qpreXMd+p2iWRRV1J5Vn
         0DAQ==
X-Received: by 10.68.204.102 with SMTP id kx6mr825708pbc.140.1407247792853;
        Tue, 05 Aug 2014 07:09:52 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.236.62])
        by mx.google.com with ESMTPSA id i8sm2201717pbq.12.2014.08.05.07.09.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 05 Aug 2014 07:09:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53E0E2E0.2070709@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254805>



On 8/5/2014 7:27 PM, Ramsay Jones wrote:
> 
> Commit 3a2a9527 ("config: add `git_die_config()` to the config-set
> API", 01-08-2014) added git_die_config() and git_die_config_linenr()
> functions, but forgot to include the NORETURN attribute in their
> declarations. Sparse complains like so:
> 
>         SP config.c
>     config.c:1567:6: error: symbol 'git_die_config_linenr' redeclared \
>         with different type (originally declared at cache.h:1419) \
>         - different modifiers
>     config.c:1579:6: error: symbol 'git_die_config' redeclared with \
>         different type (originally declared at cache.h:1418) \
>         - different modifiers
> 
> Suppress the sparse errors by adding NORETURN to the function
> declarations in the cache.h header file.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Tanay,
> 
> If you need to re-roll the patches in the 'ta/config-set-1' branch,
> could you please squash this into the relevant patch. Thanks!
>

Sorry, my bad. I will squash it in the relevant patch for my next re roll.

Thanks,
Tanay Abhra.
