From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Nits abut the italian translation
Date: Fri, 01 Jun 2012 15:31:32 +0200
Message-ID: <4FC8C434.1050902@gmail.com>
References: <CANYiYbF3sbtKVTZJOTbQ-aOjBKGKFZfq-xQDwyOvR56C7akrLw@mail.gmail.com> <4FC8A88D.3080700@gmail.com> <20120601123642.GA11543@quizzlo.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Marco Paolone <marcopaolone@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 15:31:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaRxA-0004R1-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 15:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821Ab2FANbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 09:31:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51491 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758705Ab2FANbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 09:31:38 -0400
Received: by bkcji2 with SMTP id ji2so1851678bkc.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=XxzYgTP8r8aTMaCqNpQfcAV+X3nRf4kCO4knz8I5/f0=;
        b=oXvW+8MO1T1kMBXceaxzdbc4L5QCgRbSHF8CSlmcZbzzE3ygRKKFCRFyv5K4Y55ww+
         HkvsaDrzr5a2XhI9zyq84PoDFnw8JHuCvKmTvy08QyPjiUA6yisL/ItoHHDbdzqLGNqN
         utYktV3QkYnmUMGk+vGIPa6F0dCnaEG6X4Huf9qi9UrgoZQpp/3Cm1vaAUnudEXFOQXC
         Lq1cuMZ64aHlE8IJVX/UojxM8onIp2sDepcW239KcGpvjNrkT4toTky3ZMS7T/T1oLvz
         VMyQiT2fMubRJPqcYcuk9mi2/JICfxqtzghyGAFdjFTZraXU5Y+ZkeW+iFiJRMZm5dE2
         MGEA==
Received: by 10.204.156.69 with SMTP id v5mr1766419bkw.133.1338557497698;
        Fri, 01 Jun 2012 06:31:37 -0700 (PDT)
Received: from [87.8.100.238] (host238-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.238])
        by mx.google.com with ESMTPS id x23sm2119290bkw.12.2012.06.01.06.31.35
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 06:31:36 -0700 (PDT)
In-Reply-To: <20120601123642.GA11543@quizzlo.invalid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198986>

On 06/01/2012 02:36 PM, Marco Paolone wrote:
> On Fri, Jun 01, 2012 at 01:33:33PM +0200, Stefano Lattarini wrote:
>> I see few minor issues with the new translations; I hope it's OK if I report
>> them here.  Do not consider the following as an exhaustive list, since I've
>> just skimmed the it.po file.  And sorry for the messy and out-of-order report,
>> but I'm short of time in these days.
> 
> Thanks for your report, I'll fix them in next commit.
>
Thanks.

> We could even leave terms like "branch" or "tree" untranslated, but translation
> wouldn't have much sense at this point. Some guides, like [1] use "ramo" or
> "albero" to better explain how Git works, especially for beginners. Obviously
> we should leave terms like "cherry-pick" or "push" as is.  What do you suggest?
>
I have no strong feeling honestly (as I'm no user of localized messages myself);
what I suggest is that you should decide to either translate all the "translatable"
technical terms (e.g., if you go for "branch -> ramo" and "tree -> albero", you
must also go for "tag -> etichetta"), or none of them (that is my personal opinion
though, and other people might legitimately disagree).  In the former case, adding
a new help category (say "translation") that explains how the terms and concepts
are mapped from the original english to the current language might be a good idea:

  $ git help translation
  Git parla italiano ora!
  [ ... blah blah ... piu' dettagli qui ...]
  branch -> ramo
  tag -> etichetta
  directory -> cartella
  ...

Regards,
  Stefano
