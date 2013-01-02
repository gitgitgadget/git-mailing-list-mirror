From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Wed, 2 Jan 2013 11:32:09 -0500
Message-ID: <CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
References: <20130101172645.GA5506@thyrsus.com> <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com> <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com> <20130102153933.GA30813@elie.Belkin> <20130102161848.GA18447@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRMy-0006Ft-6U
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab3ABQkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:40:25 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59602 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3ABQkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:40:24 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so7942562pbb.25
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Vkppphg4trgpSc+BaeE3LbjfHVYC4YlQf5Y87v1ROWw=;
        b=rTdEScafDEuOr8OGRqc+3HyLsLiNFq4LAy2D7UAyzXEYfd8IDn35SUT/EJfg4qVTPb
         qoumzW8aFqz76425G7UUzoLXhmhh6T8+eFeJmX60TOpIuAtx6Wz6hCY177ofqgnUtOCF
         45cg6Q7JY4dR+4cEEzlSngE40L8l921FAQx6vJm9GMuzYODut3nqouVJ2dnt1x8KCBCd
         ITyJP5r/KlYFpyDQi8+ierr5wuMhcZM2PfSmQszPVv28L2BXZ693pxTaJLBvQKPG5jRU
         lKZCTkJdG+wWo7JQ4fCGOlPYd8l9vFiZU2BdhNEPmhSGhBauSWlb85nZHUTkedmhV3TK
         Oxig==
Received: by 10.68.239.232 with SMTP id vv8mr144567186pbc.53.1357144349567;
 Wed, 02 Jan 2013 08:32:29 -0800 (PST)
Received: by 10.66.21.231 with HTTP; Wed, 2 Jan 2013 08:32:09 -0800 (PST)
In-Reply-To: <20130102161848.GA18447@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212522>

First of all, I am at the same time a sad, nostalgic, and very happy
that old cvsimport is getting replaced.

On Wed, Jan 2, 2013 at 11:18 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Two of the three claims in this paragraph are false.  The manual page
> does not tell you what is true, which is that old cvsps will fuck up
> every branch by putting the root point at the wrong place.  And if you
> call silently and randomly damaging imports getting work done, your
> definitions of "work" and "done" are broken.

The existing cvsps/cvsimport combo work for CVS repos with simple
branches, and can track those over time.

Replacement with something more solid is welcome, but until you are
extremely confident of its handling of legacy setups... I would still
provide the old cvsimport, perhaps in contrib.

cheers,



m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
