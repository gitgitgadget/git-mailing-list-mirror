From: Ed Hutchins <eh@demeterr.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Tue, 2 Jul 2013 13:34:05 -0700
Message-ID: <CADL+T9ax0maws3GR24YV77Yge7knqHd5mfuPd_AqE9b4UmvYPg@mail.gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	<7v38rwlola.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 22:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu7HA-0006UG-Br
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 22:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab3GBUeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 16:34:08 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:46327 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930Ab3GBUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 16:34:07 -0400
Received: by mail-qc0-f177.google.com with SMTP id n1so3933842qcx.22
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 13:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=/H0zahW3IIBgbKbArz6vbaHKGximU+aK5l4uwsA+5h8=;
        b=TZGbnRhloAfKsH12JCx1fKd1imxqafhyGaLTqGlz3Au1YHPkN8TF4MVmT1qJLpJHy2
         jnsh+kLOXx9eTDA5/BfbebhRO5/c5WJmVx5AUrWVWXX8dnNw/F6zAnvyxdbkq16Lm314
         cEyi2WBhjeHrs8HX/yRxcW/d7sfUbQaQ8E3AxK6guNM0j2xN1rGsO13HHuOLi2+ZabsF
         jf5cMcnwY8WM0LI1b5qcWUJc9wqJU6ARI/e3sZO0wfBqliiO7SmkufNoQJTNVV1LsQi+
         OzQp/yFGrhhmmXNOR6KpuqcRyCRjQc6giGJRgQYnvPr1egj6sJIqHyM49vL5xcQPTbUr
         SDHQ==
X-Received: by 10.229.170.199 with SMTP id e7mr9418584qcz.29.1372797245386;
 Tue, 02 Jul 2013 13:34:05 -0700 (PDT)
Received: by 10.49.76.234 with HTTP; Tue, 2 Jul 2013 13:34:05 -0700 (PDT)
In-Reply-To: <7v38rwlola.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQla93CAisO1m79ajb3E2iSUfzWpj0dZEsqi7mXMCXfEeGsnTkpkFF5Ik7s8hvTa29q1enpP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229427>

I'm not sure I follow how it could be actively harmful? I would think
the "author branch"
nomenclature (as opposed to just calling it "branch") along with clear
documentation
that these values are just captures of the particular state the commit
was authored
from would more than assuage any potential misuse. On the other hand
trying to figure
out the history of events from a large directed graph of commits
without any clue about
what topics first spawned each commit is actively harmful in many
cases (trying to display
a clear history of who did what for what reasons, for example).




On Tue, Jul 2, 2013 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ed Hutchins <eh@demeterr.com> writes:
>
>> I realize that branch names are ephemeral repo-specific things, but it
>> would be really useful to be able to determine what branch a commit
>> was authored from (as a hint to ancestry graph layout tools, for
>> example).
>
> Hmm.  I think the current thinking so far is that it is harmful to
> engrave that information in the commit object, exactly for the
> reason you stated upfront: these names are local in the repository
> the commit was created, and do not have any global meaning.
>
>> Is there any way to do this currently, is it planned, or
>> would it be deemed useful enough to be worth adding to each commit
>> object?
>
> No, no, and no, not because it is not just useful enough but it may
> be actively harmful.
