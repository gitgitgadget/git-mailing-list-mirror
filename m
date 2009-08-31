From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Merging in Subversion 1.5 (was: Re: Using git to track my PhD
	thesis, couple of questions)
Date: Mon, 31 Aug 2009 09:47:14 +0400
Message-ID: <20090831054714.GA6060@dpotapov.dyndns.org>
References: <20090827203402.GC7168@kisimul> <7v1vmxq6nw.fsf@alter.siamese.dyndns.org> <20090827203402.GC7168@kisimul> <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com> <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul> <vpqpragt5bo.fsf@bauges.imag.fr> <4A97E1B1.7090107@gmx.de> <m3ocq0km5m.fsf_-_@localhost.localdomain> <1251661316.25764.4.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 07:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhzpN-00069J-R0
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 07:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbZHaFxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 01:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbZHaFxG
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 01:53:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:32206 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbZHaFxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 01:53:05 -0400
Received: by ey-out-2122.google.com with SMTP id 25so744986eya.19
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=U4VMWKp9u4a8Q2jku9zUuLY83heFdXNgX63x56iRVoo=;
        b=EoMD7Jt5FoLU/lapKTCmTXj4hVm1xdGZS0trR0pWLlBp9eBxoM/ukjXJcnB/iWTDCD
         Dc/qTNviHFPEbBI2kpwOxrHKT/HMQr6S0p5D7LhIEpuqVWZX0vRc4Rvh5OAHkOMNnB8u
         2x5vR6j8zfteAxQ1biSYDOv6eM5Gm5NDkljmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hXfzVCDgbe9x9fsE8zCQOsUdS1Kspol06udcD8vPJd7taBG9HeBRKj3dZ+eVdgkeS3
         ItDAnk2OXlaZJUn2QlE0SVq6ZyaOm8o7LyRgNESdFYvDXA0BZRknNFe0hG/AS8+Gb1Vf
         N13EEUq9iyrFZzgGrCjJSy9fdW1TchQ12Qr24=
Received: by 10.210.141.4 with SMTP id o4mr3869051ebd.40.1251697985951;
        Sun, 30 Aug 2009 22:53:05 -0700 (PDT)
Received: from localhost (ppp85-140-124-105.pppoe.mtu-net.ru [85.140.124.105])
        by mx.google.com with ESMTPS id 10sm363152eyz.31.2009.08.30.22.53.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Aug 2009 22:53:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1251661316.25764.4.camel@maia.lan>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127461>

On Mon, Aug 31, 2009 at 07:41:56AM +1200, Sam Vilain wrote:
> On Fri, 2009-08-28 at 08:12 -0700, Jakub Narebski wrote:
> 
> > Also IIRC there is warning (well, at least there was in Subversion 1.5
> > release notes) that merge tracking doesn't work entirely correctly in
> > the face of criss-cross merges (multiple merge bases) and renaming
> > (although I do hope that they fixed problem with silent corruption if
> > there is rename during merge).
> 
> Not sure about that one.  I also heard - unconfirmed - that things start
> to go awry if you start branching off branches and merging around the
> place.  But if that happens it's likely a bug rather than a design flaw
> (I think).

Some of the initial issues that existed in SVN 1.5.0 have been resolved,
but some others remain. Here is one bug report related to merge:
http://subversion.tigris.org/issues/show_bug.cgi?id=2897
It was reported two years ago, but the problem is still not fixed.
And there is a few others (some of them even older but even with less
prospect of being fixed any time soon):
http://subversion.tigris.org/issues/show_bug.cgi?id=2837
http://subversion.tigris.org/issues/show_bug.cgi?id=2898
http://subversion.tigris.org/issues/show_bug.cgi?id=3056
http://subversion.tigris.org/issues/show_bug.cgi?id=3157

I don't think they would exist for long if they were ease to fix.  Merge
in Subversion is essence automatic cherry-picking, and it is not easy to
implement that in the way it would be reasonably fast and work correctly
in a general case.

Darcs is probably the best when it comes to cherry-picking but clearly
it is not a speed demon. In case of Subversion, the problem is worse,
because it has to make decision on a per file basis rather than operate
each patch as a unit. So, it is even more difficult to implement that
correctly and efficiently.

What you can do relatively simple is to handle a of one directional
merge, and that was the primary design goal of Subversion merge
tracking feature.

Here is what Daniel Berlin wrote about it:
<<<
The initial merge tracking implementation was not meant to handle
repeated bidirectional merging, at least, as designed.

It was designed to allow cherry picks, and mainly for maintaining
feature branches that were mostly one way merges, with the very
occasional merge in the other direction and then branch death :).

For these cases, it works out fine.

For more complex cyclical merge patterns, you really can't use what
we've got. Trying to work around these cases, or build algorithms
that handle them, is just going to lead you into 20 years of edge
cases that made people come up with changeset dags in the first place.
>>>
Source: http://subversion.tigris.org/ds/viewMessage.do?dsForumId=462&dsMessageId=892215

So, I do not think that SVN merge will ever work correctly for those
edge cases.

But even if Subversion learns how to handle all those complex cases
correctly, it will still come with some surprises. One of the main
advantage of the simple 3-way merge is that it is easy to understand
and it makes the right thing most of time. Linus provided a really good
explanation of it here:
http://thread.gmane.org/gmane.comp.version-control.git/60457/focus=60644


Dmitry
