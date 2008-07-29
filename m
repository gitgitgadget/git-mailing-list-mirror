From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 12:34:43 -0700
Message-ID: <d411cc4a0807291234q794344e0oee09f6164286ffd1@mail.gmail.com>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	 <20080729170955.GK32184@machine.or.cz>
	 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
	 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:35:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNuzF-0001XH-7E
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYG2Ter (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbYG2Ter
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:34:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:58623 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYG2Teq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:34:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so17396ywe.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=P8n6xrDnWoZupqdmTvr//cgmMPbg4f0cOkcnfl695X4=;
        b=n1VoTIxAQZEQhvfjidKwNavzl0oFYnXO+m96aHj8CgvRlZOcavKmeADVqW2BjPuLH3
         4axss/ZarCkzf/4wv2T9J+0FKWGQr5LH5m9w63N83FewQMNJv/UT2joXUFoU3ggi20yn
         neo847/C/gjn8OxodE0oiKS5dROrG0sl8/ph4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VCDSJ/e72JeArOUWrFwpmrPyeu5cX0TgC4FOQspAhOXt0Ej8COJPO8Tm54jcf3MhNC
         EtFyTr4tBoE7Ppkcl2avGZUWBTq08fz/hRJeedNSqU1ErQHkHIxi5DuzC0BGpxFbDtlU
         9ydCZNKKNPJyeuICUhUU23Szz5y8764ljK3F8=
Received: by 10.114.193.1 with SMTP id q1mr7132693waf.70.1217360083457;
        Tue, 29 Jul 2008 12:34:43 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Tue, 29 Jul 2008 12:34:43 -0700 (PDT)
In-Reply-To: <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90673>

On Tue, Jul 29, 2008 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
>
>>>
>>> There is no license in the source code - what are the copying terms?
>>>
>>
>> I copied in the COPYING file from Git - GPL2.
>>
>>> It is maybe somewhat unfortunate that this is in a different format that
>>> the standard git choice asciidoc, but the formats do look rather similar
>>> so I assume it should not be hard to even convert from one to another if
>>> needed.
>>
>> I simply didn't want to get asciidoc working locally - it's always
>> been a bit of a pain to compile (I've heard it referred to more than
>> once as the only 'nightmare dependancy' in git), and I don't need to
>> make man pages or anything, so it seemed Markdown would be a better
>> choice for my output targets.  There are a number of good Markdown
>> interpreters and they're easy to get running.
>
> I personally like markdown, but doesn't your refusal to work with existing
> practices pose a significant problem, unless:
>
>  (0) you do not consider it a goal to keep the documentation shipped with
>     git and your book in sync; or
>
>  (1) you have either markdown to asciidoc (or the other way around)
>     converter; the book is written in markdown, and its conversion back
>     to asciidoc is fed to Documentation as patches (or the other way
>     around); or
>
>  (2) somebody tries to find markdown to manpage, and we convert
>     Documentation/ to markdown.
>
> Or is this, "fork once and borrow reviewer's time, but never be able to
> contribute back to the original text because the result is so different"
> approach?
>

The book is basically a fork of all three of the guides I mentioned
(User Manual and both Tutorials), and with the scope and goals I
currently have in mind, will not be kept in sync - it's just not going
to be possible.  I think in the end, the goals of the texts are so
very different that sections it will simply not make sense to try to
keep them in sync in some sort of automated fashion.  That's one of
the reasons why I choose Markdown - I saw no need to use asciidoc, as
the book will not be shipped around with Git or built using the same
processes, and I had no need for the advantages of asciidoc in my
project.  I don't think it makes much sense to have the book be a man
page at all.

However, I will watch the manual and guides and try to incorporate
changes to them as appropriate, and I will likely have some updates to
them myself as I've been more closely scrutinizing them.

Scott
