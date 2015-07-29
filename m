From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 18:23:07 -0700
Message-ID: <CA+P7+xrfr7S-Xc3eQeg2bMY3mkPA5sjGWsozv3MwQhAA=ENkhg@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
 <1438107144-24293-3-git-send-email-dturner@twopensource.com>
 <xmqqpp3cds44.fsf@gitster.dls.corp.google.com> <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
 <CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
 <xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com> <CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
 <xmqqlhdzby5o.fsf@gitster.dls.corp.google.com> <55B824BD.8000003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 29 03:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKG5l-0000p3-EU
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 03:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbbG2BX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 21:23:29 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33529 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbbG2BX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 21:23:27 -0400
Received: by ioii16 with SMTP id i16so6085697ioi.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NAIHnsfQ13+41AnAmGrLhUlZtQ9xEsVzYMtqq0mafI0=;
        b=DlLxXAmyod5DQS1CIowNArTCz47vjm6Y31jXf4Nm1Rphxnzevd5QwwqQghIjTlWip2
         hrgoDK0KqSEVU9ixH4HPz7DU1sl/ZxW4bcdgs6JLT6x8w9QEvdnRZubIRmJrr1c5haal
         il8b0HeD2IuWTk5cdI9F5kgaKrT12MQ7Tze8qy3w3G+0aCX9qCFm1clVt8aWar8BCkSl
         fbkQbCZAGQB6LiLsELoOecd4Sey3XDo8DJ5kDHBkEAqmOse1tYh+81OcX6XbDcnQdCL5
         Kr1HuCO7QdkUWxzC8nyfaINEtErmjJvF5OWLehVaocMDOTGEUa3yOaJuZltFJuPjoPj7
         cM5w==
X-Received: by 10.107.136.15 with SMTP id k15mr43242757iod.67.1438133006839;
 Tue, 28 Jul 2015 18:23:26 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 18:23:07 -0700 (PDT)
In-Reply-To: <55B824BD.8000003@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274871>

On Tue, Jul 28, 2015 at 5:56 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Johan Herland <johan@herland.net> writes:
>> Here is where we start to differ. I would say that starting a notes
>> merge is completely unrelated to your worktree. Consider this:
>
> It sounds like what a notes merge really wants is a new linked worktree
> that has branch refs/notes/foo checked out:
>
> * This would allow multiple notes merges to take place at the same time
> provided they target different merge references.
>
> * This would prevent multiple notes merges to the same notes reference
> at the same time by the same mechanism that prevents the same branch
> from being checked out in two linked worktrees at the same time.
>
> It's just a thought; I have no idea whether it is practical...
>
> Michael
>

That seems far more flexible and robust to me.

Regards,
Jake
