From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 08/14] ls-remote doc: fix example invocation on git.git
Date: Sun, 23 Jun 2013 13:23:43 +0530
Message-ID: <CALkWK0=LRe9V7ETdEAZ7bBEDPFcTv=4cdcAE=CdNA_Xx76+LcQ@mail.gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
 <1371887901-5659-9-git-send-email-artagnon@gmail.com> <7vy5a1guk4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:54:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqf80-0002jP-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848Ab3FWHyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:54:24 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63251 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3FWHyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:54:24 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so22575887iec.36
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0GJJNrHLlQGxsCudrwXK8tlYhOykECldIc7O/hD58/8=;
        b=i8D6YRXeNBYK68g1Wr9o7RJ5UDG2PYFDVaTy9f3BnIE32obtROJhh/MkTdgxjvTZL5
         t3LscgNElHciX6SO5XAPb7o76Mw/Zt3/r+2nuii8GP2JlDZRxbe8eh0nhdUx6jsj6+QK
         L1w/fWS9OJ3j439A7duChlALAOhGcueVdtW5obXmM2wztlPnYt/5qcOFaAkKfQ6QDGad
         kasodOruNrwMbd5di2a9ncYCrqK70XF3Qx/dlqe3MGryAvqdRP5gB2NOBHc9wEclE/Yr
         rQbPfoXa8mou+Cy1lyc2KPvHhUjFdFwr17VbB+DcqiRZa+skQPvHkYZxmu8ZnF5MCvab
         LH7w==
X-Received: by 10.42.76.5 with SMTP id c5mr5905849ick.91.1371974063940; Sun,
 23 Jun 2013 00:54:23 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 23 Jun 2013 00:53:43 -0700 (PDT)
In-Reply-To: <7vy5a1guk4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228728>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Under the EXAMPLES section, there is one invocation on the git.git
>> repository that attempts to list the refs master, pu, and rc.  The ref
>> rc does not exist in today's repository, so remove it.  Among other
>> things, this example demonstrates that the "<refs>..." argument is
>> simply a filter; requesting a non-existent ref is not an error.
>
> These last two lines are better be in the documentation, no?

You're no happy with the existing documentation?

<refs>...::
	When unspecified, all references, after filtering done
	with --heads and --tags, are shown.  When <refs>... are
	specified, only references matching the given patterns
	are displayed.
