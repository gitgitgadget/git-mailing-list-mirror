From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] remote.c: specify correct plural form in "commit diverge" message
Date: Tue, 3 May 2016 16:32:19 +0700
Message-ID: <CACsJy8B2i1ef57xgrRAYkkpWL1-Lz5O7_Zcje1pJ6eLuMry18w@mail.gmail.com>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
 <1462234350-30902-1-git-send-email-pclouds@gmail.com> <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
 <CACsJy8C0mFfHQ+GSdJyXLc=SArnxKfZCFV7LJkoqEPs0ekzDZg@mail.gmail.com>
 <20160503042008.GB30529@sigill.intra.peff.net> <CACsJy8Bqs5dnKc=VPeuqPZ4OUWVdhYNbewWc5rs-R3FGoZuQ5g@mail.gmail.com>
 <20160503044805.GB32259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	ernesto.alfonsogonzalez@ge.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 11:32:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axWhL-0002GI-US
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 11:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbcECJcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 05:32:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33770 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbcECJcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 05:32:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id p64so1450827lfg.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 02:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0MpEP0cGaKsmltmYsqWVSi7uKMc1TM8w+Qe1PrRtCA8=;
        b=pN/ZD8WVdlS/Yu1WMF9OJVBMg4gEE3dWxagE7Tua5Y3wIL6HLVg6HY28e1ICPhpsup
         9zk3LuynUxnOy6scPOOO/VM1evwzaAZq03yxUBZARsRxkmfDl7vaQx5QLDPqAJU2VztW
         ZHWS7B4c6icagwunA95S4bM/aLeO8Zj8eOimIXOcZRpCNYEh/+5edA6QGKGjVYBxeMxA
         euDcqRtQI1GdffJf4NRvDZmSaPZKjSqtQ/ti9NGHov+h96MH2jOolqTmzhAdyGcej5Wu
         7Tc95QWiY6J2v/tIfdw/7fQvTuYQONCCJXGjelE2216FnE4iRC7R9TjMk/hKrETuvKMr
         G3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0MpEP0cGaKsmltmYsqWVSi7uKMc1TM8w+Qe1PrRtCA8=;
        b=SnD038Ojno59zDY7TBymnIj/dA3rmc684CdRwq6lfaaDzms/Rmqgp14H5UxTugJpOO
         R/GX0rpSvyQYAXOsnpWEsKuxDLW/hre+XMT1vmsOEgKgXjAJ2DUsrEDAPcHhK3ovazkx
         hy1U+wWapBMqMQsXeK0U7hKT9WUloIns3tXXGRr0uz/tyBXETFQON33RLjvaCF4U1RZV
         OoQ5xn85GwFLkocxvL7gLinYGQsMF4niuTtr/3dA3vYxmSImp6g3QUdLsQNBCObXtig0
         vr1wWjjJnAdkyjpXs28Nj6N9/HIYrvNIQtVpMnmeZf/FZ6BBZn9l/YgE54bMunY1JAE7
         dpRg==
X-Gm-Message-State: AOPr4FX/ZV9j7kKcKWqKOakuCD6ZHr0/m4d0e8ONqIbfxFwt1E3kC58VrSSQlBFOUmdCH539q8yntAasSSe3KA==
X-Received: by 10.25.165.135 with SMTP id o129mr747387lfe.162.1462267969156;
 Tue, 03 May 2016 02:32:49 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 3 May 2016 02:32:19 -0700 (PDT)
In-Reply-To: <20160503044805.GB32259@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293349>

On Tue, May 3, 2016 at 11:48 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 03, 2016 at 11:43:41AM +0700, Duy Nguyen wrote:
>
>> On Tue, May 3, 2016 at 11:20 AM, Jeff King <peff@peff.net> wrote:
>> > Note that I do not think the singular case can ever trigger with your
>> > new code. We know that both "ours" and "theirs" are non-zero to get to
>> > this message, which means "ours + theirs" must be at least 2 (barring
>> > negative commit counts, of course :) ).
>> >
>> > So you could probably replace the Q_() with just a _().
>>
>> Problem is there are languages with more than one plural form (and the
>> winner is Arabic with six(!) forms [1]). So even if singular form is
>> never used, I think we still should stick to Q_().
>
> Neat, I didn't know Q_() could handle that (I guess you are stuck
> specifying only the two cases in the untranslated form, but the PO files
> can do magic in the backend).
>
> It would be nice if there were some way to mark it as "this string will
> never be shown", or "will always be >= 2" as a hint for translators. I
> guess those can go in a specially-formatted comment.

Yep, that's the only way I know. But it's probably not good for this
purpose. Imagine if the code is moved around a bit and this exact
string can take n == 1 (probably not given the "x _and_ y commits"
pattern) then we need to tell all translators (optional hints are not
enough) to translate the "n < 2" part or empty string can be printed.
And at least in _() case, empty string is an indication of
untranslated messages, the translator would just translate anyway so
he/she can identify new messages easier.

On the practical side, since
this string has been here for a long time, it's been already
translated in all supported languages (except it.po), hinting now
won't help much (besides it.po)
-- 
Duy
