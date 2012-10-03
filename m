From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 21:11:22 +0200
Message-ID: <CAB9Jk9De4h=X3A8ypW6FG6L3B8katmTxhaPY9zhQ+UP1WJd6gg@mail.gmail.com>
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
	<CAB9Jk9Bqq=fs4v-oAj_TiaSw5WOiQQFsm_WEZP_ECyPW1L_DHg@mail.gmail.com>
	<m2fw5va4jc.fsf@igel.home>
	<CAB9Jk9Aa4d4H5q1euCJ4hdc_K9iBrfiJFnyAYQ+BRNX3D023gg@mail.gmail.com>
	<m2iparnztj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:52:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIQ-0001DP-MO
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab2JCTLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:11:24 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40865 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab2JCTLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:11:23 -0400
Received: by vcbfo13 with SMTP id fo13so8714705vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WfKF+Rj4dDVmMkDo6QRTQ/AflIx7OfA3I0uQIoSI1PY=;
        b=jsCXi5KlOcIRSzDsYzel0wpdMI3MJo4f+4AYz616N0O033hpvJEbTzlwk+EqJi0/fs
         SqMwcWR9cJDCgbH4RGnv1IYNQEMm11uyDaAFX8DEAIpxeJnhg5U4EoJjCRzQp1O84F+9
         umUcWZ33VauCMHKSuMxG4mVPrcFxItCNd9UkU5nLGQya3Ivumoa1iA72GhPNA24uxjvK
         xriOOtKV9poFqK46+aDd8oU2cyb1aIuBYZvs7GiroForB2aZ7PDB8BavvQv7YSJi9vW/
         BXujVVdqX0NPkjH+/BfFkQ+YUmhwdyP+uukMBhljtBn5k+qzRKd+OnKqZaT8axE6Q23L
         fxlQ==
Received: by 10.220.152.11 with SMTP id e11mr1644206vcw.61.1349291482955; Wed,
 03 Oct 2012 12:11:22 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 12:11:22 -0700 (PDT)
In-Reply-To: <m2iparnztj.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206934>

Hi Andreas,

as a user, and owner of a repository I do care about the objects that are in it.
I do not care about the way they are names, be it numbers or sha's, but for
sure about their existence.
So, for me it is important if a command creates a new commit or not.

> The commit is _always_ created, with a name depending on the parent,
> message, author and date.

I do not understand this: I have produced several examples that show that
it is not created, i.e. that the very same objects are present in the repository
after the command execution as they were before it.
It is possible, though, that you use the word "create"  with a
different meaning.
Most dictionaries state: "to cause to come into existence", i.e. before creation
the thing does not exist, and after creation it does.


-Angelo
