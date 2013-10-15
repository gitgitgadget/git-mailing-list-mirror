From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] symbolic-ref: trivial style fix
Date: Tue, 15 Oct 2013 16:16:28 -0700
Message-ID: <20131015231628.GG9464@google.com>
References: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:16:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDqt-0005Iu-PA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766Ab3JOXQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:16:32 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48436 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933632Ab3JOXQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:16:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id kp14so123090pab.20
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 16:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fUhRVsRT+cRdCCGUkMYcJekRT5nCk55VTuQwuECKCFw=;
        b=HInyoQi9IHlKQJc9xKSnaCD9cKib5DmO/dbGcoSnTWr6QwQL0y6HK9ImyYbTWcbt7R
         hHI8wsVPER4zmr10ygIQfYlhVSrBReLrjjk6ITP/GlDKW1WIF7vPtlrdFIkUw5haFb4P
         7Wp5LtAEnLPZfWNp9FZhBAKX0ecDHh3CZqe30RmavbBIANKShU6WhZ2imGbhbkZUIgKK
         z9KaFKd1QNJgp12fN6qQTZ3NUB4VoIVoUsNdiLBE07DI2OL8DB7uPFA8i6BkXKt6pq5H
         cp8+fNsaZ23uCC2dgeKybA1bx6S5TIjp8QY1TGvTu7REF4PvdOUdi3fpbYP24xG14FUG
         A2KA==
X-Received: by 10.68.48.166 with SMTP id m6mr43498876pbn.105.1381878991266;
        Tue, 15 Oct 2013 16:16:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 7sm101855789paf.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 16:16:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236218>

Junio C Hamano wrote:

> From: Felipe Contreras <felipe.contreras@gmail.com>
> Subject: C: have space around && and || operators
[...]
>  builtin/read-tree.c    | 2 +-
>  builtin/rev-list.c     | 2 +-
>  builtin/symbolic-ref.c | 2 +-
>  compat/regex/regcomp.c | 2 +-
>  xdiff/xemit.c          | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -339,7 +339,7 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
>  	      p = buf;
>  	      *p++ = dfa->nodes[node].opr.c;
>  	      while (++node < dfa->nodes_len
> -		     &&	dfa->nodes[node].type == CHARACTER
> +		     && dfa->nodes[node].type == CHARACTER

It took a little staring to see what changed here.  The preimage has
a tab, probably from an autoformatter gone wild.  I don't think fixing
it should interfere with importing new versions of compat/regex, so
the change seems fine.

Thanks,
Jonathan
