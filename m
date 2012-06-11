From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 18:25:47 +0200
Message-ID: <CABPQNSaLtdGVfdkQyRFn4_Ze84zGVuvPwxTpr3hY8uDc0WU2Zg@mail.gmail.com>
References: <20120611073232.GA5602@richard> <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
 <20120611090431.GA23447@richard> <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
 <7v4nqh96z5.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:26:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7S2-0006s5-EA
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab2FKQ0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:26:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35813 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab2FKQ02 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:26:28 -0400
Received: by dady13 with SMTP id y13so5605489dad.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SNRZ8cImOssH/LgYOlJKDMSK+FsmfHGDKt84zWr8/y0=;
        b=M/KEwMApp4bjw4bf3YDLcAWLFN2tvgi2pmLFrpdlEjDjUnK2hqhb+oicXKiVwa7K1n
         cBfaxiSwoB4SH1MHj+LzWxvSLyH9JIm8+IB848yYTjD184cT1InVzVZKlrYvXcOV8Hsg
         W0cUrSO+0bkLqACrj14M1uC/14pMvf8ixZC0Tm6RWcJKbNwhrxQOOCbEsISvMmI6l/p0
         4zEwse2LmDN0Ru++Bif/DZCz7LJwqXEqIJ/sLpMjPva3rRNObzTGb1+Zt7+3RDaSmezF
         nUuvLuVZvSiumPeyYfCFM4CnobHuL3ZGnuZro7OiFvMNBKLkAwUouFADZcvK14vMabgQ
         m1wg==
Received: by 10.68.132.166 with SMTP id ov6mr28910748pbb.24.1339431988012;
 Mon, 11 Jun 2012 09:26:28 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Mon, 11 Jun 2012 09:25:47 -0700 (PDT)
In-Reply-To: <7v4nqh96z5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199671>

On Mon, Jun 11, 2012 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Well, I've always been slightly annoyed by the "send-mail" vs
>> "sendemail" inconsistency.
>
> Hrm, isn't it between "sendmail" (as in /usr/lib/sendmail) and
> "send-email" (a subcommand of git)?
>

Ugh, you are right. My brain must have been defective :)

>> Perhaps we could do something along these
>> lines (plus all documentation-updates, omitted for clarity) to reduce
>> the risk of confusion?
>
> Assuming that the contrast between "sendmail" and "git send-email"
> is what you are trying to address, I fail to see how it would help
> reducing the confusion if you start naming configuration variables
> used by "git send-email" without E.
>

No, this was just me being a moron.

> If the proposal were to give "send-email.$var" synomyms to
> corresponding "sendemail.$var" variables, I would have been
> persuaded to believe it may alleviate potential confusion, though.

This was really the way I wanted to go, but I somehow got unsure about
the legality of the dashes in config sections. I'm a bit skeptical to
introducing new non-letter characters if we don't have to.

So let's just drop my suggestion. I wasn't thinking straight.
