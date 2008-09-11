From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 01:36:34 +0200
Message-ID: <20080911233634.GE29559@cuci.nl>
References: <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu> <20080911214650.GB3187@coredump.intra.peff.net> <alpine.LFD.1.10.0809111533110.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Theodore Tso <tytso@MIT.EDU>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdvjb-0000m7-MR
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYIKXgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbYIKXgg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:36:36 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44518 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbYIKXgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:36:35 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BB5775465; Fri, 12 Sep 2008 01:36:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111533110.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95669>

Linus Torvalds wrote:
>I have asked several times what it is that makes it so important that the 
>"origin" information be in the headers. Nobody has been able to explain 
>why it's so different from just doing it in the free-form part. NOBODY.

That's because the difference is small:
In the header is slightly faster and more elegant (both designwise and
displaywise), that's it.
Other than that, it hardly matters.

>The only thing I have ever argued against is adding commit headers that 
>have no sane semantics and don't make sense as internal git data 
>structures.

Of course.

In any case, I think I got enough feedback from the list to create
a working implementation/concept which is going to use the free-form
trailer to implement the origin field.
-- 
Sincerely,
           Stephen R. van den Berg.
