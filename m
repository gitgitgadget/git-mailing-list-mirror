From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/2] dir.c: Make git-status --ignored more consistent
Date: Sun, 30 Dec 2012 15:54:14 +0100
Message-ID: <CALWbr2w=CWkpbJhC5sjd9HnErmWj9JQnD6UUiDM91ovJ_-16vA@mail.gmail.com>
References: <20121229072249.GB15408@sigill.intra.peff.net>
	<1356878341-12942-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 15:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpKHb-0003m3-BA
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 15:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab2L3OyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 09:54:17 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:46809 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2L3OyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 09:54:16 -0500
Received: by mail-ea0-f182.google.com with SMTP id a14so5013903eaa.13
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=shM+nIH6QcnCneLVOhugC/OICsfByRxhw3ckR9PTb5U=;
        b=WYCcfCYNgI/E4ELV7REOI1sFJObUNsn+UizEAi76uslKfAajK7j+1zfm7ApiVasUZX
         6EcqGh7r8kJM6R51ZsOMNucNT6myVnBPoOykmWm5fp8eWrCcVMoPw7CBwr8a2TMTIvfP
         CSOLVY5eVexUgon2b+Pmw9l5Pj6gH5L6i1eyFiBfdsJ9vyaT5f7VIonZsLdcc3bf92yU
         7DI8+y9yNDjAnUt8EZdg4Zshc1zXjT8Y5ULUkeV0SphGrGHAU9x8cA6QNdwgE9h4woL6
         xedGVos6ImBimcuToUbWupDM2J77fJgWVHzETiFhD49cGc2hiPdtQR/lItv9iKAMrMZJ
         JvEQ==
Received: by 10.14.223.135 with SMTP id v7mr103612993eep.41.1356879254964;
 Sun, 30 Dec 2012 06:54:14 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sun, 30 Dec 2012 06:54:14 -0800 (PST)
In-Reply-To: <1356878341-12942-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212333>

By the way, that merges without conflicts with Adam's series, but it
will not compile as he renamed functions that I'm now using
(path_excluded() -> is_path_excluded() that is).

By the way, Junio, how do you handle this situation as a maintainer ?
Do you keep a note to manually make the change every time you remerge
the series together ? That is the kind of use-case you can't handle
with git-rerere, and I've been trying to find a solution to it.
