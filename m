From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Sun, 18 May 2008 03:01:53 +0200
Message-ID: <bd6139dc0805171801q1c07f902p1882f65a77345d71@mail.gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	 <200805121440.12836.jnareb@gmail.com>
	 <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
	 <200805131507.04912.jnareb@gmail.com>
	 <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
	 <7vlk29er1w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 03:02:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxXIT-0003DZ-It
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 03:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbYERBBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 21:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757240AbYERBBz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 21:01:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:37843 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbYERBBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 21:01:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so781639wfd.4
        for <git@vger.kernel.org>; Sat, 17 May 2008 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=4FEwFL83v7yWERKIZSh+IBzBi+tCStprJdJxOmT0HXg=;
        b=iJg2auTPx9G6Lg2YaZUVTO+2zWXbZhS6nuQYd4D+E7f6VVhu27yFk6dQwreQrZL8WUb/8Lw83rRf/AJM0bB0FriciIvhZUg3g4gFgW+RQel5YN0tdMLlPIkhPgHQF8iHERrKHxX8xvFMHAnLWO8BXP9yntSi6CoO8V/LcbF/WUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=il9d4Jday2OifUb9+Ft6Ehc+vdc6y85XXuyhVjZH5yuBoJ4F/BNHbWyxct+MPPm16ITzgwAX1JAFUtcD6Hh13wFwwQJExQjERK5cq1n0dTdf8P+VKPA7ltfokYMcNG0qNF44k2SPGe+iYDc7qam4wEFYOmbNuPhYmGFIzaRIn0Y=
Received: by 10.142.177.7 with SMTP id z7mr2200631wfe.238.1211072513558;
        Sat, 17 May 2008 18:01:53 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sat, 17 May 2008 18:01:53 -0700 (PDT)
In-Reply-To: <7vlk29er1w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: e417f1f2823efd9d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82372>

[And once more with 'reply to all' instead. Wouldn't it be nice if
gmail had an 'auto-reply-to-all' feature...]

On Sat, May 17, 2008 at 2:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A cursory browsing is enough only when you trust the contributor well.
> For example, I read patches from Nico to code around the pack generation
> only once or at most twice before I apply them, and the same thing can be
> said about git-svn patches from or acked-by Eric.  These come mostly from
> the fact that (1) I know they know the area a lot better than myself do,
> and more importantly that (2) I know they care deeply about the subsystem
> they are modifying, and they have good taste.

This makes sense, patches only get a 'cursory browsing' when they come
from a trusted author, which is defined mostly by how active and how
'good' they are in the area they modify.

> Project maintainers and old timers become familiar with habits, strengths
> and weaknesses of known contributors over time, and that is the source of
> such trust.

This could only partially be done by an algorithm, while git excels in
the 'over time' part, the definition of 'habits, strengths and
weaknesses' is harder to make.

> A clever enough automated way may be able to identify links between the
> contributors and the areas they are familiar with, and using such a
> mechanism people might be able to decide that a patch falls into category
> (1) above.  I am not sure if any automated way could ever decide if a
> patch falls into category (2) above, though.

Yes, your solution in determining patches from (1) is in the same
direction of what I have been thinking on myself. I don't think it is
possible to determine (2) without having access to the review system
(in git's case, the mailing list). When the review system would become
part of the analysis it could provide information on what improvements
had to be made to a commit before it was accepted. If 'style
improvements' would be marked in such a system then people with 'good
taste' are people whose commits do not often need 'style
improvements'. Alas, implementing something like that would be beyond
the scope of 1 GSoC. Ah well, 't is a nice dream about to implement at
a later time perhaps. (Although such would be more suited in a team
collaboration suite than in a [D]VCS).


--
Cheers,

Sverre Rabbelier
