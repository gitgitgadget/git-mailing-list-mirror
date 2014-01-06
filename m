From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 00:19:02 +0530
Message-ID: <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:49:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0FFD-0005RV-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbaAFSto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:49:44 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65443 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbaAFStn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:49:43 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so17996613iej.26
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 10:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nDR6R5cYjQjBihXTqvGcRCiCUP9LyKjCvHgIp3MURX0=;
        b=hsP+UWR+70G0YDW78ZpaIVGtih85XnIMz5T9q9c+pxPBFyR8BFtrULU78U7qfRI87O
         XAHmtSHD1hDBLDQb/5ECEtPaFmPE+WgaNW/qqSW/LSVFdkVopYC9lyHnUWnOEO8PLJG/
         USjPxCBzC6T43m7wV/hPAYY+hUbXacdyMcqhWzOl7s+wy9LlVklzpAv7YrjSCpgKizC/
         PpO7g7NmiNyX5B8huvQkBlz/lnb4ODV7bgk6P33cuSQAOgRogq9922ml1ANZbEiVJpzg
         z3TDGspn1YavXTNpC3KREPe87jEr4BvIuJkX6LUsmoFPlk7vh2TWIvfl3dttu+MVztP7
         dHaw==
X-Received: by 10.50.25.227 with SMTP id f3mr21527004igg.16.1389034183013;
 Mon, 06 Jan 2014 10:49:43 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 10:49:02 -0800 (PST)
In-Reply-To: <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240047>

Junio C Hamano wrote:
>  - why is a single branch name sufficient?

It does accept a <revision>, so any form is allowed; but why would
anyone want that in a format.defaultTo? I'm not sure we want to impose
an artificial restriction on the configuration variable though.

>  - is it a better option to simply default to @{u}, if one exists,
>    instead of failing?

I'm not sure @{u} is a good default. Personally, my workflow involves
publishing my fork before sending out patches; mainly so that I can
compare with @{u} when I do re-spins. People can put @{u} in
format.defaultTo if it suits their workflow though.
