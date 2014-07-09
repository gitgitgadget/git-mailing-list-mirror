From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: `git log --graph` with multiple roots is confusing
Date: Wed, 9 Jul 2014 14:16:30 +0700
Message-ID: <CACsJy8D4NeDjwkTw=Mpy16vjRhLzPXU55yhG_z+oQwC-82FF4A@mail.gmail.com>
References: <CALygMcDXjMUcq=8ERVTES+5qNjLMe_OFPbmeqAosU7qmk=QuUQ@mail.gmail.com>
 <20140630080829.GB13153@serenity.lan> <CALygMcDr2N2oyLOkVzE3XqAXu8DMSe_LhHXdL0QwN8W3JaV9zg@mail.gmail.com>
 <20140709065145.GB14682@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gary Fixler <gfixler@gmail.com>, John Keeping <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 09:17:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4m7o-0000dM-3O
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbaGIHRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 03:17:02 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:40841 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaGIHRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:17:01 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so6282919qcv.26
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ChBqVqkgAhk/+8//mHyS61k7OGxtgUd0M3/tEJRVxm0=;
        b=OuHHDSCebr1EXzg0VSJfIKtGcvnJMx9b+j59TWlM4TULX2jemx/2hb63JDxZW8f4CP
         +Zvn64BYurf1dy1/qh9T+I6nyY8rjfVXsND+nbx5041BRqxcPaE0FrZjgYc2qR63LpCu
         tCOsEHDtq4dT/0fCmrv7gr0m7bfPcb0L6yRaIOCkY35kY2FEIv8EIxi9UQEdZz+NaAFg
         I9yI0IlG3pPj394f9i5uQDF/gWd4APoVcUehLjKeTEbpnuhIvwy3u2dW1b7WW65u+6dS
         ai99/Hu7n5Z3z60zR7Tiil8n0lsxZ1HYakpn4GictBcMxtj6mcFEfH9fTBLPomj5DI52
         YdsQ==
X-Received: by 10.224.22.12 with SMTP id l12mr68646066qab.88.1404890220713;
 Wed, 09 Jul 2014 00:17:00 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 9 Jul 2014 00:16:30 -0700 (PDT)
In-Reply-To: <20140709065145.GB14682@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253074>

On Wed, Jul 9, 2014 at 1:51 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 30, 2014 at 03:04:19AM -0700, Gary Fixler wrote:
>
>> I just made a new test repo, added and fetched two unrelated repos,
>> and then did the log view (all/graph/decorate/oneline), and tacked on
>> --boundary, but saw no change. The root commits looked the same.
>
> There was some discussion a while back on making root commits more
> apparent in the graph view:
>
>   http://article.gmane.org/gmane.comp.version-control.git/239580
>
> That topic has stalled, but perhaps you can help push it forward.

Grafted commits are marked --decorate, so perhaps another (simpler)
route to make root commits stand out is decorate them.
-- 
Duy
