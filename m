From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Wed, 12 Mar 2014 02:32:39 +0100
Message-ID: <CAL0uuq0LpQTQPeNVJgKGS2YLTT0gi_BM0wi02c0EP+kvBE4DyA@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
	<xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
	<CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com>
	<xmqqr46jqgfq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 02:33:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNY2V-0001QY-03
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 02:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421AbaCLBcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 21:32:42 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:36574 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbaCLBck (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 21:32:40 -0400
Received: by mail-vc0-f178.google.com with SMTP id im17so2493533vcb.37
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 18:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=In14YqJYTuZedUMEoRLnajYb26C1RoWK+3YO8LoLSLM=;
        b=ErNVPBn2/fuj1bUm7FdiIXpUpbw1cXAIpLYSWtfOCdfjn2DNYAqabyHpw87vaytIkO
         e8z4inwmX0IgCqv5MjRcxgUd259i4JYu67uGVHc3Th84F0UBm9Ejuf2KoHrUhT5d1ItA
         5CmbvuR590f54lN3K7lNseHkAA04d7NF3tsG6cKlNAM+sESktciKI8EACmss445iwYoW
         UcB69VvtOGFN4xJ7He/w9DaJGFNqXG+7UQdbjcW+w+rcTrHMssPFPJwHHi0205FDI4um
         eDwDdhKjnsGH5Q1EoQ/NAxQ+SKKIjxZSFkjSu2kMCL43VSFYKtLVbUYPRPgkAJq5ZOXw
         Nomw==
X-Received: by 10.58.248.228 with SMTP id yp4mr77415vec.35.1394587959650; Tue,
 11 Mar 2014 18:32:39 -0700 (PDT)
Received: by 10.52.2.165 with HTTP; Tue, 11 Mar 2014 18:32:39 -0700 (PDT)
In-Reply-To: <xmqqr46jqgfq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243916>

On Mon, Mar 3, 2014 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think you fundamentally cannot use two labels that are merely
> "distinct" and bisect correctly.  You need to know which ones
> (i.e. good) are to be excluded and the other (i.e. bad) are to be
> included when computing the "remaining to be tested" set of commits.

Good point. Yes, this isn't viable.
