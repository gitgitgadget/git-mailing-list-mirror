From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Mon, 8 Jul 2013 18:04:05 +0700
Message-ID: <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 08 13:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw9FJ-0004bw-FV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 13:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab3GHLEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 07:04:36 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34630 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3GHLEf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 07:04:35 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so5268584obb.4
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EslBdfsq+zmbCvVgbNTk1JAnyzlLMBXJPumRltbUN2U=;
        b=iynigoxqe1zcVBEaVUmhRsRV9O19i9k1tl476vilye5U+NRSe5dAuFxGoiJGSfX5Cw
         H8wqA3hYiBPPpt1RRKpnQ6VM7HmgzUVDhK5C2yJOvI+KaCCCC/DpnxcEM9Y/0ixPorQv
         GH0whDj+p3JsTLlagy41jqGQYeGnfLREOac8fq7UsZKz5nf3EXjLxV31bX3G7woWGnmt
         bCmRezgOXJRz7jc92ny3BEi59hwQTFTv9mxogJUYpKJZkRflFLBe0fdq5wnJx+a4N21l
         aa/KZyYv2H/c+KtptAz+eO7mxrtfrbKB0wTI/odwOCgmKn0y4r16jRZPlA5YZvSYqlmh
         5Gjg==
X-Received: by 10.182.215.133 with SMTP id oi5mr19795898obc.83.1373281475302;
 Mon, 08 Jul 2013 04:04:35 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 8 Jul 2013 04:04:05 -0700 (PDT)
In-Reply-To: <7vtxk645vp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229837>

un Mon, Jul 8, 2013 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Perhaps we need
>>
>>   git cat-file --batch-format="%(disk-size) %(object)"
>>
>> or similar.

This is what I wanted to do with the in for-each-ref's pretty
formatting [1]. I used to hack cat-file --batch to extract info I
needed for experimenting with various pack index extensions. If you
are not in hurry, maybe we can introduce something similar to your
syntax, but applicable for all for-each-ref, branch and log family.
Ram, are you still interested in the awesome branch series?

> I agree with your reasoning.  It may be simpler to give an interface
> to ask for which pieces of info, e.g. --batch-cols=size,disksize,
> without giving the readers a flexible "format".

[1] http://thread.gmane.org/gmane.comp.version-control.git/227057/focus=227223
--
Duy
