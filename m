From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Sun, 24 Aug 2008 00:49:17 +0200
Message-ID: <200808240049.19507.jnareb@gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org> <200808231121.41694.jnareb@gmail.com> <20080823165350.GY23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 00:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX1wG-0006c0-BG
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 00:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbYHWWt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbYHWWt2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 18:49:28 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:38355 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYHWWt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 18:49:27 -0400
Received: by ey-out-2122.google.com with SMTP id 6so95613eyi.37
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EpSIBNpKQ2WdWTKXE3T7Q11eR9KnnuYpX5j/AH1QscM=;
        b=tUNHNPMduR0RMNd4hwmMX6uDggT4/6iJs5n5c0gG+OIRcXoi0mO2NQuGrCfLtflxbN
         ERP2lgTTBDGvVVAHNIW5an4ydRBnySrZ6MbW7xMBxRpoCEdfWOMvyANuprF8OF0F4x6Z
         lCXJgIl5mj3+QfTorsMbeLtFrShD8fOT2UpLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bETu2swzNHYYP8PerDEl5iPhqe5Q9ofcDuMApP3TjNfewMz5SjAZPXdYL/PK7lXxuM
         0QZBNUXMLAduFb5+mvlgpu4taelitTK6pf2YZPjsKO0Bsd77yvx3fgjXWrTMrjh2V4NX
         YDB4LIszyGBD14ECtb1gzlkpqq8Y3ApDfZp98=
Received: by 10.210.133.19 with SMTP id g19mr3973201ebd.83.1219531765803;
        Sat, 23 Aug 2008 15:49:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.219.20])
        by mx.google.com with ESMTPS id b33sm2623040ika.2.2008.08.23.15.49.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 15:49:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080823165350.GY23334@one.firstfloor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93500>

Andi Kleen wrote:
> Jakub Narebski wrote:

[By the way, could you try to keep attributions? It helps when writing
 responses to know who wrote which part. TIA]

> > If you are thinking about 'linux-next', it is exception rather than
> > the rule.
> 
> No you're wrong. The majority of Linux trees I have to deal with 
> do it now and then. And I must say I also understand why 
> they want it -- they want a clean history on top of Linus' tree.
> Otherwise there is no chance to find the own changes again
> after a few thousands other merges.

Numbers? I still think that in most cases projects shouldn't rebase
published history; and if they are, they should be educated (as Linus
wrote elsewhere in the thread).
 
> > First, there isn't just _one_ way to deal with non fast-forward 
> > (rebased) branch; there are many possible workflow wrt rebasing.
> 
> I don't doubt there are a million ways to do it somehow in
> all kinds of convoluted ways. And that's exactly the problem.

_Workflows_. Not the way to deal with non fast-forward branches, not
the sequence of commands used, but the workflow, how branches are meant
to be used.

And that's three workflows which use rebase on published branches, not
million.  Perhaps they are a few more that I didn't thought about, but
I don't think that it would be _much_ more.

> The only thing I asked for was that were as a simple standard way that
> is actually documented in the main documentation and the tutorials
> and doesn't require lots of strange commands.
> 
> Not more not less. Right now that's not there as I know
> from my own experience.
> 
> Maybe for you people who spend days thinking about git and
> hacking it these ways are all obvious, but for someone like
> me who just wants to use the tool it's definitely not easy
> to do currently.

There is "simple standard way", although it might be not obvious to
somebody who is only beginner git user.  And the problem is that
for "us people" it is _obvious_, so it is not documented.  Documentation
is usually best done, or at least best started by people who have
freshness enough to know what beginners might stumble on, what people
new to git might have problems with, while having enough information
to actually write good, correct, exhaustive documentation.

And the simple standard way is fetch+checkout (detaching checkout),
at least for linux-next repository/project workflow.

> Anyways I'll shut up on this now because it sounds like
> you people are not interested in improving the tool for 
> non power users. 

Why don't you send patch improving documentation (or command messages)
then, eh?

-- 
Jakub Narebski
Poland
