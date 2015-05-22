From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 14:49:03 -0400
Message-ID: <CAPig+cRc=u=AKRgp3Dn5De13WcMYFXr1QomzPY0rXAwpN5WwLA@mail.gmail.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
	<CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
	<CAPig+cTsygj1g=8sQ2b=1WYsmgAVyZmHCTW=NKTGuNyQwm3VFA@mail.gmail.com>
	<CAJ80savzM_BL2oPiyTaPYAgnNL7F571aumGJLLw76vtryTacrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 20:49:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvs0N-0006fi-1J
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 20:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbbEVStG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 14:49:06 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36162 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756645AbbEVStE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 14:49:04 -0400
Received: by iepj10 with SMTP id j10so37578321iep.3
        for <git@vger.kernel.org>; Fri, 22 May 2015 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uRKh4GReYomqi3IwX8wqLs4eBxPZDzZAdQptCEgsvCY=;
        b=eK86WTGlJ2lnOzgJmPrV13rg3JAZ+HGalO8UwaYe15FholIu4kyXbFys6s6JtCS9d5
         4vGauS5dgIIUgfQzZobaFE+JwYLamCFgfbVHGxxxS9rLqEC3bM2ZTPDyni1m5Iod3aXo
         AOeaN+E8BD4ByPkIJswJlFGfxqwLiKGfHPQfhOBV352X2kzCTl4g1EVHAeVBuSdeebGB
         4cdVdFdCEOO4LBI7fCRRA9+BND0XJXY/YzwWA/FvbQHUmPdRMywyT6qNwIeWOBcHY8Hc
         q/CkuLmpBQOd2R6Qe9gnB3i2OjgfmGNTaVTAdSi4zJjE/GdFPzgA4I0pUDhmhARCS1g1
         fH9w==
X-Received: by 10.107.137.80 with SMTP id l77mr6093553iod.92.1432320543980;
 Fri, 22 May 2015 11:49:03 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 22 May 2015 11:49:03 -0700 (PDT)
In-Reply-To: <CAJ80savzM_BL2oPiyTaPYAgnNL7F571aumGJLLw76vtryTacrg@mail.gmail.com>
X-Google-Sender-Auth: 7tZLhGxqbArgDITevgHiTzyexlE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269747>

On Fri, May 22, 2015 at 2:01 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> On Fri, May 22, 2015 at 12:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, May 22, 2015 at 8:12 AM, Allen Hubbe <allenbh@gmail.com> wrote:
>>>> For the same reason, I'm not convinced that "simple" is a good name.
>>>> "sendmail" may indeed be a more appropriate name, even if it means
>>>> that this early implementation documents it as (currently) a subset of
>>>> the richer sendmail/postfix 'aliases' format. By doing so, we leave
>>>> the door open so a future person can implement additional features to
>>>> bring it closer to that format.
>>>
>>> Or, a future person can write a sendmail parser that is closer to that format.
>>
>> Yes, but git maintainers must continue to support your "simple" format
>> even if someone comes along later and adds a more proper sendmail-like
>> format alongside.
>
> Someone might implement a sendmail parser in the future, or perhaps
> never.  So, there is the possibility.  How strong of a reason is that
> to reject some other format that is based on a colon?

Nobody has suggested that your format should be rejected. Rather, the
issue raised regards gratuitous divergence from the sendmail 'aliases'
format. You seem to be arguing in favor of gratuitous divergence
(without explanation) despite the proposed "proper subset" approach
serving your use-case just as well.

> What is the harm of the two side by side?  This is only a small bit of
> code that really shouldn't require much maintenance.  What is the harm
> to just leave it in?
>
> If the future sendmail parser happens to support the simple format,
> and the future maintainers determine the situation to be unacceptable,
> there is still a solution.  Simply define both names 'simple' and
> 'sendmail' to refer to the same sendmail parser.  The dead code can be
> removed.

This "simple solution" doesn't work if your new format diverges from
the sendmail 'aliases' format, which is why the issue is being raised
now, in order to avoid painting ourselves into that corner. If, on the
other hand, your new format remains a proper subset of sendmail
'aliases', then the "simple solution" does work; and, as a proper
subset, it can just as well be named "sendmail" without hurting any
future effort to implement missing functionality.
