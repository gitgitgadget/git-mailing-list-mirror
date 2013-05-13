From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Tue, 14 May 2013 00:55:25 +0530
Message-ID: <CALkWK0nH598SGojvcYS0TdhA=5r9kUY6XTzOa3VWQwd85qs_Ug@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-5-git-send-email-artagnon@gmail.com> <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
 <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
 <7v61ymop61.fsf@alter.siamese.dyndns.org> <CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
 <7vppwun5zk.fsf@alter.siamese.dyndns.org> <CALkWK0nmDopEVArofKt42u5JHRBXmGiHP051jhMxtaihWLu95A@mail.gmail.com>
 <7vli7in2wq.fsf@alter.siamese.dyndns.org> <CALkWK0nygD7dpwZkXYMuXHhVZpRzb968wAYq-xZrj=y7duL1ZQ@mail.gmail.com>
 <7v61ymn10i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 21:26:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbyNw-0004gq-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 21:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab3EMT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 15:26:08 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52844 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3EMT0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 15:26:07 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so13251302iea.18
        for <git@vger.kernel.org>; Mon, 13 May 2013 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UsmVsGnQPyfCj+ZbuT1xsInsj4JvJApclBR+VUVkNz8=;
        b=D2iFOTW9gxo+2yb70McLg3LklZKEr4UJr2F1p+FPJ4L52THf21j8HqufWJ8RYW+QQc
         j99g0y1wgUagti38xuZhLfuEhsJ8mnyJxCVxf6MUo/8X3DvzDgcSShXTU4d7o4H0O7xt
         jzf/67jEBHXVRxasURP48v+NGYNyIXAxETeCzKa1JvxQMnkx6vH7grBLsXBqxNBxZzFy
         9OBgnKA8EOC0Ys49lqxJBWWjQDsL9PRYn8QMXJjaT9WZ5ZytamBz6iAuCDZJ0z4tcjNw
         ZYAIrdUdt7jfJTHQ2u1tvQ0QCbb+mFP9gKau4OIwz18ERkDuDI4WhTu100aCCcrvkWED
         1SSg==
X-Received: by 10.50.147.71 with SMTP id ti7mr11287602igb.49.1368473165846;
 Mon, 13 May 2013 12:26:05 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 12:25:25 -0700 (PDT)
In-Reply-To: <7v61ymn10i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224196>

Junio C Hamano wrote:
> The whole point of my response is that it is not a valid approach to
> decide to add (or not to add) a reasonable enhancement mechanism
> built in from the beginning by asking "what future enhancement do
> you foresee today?".  It is unclear if you got that point.

Right, got it.  The fact that we weren't able to foresee the merge UI
problem tells us that we're capable of repeating the mistake no matter
how much we think we've thought about it.
