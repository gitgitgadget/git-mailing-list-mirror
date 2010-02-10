From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 22:26:33 +0100
Message-ID: <fabb9a1e1002101326h332508abo1a9da1185120799a@mail.gmail.com>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com> 
	<20100210210419.GA7728@coredump.intra.peff.net> <20100210212408.GB7728@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfK5L-0002im-C1
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 22:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab0BJV0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 16:26:54 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:44592 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0BJV0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 16:26:53 -0500
Received: by pzk17 with SMTP id 17so472042pzk.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=HcJgN+vZl0ENBwETuxPlTKLTkADDRM1UPDD1Y07HE38=;
        b=CALF4RncvGrf9jEdzoCCQUpqF90NRQSeeVBaDv8XUKEox8vXQiAFY8/lvvvqa4baek
         ztT6zQlzTqdpqXaeeP0UNK4DVaU1KhhDHzdFFEpUHPHrtRuxcfJQeXCv7jKEAj/SqdFf
         NTEZA+QbNi7yk8tTJIl/No2scWDXvQ7hZQmoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FHftHUGga7OcCp0qCbxYImsjW1mTLo4Tq5QD23SXvW1cq9Hg2Z0dWTOe4LvZKWC2F6
         3Qrgoo2xwCHYIW8zMMAE/CrfagfCVDjV+cObt1/PYR+U/pap5FR+laKrC9qd29IPA5+r
         jwmjaNPdL3RQ1yR6cAlSO0gXZt18Vcni32f+Q=
Received: by 10.142.56.12 with SMTP id e12mr494607wfa.332.1265837213117; Wed, 
	10 Feb 2010 13:26:53 -0800 (PST)
In-Reply-To: <20100210212408.GB7728@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139553>

Heya,

On Wed, Feb 10, 2010 at 22:24, Jeff King <peff@peff.net> wrote:
> I find the patch below convenient. I dunno if anybody else actually
> cares.

I do, it's useful when applying a bunch of patches and conflicts arise
:). Typing 'git am --continue' is what I'm used to from 'git rebase'.

-- 
Cheers,

Sverre Rabbelier
