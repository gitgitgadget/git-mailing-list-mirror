From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Tue, 8 May 2012 10:55:56 +0200
Message-ID: <CACBZZX7LOKqKNe09636N0xJ_VvmKP58BMDtjoKn1t5e9hJ0OiQ@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr> <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org> <CACBZZX6u7rJer+tSqPddKdAF=bd216pZH5qUQNcrdr4nCmT46Q@mail.gmail.com>
 <7v62c71fl7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 10:56:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRgDj-0002YX-0C
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 10:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab2EHI4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 04:56:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64513 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2EHI4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 04:56:20 -0400
Received: by eaaq12 with SMTP id q12so1645019eaa.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 01:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RL5Il6oUv1NbFNpQZq2BrIBORuWY1eL3TorrWNIS/e0=;
        b=VN3dvmV4c4HpVjO1hxFmYIJ+88dNXIlyS2L+x259BlgwvM8SbLXpSB4UoSiRuZ7uF5
         u2JylucO8X4nJFzr0+tc+6IBxKkYAy3nGLqH0Pwt1vOZf+kwB4JFv5PyrhkRg6qXAHfG
         mHod8rPjHBGqRaju/DiczICbJSRwoNM/J/YjNGCjTbZSW1Mq1pASSDC3p/lG2GIIyGPV
         K/yVhERmofQMjBpuYKtYUETekIGwHMkUb//LhQWOsfosgzmsFI0xHddbYC4rW4tdI3A8
         uE6rz01Ef1OxHfYo7nLOKBiLOegxf1EhSYoNN5IlySIDjA2b3vDhbmGe/NIqQT4FLZi0
         aiPA==
Received: by 10.14.94.131 with SMTP id n3mr3185398eef.76.1336467379111; Tue,
 08 May 2012 01:56:19 -0700 (PDT)
Received: by 10.213.14.65 with HTTP; Tue, 8 May 2012 01:55:56 -0700 (PDT)
In-Reply-To: <7v62c71fl7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197347>

On Tue, May 8, 2012 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I didn't necessarily wanted to use "stage", it is "sad" because a
> new word-hunt may be needed for a replacement to "index" (as "stage" may
> not be a good word for i18n audience), and then we would need to keep
> "index", "stage" and that third word as interchangeable terms.
>
> Spliting the userbase by introducing a new form to an established
> terminology was bad enough, and making that three is worse.

I don't think that line of reasoning makes sense at all. We shouldn't
be picking terms in the original English translation of Git that we
think would be more amenable to translation.

We should be picking terms that make the most sense in English, and
then translators will translate those into whatever makes the most
sense in their language.

How translators work also depends largely on the language they're
translating the terms into. In my experience there's three main modes
of translation that people aim for:

 * Do we have a common word for it already? If so use, it, if not
   let's just use the English word. Japanese and German largely fall
   into this category.

 * Do we have a word for it at all or can we concoct one that makes
   sense? If so let's try to use it. Some languages like German are
   evidently struggling with the boundary between this and the first
   category.

 * What ideas are these terms trying to convey, and do we have an
   equivalent for those ideas in our language that we can use?
   Icelandic translations mostly aim for this.

So e.g. for Icelandic I'm not aiming to translate the shipping /
military concept of "stage".

I'm looking at what it means in the workflow of git (a staging are for
commits before they're born) and using a word you'd use in Icelandic
if you were trying to talk about some staging/preparation area.

That I have to do this isn't a failure of the original English
version, it's an inevitable emergence of different languages using
different terms and patterns to express similar ideas.
