From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Fri, 15 Aug 2008 22:36:54 +0200
Message-ID: <200808152236.56479.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200808140457.56464.jnareb@gmail.com> <48A5DB4D.5060906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 22:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU63k-00034B-Ev
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 22:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbYHOUhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761569AbYHOUhD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 16:37:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18075 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761493AbYHOUhB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 16:37:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so746421nfc.21
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4qddXM0jIHuqntnW9l05SOE26s8zA1/gls7kKJhb97o=;
        b=WkpyMVmOSwZc/nuU9GBDQJNnMvoZCqVQ/6vbxjA5/ykOW7/7D8uhC09B2xPeHWYrzN
         Voo6NRcGjCv9uc6uxyhrnL27dGj1UKEK/OqKZaEBIbe0OoM4IQBlzFXor2denrIEVNs3
         I/FyyGsnXv94I3701YB6fHwlioSONVrRjmoGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ocSoM/awfavyhYOXBzBR7yLLU50j3SYJUpNIX5qP2P+yhgPiyS6/MqINdkwA5HNB67
         /9MyygrgDv7sOjb8e3O8IGOkqmdPd2cvGWuzWHHsfHQXrTgOJ7GLupM/VesLZ/pFJyna
         KEKanoxY0O7no70CPD/mdyZ9aX3HaFzQlRDVU=
Received: by 10.210.16.11 with SMTP id 11mr193118ebp.137.1218832619609;
        Fri, 15 Aug 2008 13:36:59 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.253.165])
        by mx.google.com with ESMTPS id z40sm1072805ikz.7.2008.08.15.13.36.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 13:36:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48A5DB4D.5060906@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92517>

On Fri, 15 August 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
> > 3. Gitweb caching
> > 
> > Student: Lea Wiemann
> > Mentor: John 'warthog' Hawley
> > 
> > There are new tests for gitweb (to check if caching would not break 
> > anything new: it did caught a few breakages), new object Perl API to 
> > git, and gitweb caching implemented using caching data at the level 
> > slightly above calling git commands.  But full code (tests, Perl API 
> > and changes to gitweb) are only after first, maybe second round of 
> > review.
> 
> Correct.  I'm planning to post the next round of patches tonight or
> tomorrow. [...]

Please remember that according to timeline in GSoC 2008 FAQ:
  http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
August 18: ~12 noon PDT / 19:00 UTC is "Firm 'pencils down' date."
(suggested pencils down date was August 11).  So you don't have much
time, and you don't leave much time for review, so I guess evaluation
would be "done, but nor merged in" or something like that.

> 2. I'll run benchmarks under various conditions, to measure how much
> performance we gain with caching, and under what conditions it is most
> beneficial.

And to compare with plain, vanilla gitweb, with kernel.org fork (both
performance and disk space used I guess) and repo.or.cz fork (only caches
projects list view, IIRC), I guess.

Benchmarking gitweb caching could be difficult, as you would have somehow
(fio?) replay conditions of I/O pressure as on kernel.org and repo.or.cz,
as from anegdotical evidence gitweb is IO bound, not CPU bound (so
ordinary speed benchmarks could give wrong results).

> > Student retention: unknown.
> 
> Well, on the downside, I'm expecting to be pretty busy with college, so
> there won't be much time to do substantial work on git or gitweb.  On
> the upside, I feel perfectly comfortable with contributing to git (i.e.,
> maintaining my own patch queue, sending patches, etc.), so it's very
> much possible that at some point I'll be hacking git or gitweb again.

It would be nice, even if you would be a "weekend contributor".

But I guess that making you into gitweb maintainer, or git.kernel.org
admin is out of the question... ;-)

-- 
Jakub Narebski
Poland
