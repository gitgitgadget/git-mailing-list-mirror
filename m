From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Idea for Git Bugtracking Tool
Date: Fri, 07 Mar 2008 15:10:18 -0800 (PST)
Message-ID: <m3zltaf7vs.fsf@localhost.localdomain>
References: <20080306142246.5d9460b7@gmail.com>
	<vpqskz3pqdo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Harning <harningt@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Mar 08 00:11:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXlif-0002d4-8J
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 00:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbYCGXKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 18:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbYCGXKW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 18:10:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:51932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbYCGXKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 18:10:21 -0500
Received: by fg-out-1718.google.com with SMTP id e21so750180fga.17
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 15:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=xeB82IbWm2EyW7fONj/Ksc2sT0/JBJnL2IxWbJD7d9k=;
        b=DKtgex7rID+U+ACC/+RDp+g2ddVjbcLon8wSPYmottakhrhrRWBfIe5fk89vgUJpCpZe6VNLGrsLHX72cLmXGmjVaZMlp5sIQvMXC3Hz7sSj7EkMO4DzEYrZCTMF4QZC3jotSU0khwqgi7ycw9jexf8xKcqpb4DrLoexnM2B5Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=S4JH/n4AWPGVsv8gUlmVckqT/oaOpcFTqnFY+StHZlS7nCy4JTJI2k/8Blo9f+Oi9HlyAr5lIXje2EwVrT8T0zUBQzZaw7IARuoV0oOxGNAFkJBqvld9vngVtop/H6Fqc8O/DNGh+brAw0tHIoXYOQUbKAeOEfntZpK3IhbNyms=
Received: by 10.86.84.5 with SMTP id h5mr2166103fgb.27.1204931419640;
        Fri, 07 Mar 2008 15:10:19 -0800 (PST)
Received: from localhost.localdomain ( [83.8.243.158])
        by mx.google.com with ESMTPS id l12sm4650313fgb.8.2008.03.07.15.10.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 15:10:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27NAIcq006855;
	Sat, 8 Mar 2008 00:10:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27NAGxp006852;
	Sat, 8 Mar 2008 00:10:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <vpqskz3pqdo.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76531>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Thomas Harning <harningt@gmail.com> writes:
> 
>> Any ideas/flaws with this concept?  Anybody up for taking on this
>> project... or for taking this up as a GSOC project mentor?
> 
> Already discussed here:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/48981/
> 
> Pierre Habouzit started working on something called grit, which
> seems to be dead.

Pierre, what happened to git://git.madism.org/grit.git ?


There exists few implementations of distributed bug tracker idea. They
include:

 * Bugs Everywhere (http://bugseverywhere.org), written in Python,
   developed in Bazaar, has Git backend support. Formerly written by
   Panoramic Feedback (note that there is stale version of this tool),
   picked up by one of developers

 * DisTract (http://www.distract.wellquite.org), written in Haskell,
   uses Monotone as backend. Has good reviews on blogs, e.g. by
   Masukomi.

 * DITrack (http://www.ditrack.org), written in Python, currently
   uses Subversion as backend, has plans to be backend-agnostic.
   Inspired by Subissue.

Other links (mainly blogs):
 http://erlangish.blogspot.com/2007/05/distributed-bug-tracking.html
 http://erlangish.blogspot.com/2007/06/distributed-bug-tracking-again.html
 http://weblog.masukomi.org/2008/1/3/distributed-bug-tracking
 http://weblog.masukomi.org/2008/1/20/more-thoughts-on-the-future-of-distributed-bug-tracking
 http://www.geekfire.com/~alex/blog/entries/Ideas-for-a-distributed-bug-tracking-system/Ideas-for-a-distributed-bug-tracking-system.html

-- 
Jakub Narebski
ShadeHawk on #git
Poland
