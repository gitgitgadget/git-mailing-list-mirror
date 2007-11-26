From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 16:32:29 +0100
Message-ID: <1b46aba20711260732v297c5c35kbd007b9f13f351ff@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
	 <20071125222314.GC21121@artemis.corp>
	 <20071126012837.GA5402@dervierte>
	 <7vejedh6xl.fsf@gitster.siamese.dyndns.org> <474A698A.70100@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Steven Walter" <stevenrwalter@gmail.com>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Adam Roben" <aroben@apple.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 16:33:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwfxM-0006GB-5p
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 16:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbXKZPcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 10:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXKZPcc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 10:32:32 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:29459 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbXKZPcb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 10:32:31 -0500
Received: by wr-out-0506.google.com with SMTP id c49so498205wra
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9fDxFmGpR5OaJSsrU/sUaA18PMF9wKya57r4JAVjf/A=;
        b=DSN8YI5NtYjVlZ/OWU75t0x5NUuhBuwO3sek8QnDDSVJPxrsP3STQMrjM3t3jwrISEwtVixrcy0wKYa3+1kPZwDzFHBTBmBqLfquYqDVKiY1xJB8olcV05YLOdEZNYHFDwbck71PerZc3WcL9Mo7AQdBDsRQJsLD2wdr0oAH1PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bm1kcIOZIaeuuB1Gl8HGX+8V7kMTMpORiUB2VCx20Hv5nAIzdqkNDIyODNJsbN+9b+hnL4tr4ELwBL5SU/EuAmfdnQDHszGOykbjImZVwOlNVi2YMCDGpMuytnbHh9LIz5H2GxM+Nh2rWoCW+qJeDm5fOZMPEM7N4mn6iCnxFqA=
Received: by 10.142.203.13 with SMTP id a13mr367493wfg.1196091149186;
        Mon, 26 Nov 2007 07:32:29 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Mon, 26 Nov 2007 07:32:29 -0800 (PST)
In-Reply-To: <474A698A.70100@apple.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66077>

On Nov 26, 2007 7:36 AM, Adam Roben <aroben@apple.com> wrote:
> Junio C Hamano wrote:
> > Steven Walter <stevenrwalter@gmail.com> writes:
> > Let's clear the confusion.  Although it is not bad like the above
> > "random 5 different operations", checkout does serve 2 quite different
> > purposes:
> >
> >  (1) checkout a revision.
> >  (2) checkout selected paths out of a commit (or the index).
> >
>
> Given the above, I'd argue that it serves 3 purposes:
>
>    (1) check out a revision
>    (2) check out selected paths out of a commit (or the index)
>    (3) start working on a new branch
>
> It's true that (1) and (3) are very closely related, but I think in the
> minds of many git users (particularly new ones) they are distinct.

I think this is mostly due to the idea of a branch as a separated box
(like a directory) instead of a line of development like the notion which
comes from thinking in a branch as the place where HEAD is pointing to.

Personally, it is always difficult for me to understand git as a whole,
because I'm not sure what is the common use case for each command in
the most-usual-way-of-doing-the-things when using git, despite of having
long and complete documentation for each individual command. The question
is if we can give the power of git to their users in the same way they think,
or how git could be able to teach their users to think in the way it works.

An idea would be to study (and document) the most successful
use cases that git supports and check if it is already providing
unique and/or clear commands for them.

--Carlos
