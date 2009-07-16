From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Make a non-bare repo bare.
Date: Thu, 16 Jul 2009 07:47:20 -0400
Message-ID: <c115fd3c0907160447m3be44bcci46aa9d812884a8f6@mail.gmail.com>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
	 <7vbpnlbbln.fsf@alter.siamese.dyndns.org>
	 <2e24e5b90907160439i29171e9fka3baf6bf871a6011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 13:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRPQu-00023c-Rt
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 13:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbZGPLrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 07:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbZGPLrW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 07:47:22 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:41797 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZGPLrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 07:47:21 -0400
Received: by yxe14 with SMTP id 14so83423yxe.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9WmOt8qK8A/qlaY8VfSmeIfYoeskCDUTy11K9lIjrbs=;
        b=TDqhVY/StiUfO7ITBKPeL+BHa1RrSwldDqf1+73U9Z3WQg1VMlCOO78Q7vZ6UM1Q1y
         356RU6d70rGt4Eioh9BPzlGaAs3ekbu7mupJIXZaEE5sjx65Ctkj6HCAzT+IYbw2ZvFa
         Ii2xexifo44JhIOiW/aKtsGjT/At+pWT8spKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jKmd00doe6miw36G216DD/foApRdRCt75bmKjSXZtnfphsLbZ6cnmKJSooPbW0ClZH
         NP357mS5F4kLe+sZMoPf21gP8xN9aEwL9YsspqrcnpBRsqyuJg4VUjU2wuRBWzXbJR5l
         5GYg1X6hlvAQ58GEcpGCZsmWREG63SrqwH+kg=
Received: by 10.100.110.19 with SMTP id i19mr11899504anc.1.1247744840451; Thu, 
	16 Jul 2009 04:47:20 -0700 (PDT)
In-Reply-To: <2e24e5b90907160439i29171e9fka3baf6bf871a6011@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123399>

On Thu, Jul 16, 2009 at 8:03 AM, Junio C Hamano<gitster@pobox.com> wrote:
> Tim Visher <tim.visher@gmail.com> writes:
>
>> Hello Everyone,
>>
>> I recently had occasion to make a previously non-bare repo bare.  Is
>> there any way to do this?  It will not allow me to delete a branch
>> that I'm on so I wasn't sure how to proceed.
>
> Funny.
>
>    http://article.gmane.org/gmane.comp.version-control.git/123303
>
> It is posed as a question but describes the correct (and officially
> supported) procedure.

Thanks.  That's what I was looking for.  I wish I didn't have to
actually clone the repo anew but if that's how it is, oh well. :)

That wiki response seems to contradict what Junio said

On Thu, Jul 16, 2009 at 7:39 AM, Sitaram Chamarty<sitaramc@gmail.com> wrote:
> The linked procedure uses git clone --bare.  It is my belief (and
> please correct me if I'm wrong) that only a git clone --mirror
> actually does what you want here -- a mere "bare" clone would lose
> your remotes and their tracking branches would it not?
>
> If I'm wrong please correct me...

The linked wiki article seems to contradict what Junio said.  I guess
I'd go with Junio being somewhat authoritative on normative
prodecudures in the git world. /me shrugs.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
