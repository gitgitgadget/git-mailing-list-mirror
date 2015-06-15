From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/12] refs: move the remaining ref module declarations
 to refs.h
Date: Mon, 15 Jun 2015 12:48:02 -0700
Message-ID: <CAPc5daXrHiRjZ=dFH3Mp4tcoRAEABS5_1vz7J+vgGgBmxyiqXw@mail.gmail.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu> <79947baebd702f8e9fe9b667e2eeb69afa73094b.1434206062.git.mhagger@alum.mit.edu>
 <xmqqfv5salh9.fsf@gitster.dls.corp.google.com> <20150615183504.GB4041@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 21:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aMt-0001Y0-PF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbbFOTsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 15:48:24 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35421 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbbFOTsX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:48:23 -0400
Received: by oiax193 with SMTP id x193so8917900oia.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VGsXHEGo7aRj78Qeyc9vmu8oDg+N9I9n1Ynbmf1a/pw=;
        b=Lp8cKc++/zo6gCL5cptTqFjbqMZYUaLLmq/IttBq+hj/9jOQGVgYELsFEy4JKX9FR2
         aibpjHA9p1ApZLGEvKqgvKcHfOCH4s/1djAeLYnKCO4xSh61hRA46pYwv/7l0g7iBCXy
         KWygi4xSntUZvzANh2rX3V7mtl4GoM292rmNzq612Puu7sEV6l98wtVdoqbn0RCjzMkk
         vJyw3fvTynpaeTfYQCpFRL6IYY9/dGJgFRNGDqYFbrPZ5ov/loNBY9zboavRlSM1fLYU
         izJuNr9YjGhD8UwSOZNl73E6AuDAnRrrwuhrwa+fwQqJ80ZisuKKi8vSh84wGkwVxEZF
         7H5w==
X-Received: by 10.60.79.97 with SMTP id i1mr12011101oex.44.1434397703256; Mon,
 15 Jun 2015 12:48:23 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Mon, 15 Jun 2015 12:48:02 -0700 (PDT)
In-Reply-To: <20150615183504.GB4041@peff.net>
X-Google-Sender-Auth: bGWXQyOFHgxsBKvheXJ9C_XTYws
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271718>

On Mon, Jun 15, 2015 at 11:35 AM, Jeff King <peff@peff.net> wrote:
>
> I think the real benefit of naming parameters is that you can talk about
> "fn" and "cb_data" by name in the docstring[1].

Yes, I would think it is a very sensible thing to do, if a patch that adds
docstring adds names so that the documentation can refer to them.

But otherwise, the patch presented here adds only noise without
adding much value.
