From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] builtin/checkout: Fix message when switching to an
 existing branch
Date: Fri, 20 Aug 2010 23:19:50 +0530
Message-ID: <20100820174946.GA6211@kytes>
References: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
 <AANLkTine1mi0AiCL+ezwNpFs4_y_szSwJd+Enux5G26Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 19:51:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmVks-0006EF-UB
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0HTRvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 13:51:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37168 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0HTRvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 13:51:44 -0400
Received: by pvg2 with SMTP id 2so1298319pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AGJPpOZboaR0bJ63sRbUlEps+//ZxgoKue7HX7nX984=;
        b=gFZnxwLOTBqpycmeBa3gFrUFGu5JUs0uQJK7n7IiJEgMVrOrAi7ceE8Br+olXPFqJy
         78BF8DwDlaLhM4z8/Hg9hsrYs7tsZji1olWQpV6vzERDEFYbbqx9w+ebSAz25pwiwZlf
         0SWA2FrRKgx6fU3fGHnsjgUbGPnq4KQzemEc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ObWclYM4+o9CMKgHkNeTnPARmVL6NuXzgpRRQp0nPVXiXxYMByxWI6R1gfJbGAbR0m
         V9H+2c8ezgUSRo523w38PURRs1tTGO03kKEPvlJGeklmgkm+mCg9+UxlPMfddXRXMUEi
         A2rCzU9SQgT+6Zx9KgFRJTAgWTlrKCfRkqOMM=
Received: by 10.142.201.6 with SMTP id y6mr1360069wff.78.1282326704261;
        Fri, 20 Aug 2010 10:51:44 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n2sm3526991wfl.1.2010.08.20.10.51.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 10:51:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTine1mi0AiCL+ezwNpFs4_y_szSwJd+Enux5G26Y@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154063>

Hi Tay,

Tay Ray Chuan writes:
> On Sat, Aug 21, 2010 at 1:41 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
> > Fix "Switched to a new branch <name>" to read "Switched to branch
> > <name>" when <name> corresponds to an existing branch. This bug was
> > introduced in 02ac983 while introducing the `-B` switch.
> >
> > Cc: Tay Ray Chuan <rctay89@gmail.com>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> Please see
> 
>   <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>

Ah yes. It looks like I missed this earlier. Sorry for the noise.

-- Ram
