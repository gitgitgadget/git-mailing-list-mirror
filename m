From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Fri, 16 Oct 2015 10:42:49 -0700
Message-ID: <xmqq4mhqg15y.fsf@gitster.mtv.corp.google.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
	<xmqqwpumg480.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:42:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn91s-0002Sy-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbbJPRmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:42:52 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35609 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548AbbJPRmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:42:51 -0400
Received: by padcn9 with SMTP id cn9so11533485pad.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9cvygdoMUXwXYKfX+sAN5hdMcd69SvE1XcFBLe57kNc=;
        b=j1IoQarfM8NrDwzzSckuYvVqpLefsQIighv6SUsPFPNUnocp7sO32TaWnWuk9YpDKQ
         wKZGApAOXQlcYNYWcebX/bvmTYzG1FZWIRf749Lem9douKOwna2iqTxAwRl5yuhW3a8l
         vgdpNKuDXWM3tR45bZRdsaITblFBgpFjUCx2XHqDRWntdt/UU8UZmkSaGYUW5G8c5Iit
         kUnfxxvQoTl4NkoMSpm1pWasPU3Z9rhaKC2xDkndKAlYeMDMVnOKs30WP5Y2uLUOrd1v
         kdp28D1fXTLH2TTZYhhfLlzDlU+FgabrsHGCokM+3KfOkt8c0dtm3kJNgmOxSo2fgDoK
         CNVQ==
X-Received: by 10.66.62.132 with SMTP id y4mr17912820par.130.1445017371047;
        Fri, 16 Oct 2015 10:42:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id ix1sm9099372pbd.40.2015.10.16.10.42.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 10:42:50 -0700 (PDT)
In-Reply-To: <CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
	(Alex Henrie's message of "Fri, 16 Oct 2015 10:42:45 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279759>

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2015-10-16 10:36 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Makes sense, as all the other <placeholders> in the usage string are
>> bracketted.
>>
>> Does it make sense to do this for contrib/examples, which is the
>> historical record, though?
>
> I didn't know that contrib/examples was a historical record. The last
> patch I submitted, b7447679e84ed973430ab19fce87f56857b83068, also
> modified contrib/examples.

Yes, but that fixes historical "mistake", no?

With this, you are breaking historical practice by changing only one
instance to deviate from the then-current practice of saying
'options' without brackets.  It is based on the point of view that
considers anything inside <bracket> and a fixed string 'options' are
meant to be replaced by intelligent readers, which is as valid as
the more recent practice to consider only things inside <bracket>
are placeholders.
