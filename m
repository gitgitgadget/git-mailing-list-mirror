From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 1/4] Consistently use the term "builtin" instead of
 "internal command"
Date: Thu, 2 Jan 2014 22:05:42 +0100
Message-ID: <CAHGBnuO+MT4pZHD8AiQ5mFU8bDwoFSgaCyxUzL572YVstCerqA@mail.gmail.com>
References: <52C58FD7.6010608@gmail.com>
	<52C590B0.1020702@gmail.com>
	<20140102203132.GQ20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypSd-0003LM-0j
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaABVFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:05:43 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:47801 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbaABVFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:05:42 -0500
Received: by mail-qc0-f179.google.com with SMTP id i8so14342792qcq.10
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yWchqHFfNWhqTmRco1rf+D1cYz0UxojvDyT0kMC6+vk=;
        b=BOXNV93JzkbsjhyVlFNS2UJmLJpJrdzNq4ghh1CsQmddCe4XbZoNZwsPCtgfGrMmir
         IfuAvP3TLyEz7y4YxddtPjveG8qaDdg2j/gTR/8fZ/l//po1IfUwKguodTaDnMOOcupd
         pLTegwkryxzIrKoCBEA6kBuaYSCTxTlaWf+CaElmIrtQQ43sqpI62O9VMoutpNuBsBPi
         i3UDrsM+AQjV1couJqagOPRNXqGAyMczWwuHLiifP65GTlJ8t0BCce27Cb2XvA68J36c
         /6haIRJQP8dPPKCDoPJ2eU/2UtpnuQaEMHvu+yg/+kP8aAhVlbp2WCFz5wphfSuJyg3k
         iiag==
X-Received: by 10.224.156.77 with SMTP id v13mr141428759qaw.80.1388696742215;
 Thu, 02 Jan 2014 13:05:42 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Thu, 2 Jan 2014 13:05:42 -0800 (PST)
In-Reply-To: <20140102203132.GQ20443@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239880>

On Thu, Jan 2, 2014 at 9:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> would just leave me wondering "I never claimed it was built-in; what's
> going on?"  I think it would be simplest to keep it as
>
>         $ git whatever
>         fatal: cannot handle "whatever" internally
>
> which at least makes it clear that this is a low-level error.

Right, I'll change this in a re-roll (using single-quotes for the command name).

> The rest of the patch looks good.

Thanks for the review.

-- 
Sebastian Schuberth
