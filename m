From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/16] t/t5516-fetch-push: use test_config()
Date: Sat, 22 Jun 2013 12:45:49 +0530
Message-ID: <CALkWK0nAJ=8e2ZNh9T7Ys2A5fq6ALu4+xofS-1a0rnBsEy=RqA@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-9-git-send-email-artagnon@gmail.com> <7vobazjdrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 09:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqI40-00009Y-Mo
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 09:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab3FVHQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 03:16:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54749 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3FVHQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 03:16:30 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so21030418iet.37
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aI5VbYhz7goeBcfud0AcD5VdZMBny3dY4K3XwWmeKdg=;
        b=eeJs2BuMcK3ULkWPBiekuhp1s4rk/iOn7GfYDQbZY/2FhePz8Mu/QA9tElRQI9EylR
         KgmekOO3SAuGtZjDlFs/b0lc2nu1pUW3kkN5hs7hDwRMEPmNyY8qGpU5nv13il5VjOiR
         GBl3dKv8lQSJS0q0/Rd8hPBpKl5b4Jn/AZEPcyrapyWGIq0j5FR3cEoB7C09lMkkXQcK
         uScoY0gSs6/CdstJBvag5/VEu1Imq0Q5V4D1iv9br4IVFAU5p8nBHahFqxLfU9GIGSYY
         FHxt0JfEGp9meYNISupsZ6ckOY76pfMFzJlNM3YFFmqTROvseA9yfNegtPj2bIX/HNTo
         PWGg==
X-Received: by 10.42.190.74 with SMTP id dh10mr7674444icb.35.1371885389800;
 Sat, 22 Jun 2013 00:16:29 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 22 Jun 2013 00:15:49 -0700 (PDT)
In-Reply-To: <7vobazjdrf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228673>

Junio C Hamano wrote:
> That may be a good thing in principle, but I _think_
> [...]
> sequence is used so that we do not even have to worry about what
> leftover configuration values are in the testrepo/.git/config; so
> does it really matter?

Yeah, you're right.  Dropped.
