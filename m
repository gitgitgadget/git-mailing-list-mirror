From: Andreas Ericsson <ae@op5.se>
Subject: Re: auto merge bug
Date: Tue, 05 Mar 2013 21:56:47 +0100
Message-ID: <51365C0F.8070207@op5.se>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com> <20130305090326.GC13552@sigill.intra.peff.net> <7vtxopvoky.fsf@alter.siamese.dyndns.org> <20130305175904.GC9379@sigill.intra.peff.net> <7va9qhu1jk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	David Krmpotic <david.krmpotic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 21:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCyvH-0005or-3q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 21:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934Ab3CEU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 15:56:53 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:49714 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab3CEU4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 15:56:52 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so6560075lab.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 12:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Hid1bYidkQjqQgpkBPzEce9AX9ksuYJuHdp2sokTlqg=;
        b=myHa7ZpBXwJlf/sGvDmPwHakIXCVZy+kJkaa/F4eO86Uva00yYpth/UyCDmM8FsBjE
         D7k0djUAsEKM3bLdUJYIeX6Pd+dmaqo7lEO2/EqC3ofK6z9icK3tcu51+RBpe3XwYmXY
         4ckv0He3y0z+uB4zl0iy91pyib3nDKKSy4ZmqM9maSyaMJWb5rO8aggIEVSZTELgIrXO
         5qUcHILMGv5TbV+tsO7cE7HlunsinCz5EeX+cd+Nq16OgyWdeM5gKwBAUKOZHbGg++HS
         JCg/X3oJQyUziODHlGvvp4jegrDsvqH4Dbao3JDRnewd4c0ZhoF0jsaO8uHEvLyU9DLL
         n9LQ==
X-Received: by 10.112.88.72 with SMTP id be8mr6637695lbb.116.1362517010471;
        Tue, 05 Mar 2013 12:56:50 -0800 (PST)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id iq6sm3575226lab.10.2013.03.05.12.56.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 Mar 2013 12:56:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <7va9qhu1jk.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQk2wIIDjoBR9fvXfBgXVUYAkI9OTk475IupAovzve8bMm1W9Vo7YmGplp8k+zPJ74mf/dAq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217478>

On 03/05/2013 07:47 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I'm also not sure how useful those really are in practice. I have not
>> used "union" myself ever. And in the example that started this thread, I
>> find the use of "union" slightly dubious.
> 
> Yeah, I do not think anybody sane used "union" outside toy examples.

I do, for lists used in tests or to generate perfect hashes from. It's
really quite handy for things like that but totally useless for any
type of multiline format, or even .ini style files unless you're very,
very careful with how you write them.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
