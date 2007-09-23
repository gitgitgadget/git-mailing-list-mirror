From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 17:15:40 +0200
Message-ID: <e5bfff550709230815r773a4ad2u47bf854cacc236b6@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F55E03.2040404@krose.org>
	 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	 <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	 <20070923104525.GC7118@artemis.corp>
	 <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	 <85zlzdo3ch.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 17:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZTBU-0007yS-76
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 17:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbXIWPPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 11:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbXIWPPm
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 11:15:42 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:16408 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbXIWPPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 11:15:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1702428wah
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NY4a2APAzqppCRDptWkUYTLU+GJ837zdfM2Oz3v2u5Q=;
        b=m0bkY5UEFiSQ25TNo/Qd+shvBMRm06ztDgPlo4dcXst8YzYWZT9S71by4fPvdtFHAN6Ikf4lEHJktfcJ41TyBIuxYFOT0dDIlUVmWGcEPZn6zXyOmKmRvpspLajBYg2CGwzPPHhKgPVwfqQCgya9zl7EYy2oqrgR7c8aI/I+xUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kKRikv8mkWpi9/k23J1SRvBAcWLTOeM1R7UUsPqv6zmsDxTckk3S5recUzA5O53FlGjYjsfkWk8+YbePnmXnnb/pJthtozt39dMX+BLAGLdU1jQKBhHQpDmUXWWClPseaDV4GHH8Yx95fEYPPEiEOA7DzUwO0+r1bYg+/zS13hM=
Received: by 10.115.108.1 with SMTP id k1mr2329347wam.1190560540823;
        Sun, 23 Sep 2007 08:15:40 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 23 Sep 2007 08:15:40 -0700 (PDT)
In-Reply-To: <85zlzdo3ch.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58968>

On 9/23/07, David Kastrup <dak@gnu.org> wrote:
> >
> > Perhaps I have misunderstood, but the idea I got is that for Linus
> > OO brings in more problems than what it tries to fix.
>
> I read that as OO bringing in more programmers capable of creating
> problems than those capable of fixing them.
>
> It is not the fault of OO in itself, but it is the bottom line that
> counts: if it draws the wrong audience for the wrong reasons, it
> better had great benefits to offset that.

Perhaps I'm wrong, but I think one of the advantages of big projects
written in C vs comparable size projects in an OO  language (read C++)
it's exactly the opposite.

Because C lets a random developer to understand, quickly enough, and
do little local modifications also to big projects like Linux, it
attracts a lot of developers that have the possibility to start with
some janitorial work or some little patch without incurring in the
very steep learning curve you have understanding the object hierarchy
of a big C++ code base, an almost mandatory step, before to start
hacking as example in Firefox.

This is, IMHO, a big advantage: fresh meat is always welcomed, the
damage it can potentially create is more then compensated by the long
term benefit of a large and live developer community.


Marco
