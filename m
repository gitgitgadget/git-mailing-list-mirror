From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 000/142] Use the $( ... ) construct for command
 substitution instead of using the back-quotes
Date: Wed, 26 Mar 2014 03:44:25 -0400
Message-ID: <CAPig+cSaOK_EaEcyiuhNKDG=DGpt=NxhM+eJYq34C5=7pSuO1A@mail.gmail.com>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqy4zyktng.fsf@gitster.dls.corp.google.com>
	<vpqlhvx8mt8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 26 08:44:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiVi-0004JJ-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbaCZHo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:44:26 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33693 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaCZHoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:44:25 -0400
Received: by mail-yk0-f175.google.com with SMTP id 131so336367ykp.34
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BWQ8DamJSxJoU7j+jhHRuxUESUBYC1YRFlv7noJHGnQ=;
        b=N/QLowv/eADV/qyHaLgvEW9Ho3s0SGdgVYiwZQDmtOLOhcizISaeHtGnt+6sOOrpLA
         74QGYgYy9tQMa2osZpQiL/ckdsSxgmY/06IyAGHyhSxBodE+yvuFsSzGB5aLTE0xbkTa
         BH4NqBBawUj48kqf6OQBjem4yJW9BcesvHjbzLMdr7F0/ugjMS3HiKC8lycUkzAlplG4
         qEggvxutKGSPfp6OBtG9acemnwMDK2KDtHP1c9QNKFS6C71xiA2xJv09yO+Q8D3jIzU2
         hBr6bcIFV7P4fNaNmLAclZKqm3BQ5ZdUs9bcKAFm+GZ7mYrbxmtCklfiKeU90jH86YKD
         CvTg==
X-Received: by 10.236.46.5 with SMTP id q5mr80010758yhb.21.1395819865308; Wed,
 26 Mar 2014 00:44:25 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 00:44:25 -0700 (PDT)
In-Reply-To: <vpqlhvx8mt8.fsf@anie.imag.fr>
X-Google-Sender-Auth: KevZL4ePS2MHr5Bm7BF7NsJxg6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245168>

On Wed, Mar 26, 2014 at 3:02 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>  - Nobody has time or energy to go through 140+ patches in one go,
>>    with enough concentration necessary to do so without making
>>    mistakes (this applies to yourself, too---producing mechanical
>>    replacement is a no-cost thing, finding mistakes in mechanical
>>    replacement takes real effort).
>
> It's a bit less bad than it seems:
>
>  142 files changed, 609 insertions(+), 609 deletions(-)
>
> The first pass I did was a very quick one, but I already went through
> the patches I received (apparently not the whole series) and it wasn't
> that long.

I also gave v2 a read-through. Nothing jumped out as a red-flag.
