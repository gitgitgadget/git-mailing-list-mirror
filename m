From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Refactor useful notes functions into notes-utils.[ch]
Date: Thu, 13 Jun 2013 13:50:46 -0500
Message-ID: <CAMP44s1dDsRwk5q4NikA5-O86sKDQ_FQsPB2QnGZBqQZ6tpL1A@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<7vzjuv14ir.fsf@alter.siamese.dyndns.org>
	<CAMP44s3jnyds45UGfbig1=evbqP-rztcn7GTZ8puVa2zzA7HGg@mail.gmail.com>
	<7vsj0lvs8f.fsf@alter.siamese.dyndns.org>
	<CAMP44s3atPW-SE1yQzep-F6M13g1fPP_q2RqHKofPL0B8=JfYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jrnieder@gmail.com, pclouds@gmail.com, artagnon@gmail.com,
	john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:50:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnCbm-00017J-UU
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759158Ab3FMSuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:50:51 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:49662 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886Ab3FMSuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:50:50 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so8964373lab.24
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mf8K0u4QkgOTuSSIWY2kMnlWAGq5ZycHIijv2A2D7FM=;
        b=siFMjaStK/TspEw570KhC3bk3RrG7J8LeK37swERcKgvyvNK5DFwGRWwx3rQElgfjd
         a1JVja5ljsTdw9Vi6Mpz0k0TgH18iH6kEvPwyC7jS9q3hPc7R9uVohqSq+1AqCh8NRuM
         /c86gRUs+foMud2ycrxX6951Ukw65FflRljuI25RvufZf9FzHVzzyfWUHUg9XjZzEPCn
         EJXVn15bLBDSn4AsMxL7wIXAUp0vJkUSdXSRJGL8yNyUl8KL9+nxy/xjkfE9DzzC70HH
         KVwJGPUOREKjC3DV3M0DiFkO4krxhhGYfVhCLh8CR/8Y9RnNc64uo58UsoW0g24rPQXR
         9JYA==
X-Received: by 10.152.28.162 with SMTP id c2mr1077987lah.45.1371149446381;
 Thu, 13 Jun 2013 11:50:46 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 13 Jun 2013 11:50:46 -0700 (PDT)
In-Reply-To: <CAMP44s3atPW-SE1yQzep-F6M13g1fPP_q2RqHKofPL0B8=JfYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227773>

On Thu, Jun 13, 2013 at 1:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Jun 13, 2013 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> But the thing is, that majority is what writes the majority of the
>> code and does the majority of the reviews, so as maintainer I *do*
>> have to give their opinion a lot of weight, not to mention my own
>> opinion about how to help keep the community the most productive.
>
> Indeed, but that doesn't make it a fact. It remains an opinion.

And just to make it clear, I didn't deny you are the only one with
commit access, and therefore you make all the shots. You made a
decision, fine, I never said you can't do that.

What I said is that you should not use words to imply that your
*opinion* is a fact. The fact that you make a decision doesn't make
your opinion a fact, and the fact that many people share your opinion
doesn't make it a fact either.

So, instead of saying:

"Just one side being right, and the other side continuing to repeat
nonsense without listening."

You should say:

"Simply a matter of disagreement where the code belongs."

-- 
Felipe Contreras
