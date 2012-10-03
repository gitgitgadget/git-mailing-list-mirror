From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 16:37:01 +0200
Message-ID: <CAB9Jk9Bqq=fs4v-oAj_TiaSw5WOiQQFsm_WEZP_ECyPW1L_DHg@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<m2fw5vooem.fsf@linux-m68k.org>
	<CAB9Jk9Dqoom-hBQPG5iqe2JyiJtVoFWZ9-5W9ktUsa9F9mbXRQ@mail.gmail.com>
	<m2r4pf1xh6.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQ4h-0007mc-GT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 16:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab2JCOhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 10:37:07 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57590 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab2JCOhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 10:37:05 -0400
Received: by vbbff1 with SMTP id ff1so7906659vbb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E2uv+Uenh3KRW775/z0SHQ8WKT4c8ka85gaNSKIDBGo=;
        b=0Gw+Dv4vCxsTzyykNgN87Rq2AlHcvX8risg5vh3X2ouW1ahegr+a+tCdOU6f/ScYFd
         ooKSVQhsaKEgMp7tKjpSiNj3l+LrZvHi1gs7vEI6C3iSSJE6c2tocUZ2oLMtfNo5rGvX
         LNakss3+w+FEEMSyOrIA+aVjUgQckFo+7BuOOgqQEw4+6PG5NPyNUXPZeidEnVc35okI
         1kFHKKeZUpoMNRO6r1OvonPKM9S5dpPkt4dQ/VoOYYY/YEhDwyhmivuixVtjyRJRM57y
         ghY6bIR/wqLcxAN5g19hFOY4yVySkad7tD+f7UZf7GQ+NWZKLg9SGGGhBiyoLYxGvYi8
         sk9w==
Received: by 10.220.152.11 with SMTP id e11mr1204284vcw.61.1349275021365; Wed,
 03 Oct 2012 07:37:01 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 07:37:01 -0700 (PDT)
In-Reply-To: <m2r4pf1xh6.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206901>

Hi Andreas,

> But where does it say "different and unique"?

It does not, but it says: "Usually recording a commit that has the
exact same tree as its sole parent commit is a mistake, and the
command prevents you from making such a commit.", followed by "This
option bypasses the safety ..." leading to thing that the option
negates that "prevents" above.
I do understand that by reading very carefully each word of these
sentences one can eventually figure out that the option removes the
check on the tree only, and that all the others remain, including the
one on the identity of the time. However, it does not say that the
time must be equal with the approximation of one second. Apart from
this detail, it does not state plainly that no commit object is
created.

-Angelo
