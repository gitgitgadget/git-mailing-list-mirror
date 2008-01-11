From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 07:25:03 -0800 (PST)
Message-ID: <m3odbsmlkr.fsf@roke.D-201>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
	<alpine.LSU.1.00.0801111348230.31053@racer.site>
	<30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 16:25:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDLlL-0002qY-7u
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 16:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758726AbYAKPZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 10:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757363AbYAKPZK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 10:25:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:29799 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831AbYAKPZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 10:25:08 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1164202fga.17
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=aUzGr2u/eId1mfVyb4xtG3SL4VhkI/Yk3/2imcK9jDY=;
        b=iXoDP2dSdBq8yLYIRjmwS20ruM0ccuYs5Uxtada8iDHeH6/DmaF3faT/h5ZEKx1L4d1nr8/j3sQGX2OjZRIJSYawaXdX3F1JZmcggO+El1b5Rjtpz6k7UabCzRxpHObOQOoS82BQCnn+/YyCPktuXdnNNJjy1Hpa0tcmuq4RcdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=jV3qyrVBFChVqiKQmVxqTOfBvpNSjnFteR//cDj0gVrJZUSa1INeEydZOc6k6hotD2KCaMA9JvmcXkKsBV5HP+XyvfRfxK8v/0CxUbQvmGJB2tUMYeIiwEJjOH8QC1p2/0XYermmkrfl0YSZSDV6BPUBrLRAK2WuDlvXfRTc+7Y=
Received: by 10.86.77.5 with SMTP id z5mr3045999fga.77.1200065105379;
        Fri, 11 Jan 2008 07:25:05 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.244])
        by mx.google.com with ESMTPS id l12sm2498697fgb.9.2008.01.11.07.25.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Jan 2008 07:25:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0BFOsa8012706;
	Fri, 11 Jan 2008 16:24:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0BFOqoF012703;
	Fri, 11 Jan 2008 16:24:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70166>

"Mark Levedahl" <mlevedahl@gmail.com> writes:

> On Jan 11, 2008 8:52 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > IMHO you should optimise the communication by agreeing on one origin,
> > or alternatively not talk about a server at all (which is made easy by the
> > global uniqueness of commit names; just say "my tip is ac9b7192").
> >
> 
> We *cannot* agree on one definition of "origin": there is no single
> server accessible by all, but use of submodules currently *requires*
> that each repo's upstream be given the nickname "origin". With this
> change, I can enforce that each server has a unique nickname and that
> one unique nickname per server is used across the program. Absent
> this, I cannot and end up having to have everyone translate "origin"
> into what it means for them.
> 
> SHA-1's are absolutely unique, but what do you do when "origin" does
> not have  acdc101? I want to know that server-x@joe.com doesn't have
> it, while server-y@mary.org does. This is the frequent problem in
> conversation, and is the reason we have to be able to talk about the
> particular upstream server.
> 
> This change does not eliminate the ability to obscure multiple
> different server names using "origin" for those who think that is the
> best way to do things, it just eliminates the requirement for doing
> so.

Dscho, although I can agree that more flexibility is not always a good
thing, I think that in this situation it is a good thing. I especially
like that git-clone remembers what name it used for upstream repository
(git clone --origin <name>).

Mark, if this change is mainly about the fact that git doesn't allow
to specify default remote to fetch for detached HEAD (and submodules
use detached HEAD), why not provide "branch.HEAD.remote" etc., which
would be used _only_ if we are on detached HEAD (i.e. branch has no
name).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
