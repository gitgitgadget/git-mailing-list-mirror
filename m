From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 17:25:52 -0500
Message-ID: <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxTrj-0003x3-D5
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbZDXWZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 18:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbZDXWZy
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:25:54 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:64676 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbZDXWZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:25:53 -0400
Received: by qyk16 with SMTP id 16so2704416qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y5rgHQaL1WDsiZWe+BpUaNV+snCxi02zsuc5fPoYae0=;
        b=GdnnN/jp3etnY7klOYpgt5B+pH9Abnt+Q4UT3zr8eGnfEHKmKBXsWyoLBe2Rx95lu4
         xtdVtP2of9zS4jsmFdea9Lo8zDYQYsaLnM841cw3WA7eIvRlSQzp6zknbfkjsM0HaYns
         GhW7kmS7Vu16xIQoqY2q2nxLYlMTsWOWApauE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rl24U+qn3GK6Je5Ej3S7R5L2abZu7+D4MAwpCHl3G2aaloeBM1ZgC1HtRpQsfZRmHo
         +IXRcoXarOxXqtnmSLPH1boLU0DPOrOMs+Mha/oscBD5YpOJpk0evqr9dFMBlS7LMEMo
         fC/XrpaBowjXmeBZeu/gtDMJN1JMsgqX1WkIs=
Received: by 10.224.2.146 with SMTP id 18mr3554038qaj.297.1240611952835; Fri, 
	24 Apr 2009 15:25:52 -0700 (PDT)
In-Reply-To: <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117502>

On Fri, Apr 24, 2009 at 17:18, Michael Witten <mfwitten@gmail.com> wrote:
> In fact, I think masking this kind of thing with a catch-all word
> 'reference' is a bad idea. Rather than being hidden, it should be
> exposed: I think it would be beneficial to use the word 'address'
> rather than 'reference' when talking about the SHA-1 names. Then HEAD
> could be called a pointer variable, etc.
>
> So, a pointer variable's value is an object address that is the
> location of an object in git 'memory'. I think using this approach
> would make things significantly more transparent.

In fact, it's not particularly important that SHA-1 is used to compute
the address into git memory. The only thing that's important is that
the address is determined by content alone (I'm not even sure that
specifying that the address is a cryptographically sound hash of the
content is important; shouldn't that follow from the declaration that
it must be uniquely based on content alone?); the fact that's a SHA-1
is purely an implementation detail, and so it shouldn't appear
prominently in the documentation.

So, what do you say?

Let's start a reformation of the git terminology to use analogies that
have been around since the dawn of computing: 'memory', 'address', and
'pointer'.
