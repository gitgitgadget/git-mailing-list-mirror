From: Andreas Ericsson <ae@op5.se>
Subject: Re: Can git pull from a mercurial repository?
Date: Tue, 18 Sep 2012 13:46:24 +0200
Message-ID: <50585F10.3080307@op5.se>
References: <k39lir$gpm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:46:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDwGH-0006hJ-7c
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 13:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834Ab2IRLqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 07:46:33 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39773 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827Ab2IRLqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 07:46:30 -0400
Received: by lbbgj3 with SMTP id gj3so4873087lbb.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 04:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=khKrCOzEGYsxUtpWutcqTpUmxGGR8kPud7pzz6SXMyo=;
        b=MtqKGpxXN8p6ShRXdV3giLxmLIQ1V0i5c7FUYC0bdXhGT2rYrhdCcy2W10+hrK0FPi
         pcSFRjz4jGKNTT1S/4JiCQVKEtp9cGsPG24/W4TEzY9LFfuB9hSi2HRxDICDP4xe5mLs
         zTNxy/EUU6sKvRVodTXI+El8G7hGZ+ss1o+JlAgiH/2yY7ytzNjDxmBHZcrhJM0L45oL
         y5ZaBCeUcLM6nZ21qfRuAvweA+Kw+OJZHz4ypTixEs6nk0h5+Kw+8jV6CtGGyCUC3dp2
         1NifnpsS/YqgVlz3RrNfom86YoGX9X0OaFsVorCh4E6MwgyRPrqINx9e9iFuf5xLLw4A
         NevQ==
Received: by 10.152.46.209 with SMTP id x17mr12301850lam.38.1347968788501;
        Tue, 18 Sep 2012 04:46:28 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id hh10sm3752781lab.10.2012.09.18.04.46.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 04:46:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
In-Reply-To: <k39lir$gpm$1@ger.gmane.org>
X-Gm-Message-State: ALoCoQl+MDjTIMWpRIrz/6DKg9X9ernJPYno7Bs504P54WG7sJioFFeiz90sAC84pSgIecHCFYG1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205824>

On 09/18/2012 01:22 PM, Joachim Schmitz wrote:
> Is there an easy way to get git to clone/pull from a Mercurial repository?
> 

Yes. Google "git remote helpers" and you'll most likely find it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
