From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: [PATCH] filter-branch: add --prune-empty to option summary
Date: Fri, 2 Oct 2009 10:18:03 -0400
Message-ID: <c376da900910020718i3ddc1dd1x5eb966a693b477e2@mail.gmail.com>
References: <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
	 <1254444731-6852-1-git-send-email-adambrewster@gmail.com>
	 <20091002074537.GA27664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 16:18:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtixX-0007sN-DD
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 16:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZJBOSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 10:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbZJBOSA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 10:18:00 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:54683 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZJBOSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 10:18:00 -0400
Received: by bwz6 with SMTP id 6so1027442bwz.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=f3CGfP7+lNGckL9huT63Cx0ALDqh6bc+pRNjBHWiSQE=;
        b=f1VEXHVYI87CBDzk5F+c748mkkl4HvIeBEecT9RwxNcQ2AmQQwSnS/NP2iuokGVIb2
         stQ6u60TBpQ7gXpy6MNVVjqHp7YzphlqzWCSPtQF8wkKdx24/ngfhCo2tJfD/J/VgJRi
         ivpGq0oBGgVi17q81FoElhqUOFFQwjD4/Wjsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GmCXygnuO+WUTKRe3eZs8qakgKz2nsCxH66KXvHi35uPec9ABz1pLGi2M4sfAGcA0w
         F+TNClYk0u1+rRT8UhNoXMs7EYTAInppZLmR680weUz1+Y7vnmzlEWjd1vvzBe3mkhnK
         wibiZEtJLPlPtvJmWiWFR2QA5uTMZPiccsOzQ=
Received: by 10.204.155.67 with SMTP id r3mr1137418bkw.94.1254493083154; Fri, 
	02 Oct 2009 07:18:03 -0700 (PDT)
In-Reply-To: <20091002074537.GA27664@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129442>

>
> Thanks. This makes sense given the existing structure, though I have to
> wonder how useful some of these gigantic synopses really are.

I find them useful mostly when dealing with commands that I generally
know, but don't remember the exact spelling or ordering of the
options.  I might forget, for example, if it's --msg-filter or
--message-filter.

Adam
