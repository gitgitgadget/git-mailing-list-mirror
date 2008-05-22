From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: two git-cherry-pick enhancements
Date: Thu, 22 May 2008 14:28:49 +0530
Message-ID: <2e24e5b90805220158n5c31da1yf98cac8b432a2d9d@mail.gmail.com>
References: <20080521163817.GA13124@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 10:59:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz6eI-00037J-9r
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 10:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765953AbYEVI6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765855AbYEVI6w
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 04:58:52 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:57252 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760456AbYEVI6u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 04:58:50 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1743227tic.23
        for <git@vger.kernel.org>; Thu, 22 May 2008 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8GX+hUOyEZere6tPD+CQ7tNj8xVCeJoRVd8Wpjy0dDU=;
        b=geGrK3AknNQKsBCYzoOQ2GoJ+8BUQI4s/TryFDPMeiGM3sVyqCpvWdz+y+cqhGSVoLnp1WpwMEcadDk0DuKkjGu5X8rHzY6UAh8XuBm+1vCC8nlsxrP2kzhEb1a1V90j/jA+gZAhpaauEKtZJdvhS5XOqvXgRnHHIth5NUI/d60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S3u8EE46SPE/Cnf4s9YFwXh0Gzf3HBuDbxd8wCZobD37Xz/5ueuGqcPjMRja6wsKyJQJqmlxpeLp+jeKtPFTSDTBdM04K10yIxje8nDKszBV/K3slllkUPRNrYPUL1vMvOWMlmzmDaDvhU4vqiGUBcBFYiER1budyhOqUIVvaDk=
Received: by 10.110.43.20 with SMTP id q20mr1408990tiq.14.1211446729309;
        Thu, 22 May 2008 01:58:49 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Thu, 22 May 2008 01:58:49 -0700 (PDT)
In-Reply-To: <20080521163817.GA13124@denkbrett.schottelius.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82605>

On Wed, May 21, 2008 at 10:08 PM, Nico -telmich- Schottelius
<nico-git-20080521@schottelius.org> wrote:
> - Apply only parts of the patch which applies to <file ...>:
>   I sometimes want to apply patches only to some, but not all
>   files the patch introduces
>
> - Interactively selecting which parts to apply:
>   I want only 7 out of 10 changes the patch introduces.
>   It would help alot, if I could choose which parts I want
>   to apply for every part of the patch.

Both of these are (often, though not always) signs that commits are
not granular enough.  Your branch maintainer or developer has combined
unrelated things into one commit.  In an ideal world, he would put
each piece as a separate commit, such that if you pick one of those
apart, it doesn't make sense.

This is also usually a sign of someone using a central VCS model (or
mental model) on that side.

Unless you have no control over who sends you these commits, you may
want to address that also in whatever way possible.

IMO stuff like "git add -a" (and the GUI equivalents) were meant for
your own development, so that you can essentially re-write history in
a sane sequence after having worked on a complex task.

Regards,

Sitaram
