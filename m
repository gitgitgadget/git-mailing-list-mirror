From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Sat, 27 Jul 2013 13:37:01 +0530
Message-ID: <CALkWK0niBpmD6S78rTvQcQVjdQ0yPE7K1kqt7gmQhEo7CvY=gA@mail.gmail.com>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net> <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net> <20130726213705.GJ14690@google.com>
 <20130726214036.GB1388@sigill.intra.peff.net> <20130726224359.GA3928@sigill.intra.peff.net>
 <20130726230527.GA12968@sigill.intra.peff.net> <20130726230857.GK14690@google.com>
 <20130726231902.GA1674@sigill.intra.peff.net> <20130726233928.GD12968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 10:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2zYD-00013j-6d
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 10:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887Ab3G0IIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 04:08:12 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:54569 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3G0IHm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 04:07:42 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so5983952obc.20
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sZlZxljG6+ggbYa7WXidvTaUEAFFFJBiVpO+tb+DDnA=;
        b=iAE/VEm8lvyBr4qJ3QE5zppF5rFq0gc9DnKBZITzK1swyvi5BGrefGAYDdeO4xe8Uo
         U4KUm9Li/H+4Jl0Scc9sZbsPpSJvMWiY0uBzpgJzjEP+TaeCcWPexZY8yTQiP29fwnYQ
         M6CZXnwyMVZENhPQKQI5b9G6NE5qN2o+1nbEACGAcj0ccREi8TGOHIRCtR7NgGuRe26x
         SqN8JeODEavyFuVZ7myl+2qiGj1h7vUsaZ36bcJU9a5ujHqOWDl1VPaY5nUCYwqLt2Ju
         yxypgfidui/LO8OVOhIoeB7idMu3wCXAGSiARkmBN0LXUHcNib7AaBQYRxZpK46sbJZx
         mj/w==
X-Received: by 10.50.47.12 with SMTP id z12mr197595igm.50.1374912461570; Sat,
 27 Jul 2013 01:07:41 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 01:07:01 -0700 (PDT)
In-Reply-To: <20130726233928.GD12968@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231227>

Jeff King wrote:
>  builtin/commit.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Overall, highly inelegant.  The single-commit pick has been special
cased only because we needed to preserve backward compatibility: I
would hate for the detail to be user-visible.  I'd have expected a
series that polishes sequencer.c instead.

But whatever.  I'm going to squelch them anyway.
