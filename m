From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 13:38:32 -0400
Message-ID: <CAD0k6qRGQyFxZ8+yqkzYff_k4ZjWPaegQbBphwXyfBtUOCCw6g@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
 <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com> <CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
 <xmqq615x2ph1.fsf@gitster.dls.corp.google.com> <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
 <CAD0k6qQW3TbgXDsc2Wzid8RNyugumUbSu4KTzO21euO3y_OWGw@mail.gmail.com> <xmqqsi91197o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:39:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAME-0003kc-HF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbbGFRjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:39:00 -0400
Received: from mail-vn0-f52.google.com ([209.85.216.52]:39744 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbbGFRix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:38:53 -0400
Received: by vnbf190 with SMTP id f190so8377536vnb.6
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qm2OJkNU7NP8nY1087l3kn4O4qYIN2TVDUH3It6wM6Y=;
        b=PJkAwN8o6cJnXvnye47Jk8jPJO7P0HYZQWrdDDC0q4p3cGeLr9fCtGO6Bkji6/H5PT
         3cjaC0uTi8/5CJzNEHYf16BcULZWsT9BKywKapZ7NXmT9eRYn9mjxkMeFe4UfGjRVr36
         eD7xdhMlCokF6HvMDOvhcG03hxhsHzOIi9wy6vStxO/Wk7Ln8yMmWcTuF23edT9nW7q2
         fQg1ekD8rKtSC8bCk7uDFzcElUx3jqaRODH7L4SAAL+lcvHO4J1Xza0z/tokC4fWnxZk
         6mQN6IrS4vqh5PNhKShUiyuZ/5p2T94jl4JbbyIS0qBlr8PCayLmadv9eOL63TL61LnE
         iqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qm2OJkNU7NP8nY1087l3kn4O4qYIN2TVDUH3It6wM6Y=;
        b=csSgrKK9/ZYL6zAZv55a2ddYEi0zsDkaNu9HEdIsLhIC0xt7BK4N7TNFrvijZpOI/L
         ivROyZcpaKvY1mosIJYxvxUPY+GEy1iTD7MVhi8Ews8L1bL/fYBEOAcvAi6DsZchnkPr
         FCLtD0MkNUhQtCEEanquIatKycdcAWbDNISDaEUoF5o/XkwmpMFHHOE9cUQp5PcC0qdb
         5/DVylxYNi+RiGSeJ+Rc46z/X5eY4+134126mYH95JaoG92XewAuyozeFcwOlEjnoout
         JVXe3hZUFUdaza0nx9EpjhmD4Wqhrv1kGSSrzz4zJvNAo75ixYCltHq7w1dZYdebLpd1
         a1Lw==
X-Gm-Message-State: ALoCoQkfPWWB0Uh47OmdIPxzYhoQDH/OBQ1fEO7hFBXNc05X2UjQkDtoVzVWnQeh065NTWJO83va
X-Received: by 10.52.188.137 with SMTP id ga9mr66233vdc.30.1436204332546; Mon,
 06 Jul 2015 10:38:52 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 10:38:32 -0700 (PDT)
In-Reply-To: <xmqqsi91197o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273440>

On Mon, Jul 6, 2015 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> Another way of looking at the problem with my assumptions is, I was
>> assuming "pkt-line framing" was the same thing as "pkt-line header".
>> You seem to be saying the definition of "pkt-line framing" is "header,
>> and optional trailing newline".
>
> Yes.  I thought that was what "Server SHOULD terminate with LF;
> client MUST NOT require it" in the existing text meant.

Unfortunately, the existing text is littered with examples of
"PKT-LINE(foo SP bar LF)". If we assume "PKT-LINE(...)" means "apply
pkt-line framing to the [...]", then this strongly implies that
"pkt-line framing" does _not_ include the trailing LF. (Or the logical
but bizarre alternative reading that such an example might have _two_
trailing LFs :)

> Ah, that reminds me of one thing I already said elsewhere.  We need
> to correct the above with s/Server/Sender/; s/Client/Receiver/; I
> think.
