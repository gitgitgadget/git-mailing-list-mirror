From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 11/13] tag.c: use 'ref-filter' APIs
Date: Thu, 3 Sep 2015 19:02:15 +0530
Message-ID: <CAOLa=ZSprm90wFcC1-0GOiUmSS0XRmV-gfEg0CYUN45A15CYLw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
 <xmqq8u8oq2lq.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQXgVXSB9FqhXnc5npOrW8HVj97i0XhNeM-k-MJHR_xfw@mail.gmail.com>
 <vpq37ywol3m.fsf@anie.imag.fr> <xmqqpp20ojpf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 15:32:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXUdI-0007KS-GH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 15:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbbICNcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 09:32:46 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34535 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbbICNcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 09:32:46 -0400
Received: by obcts10 with SMTP id ts10so32319181obc.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VsFlfXGdcQjpWabhWaEJUrMoz005fwZg2AYSxaFp1xo=;
        b=uv/ISvfHuTRaOioxJU9IkMjGtguhW8r+PqebR2fRdQBhe192LMvlm3BCewoZnvwBI2
         M0IJPeEMAMShh7isfnz9YqLndoILwu8ve7NE5ogCmBEr1q5t30zclULeRX/LjYqX1+GL
         /+PkKSQa8S5+lmu4JHU9KHF4uGIC3V/zvLDn3vSkAaVgwGSorUrm3qwGbzFVojYfK76R
         VvFNDZD8autZ7O3dWuRSbaIsjV79+ZyMjqgQIW5TJ92kvARBRnMxh9Gt2ROBFLrep8cA
         AooobWkrXBOAJ0tjxRilmHvJ4hTXGOMLyzSr8/IAr6qu/LMmTOXT8yLuPVwIz4y6Bc2y
         6KNg==
X-Received: by 10.60.43.105 with SMTP id v9mr22943912oel.1.1441287165319; Thu,
 03 Sep 2015 06:32:45 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 06:32:15 -0700 (PDT)
In-Reply-To: <xmqqpp20ojpf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277201>

On Wed, Sep 2, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I actually found the other more readable, as it reads "display the
>> refname aligned on 15 columns, and then a space",
>
> FWIW, I too find the "15-col followed by a space" easier to
> understand.  I was merely being curious when/why Karthik changed
> preference, not objecting to the actual choice.
>

I'm surprised you recall that from memory :D

-- 
Regards,
Karthik Nayak
