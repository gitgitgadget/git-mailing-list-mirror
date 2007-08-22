From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 12:58:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
 <86absjcqfq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INwMn-0004kl-G1
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbXHVT7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXHVT7j
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:59:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49290 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932408AbXHVT7i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 15:59:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MJwsD4031063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 12:58:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MJwm4Z001400;
	Wed, 22 Aug 2007 12:58:49 -0700
In-Reply-To: <86absjcqfq.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-4.748 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56414>



On Wed, 22 Aug 2007, David Kastrup wrote:
> 
> Actually, the same holds for assembly language vs C.  Once the
> prototyping is over...

No. Portability.

The point is, C is *more* portable (and thus maintainable) than shell, but 
assembly language is *less* portable than C.

So no, "the same holds" is not at all true.

It's not about whether something is evolving or not: it's about whether 
something is *maintainable* or not.

And C is most definitely maintainable, in ways that scripting languages 
often are *not*.

> > Having tried to do internal scripting languages, I can say that it's
> > just easier to do it in C once you get past the hump of getting it
> > written in C in the first place.
> 
> But it is not "once" that you need to do this.  It is a permanent job.

Sure, and that's exactly where C shines.

C is not great for "quick and dirty, and I'm not sure where this is 
going".

But once you know where it's going, and once it's not "quick and dirty" 
any more, very little beats C. It's easy to extend on, and if all the 
infrastructure is in C, there simply IS NO BETTER WAY TO GLUE THINGS 
TOGETHER.

There are "C bindings" for other languages (like LUA), but the fact is, 
none of them hold a candle to the "C bindings" of native C.

So you're seemingly ignoring the fact that all the infrastructure is in C 
(and absolutely _needs_ to be in C - there are no valid alternative 
languages at that level).

> Maintenance: yes.  Development: no.  If you want a product you do not
> want to touch again, C is a good final choice.

That's simply not true.

Look around. Most C language projects are really well maintained.

In contrast, a lot of _scripting_ languages are basically write-only. They 
may be write-only because that's their fundamental design (perl), or they 
may be write-only because they are limited enough that you can not easily 
extend them to do new things.

But your statement is provably wrong. Just *look* at well-maintained 
projects that have extended way past their original design and usage 
model. A lot of them are in C.

So why do you make these idiotic arguments that are clearly crap?

			Linus
