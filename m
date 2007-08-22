From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 00:25:05 +0200
Message-ID: <85ir77ky0u.fsf@lola.goethe.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	<46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	<Pine.LNX.4.64.0708221713540.20400@racer.site>
	<86mywjcwv7.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
	<86absjcqfq.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 00:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INydu-0007lQ-EJ
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 00:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764024AbXHVWZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763957AbXHVWZR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 18:25:17 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:58403 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764291AbXHVWZO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 18:25:14 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 9008B15BDB6;
	Thu, 23 Aug 2007 00:25:10 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 7E6B323D2E4;
	Thu, 23 Aug 2007 00:25:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-060-116.pools.arcor-ip.net [84.61.60.116])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 456FA3425E4;
	Thu, 23 Aug 2007 00:25:10 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DED611C36605; Thu, 23 Aug 2007 00:25:06 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 22 Aug 2007 12\:58\:48 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56430>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 22 Aug 2007, David Kastrup wrote:
> In contrast, a lot of _scripting_ languages are basically
> write-only. They may be write-only because that's their fundamental
> design (perl), or they may be write-only because they are limited
> enough that you can not easily extend them to do new things.
>
> But your statement is provably wrong. Just *look* at well-maintained
> projects that have extended way past their original design and usage
> model. A lot of them are in C.

You mean like Emacs which is mostly scripted in Elisp?  Or the Gimp
which is mainly scripted using script-fu?  Or like TeX which is (to
the surprise of Donald Knuth) usually extended in TeX macros rather
than using Pascal?  Or HTML servers and content management systems,
done in a variety of scripting languages from PHP, Ajax, Plone,
whatever?  Or Mickysoft applications extended in Visual Basic?  Or
Autocad extended in Autolisp or what it is called?  Or autoconf or
sendmail extended in m4 (avaunt!)?

Pretty much _any_ complex extensible system nowadays comes with a
scripting/pattern/macro language of choice, and this language is, for
a variety of reasons, rarely C.

The question is not whether large complex systems are generally
managed in C, since that quite obviously is _not_ the rule.  The
question is rather whether the environment in which one assembles git
plumbing into porcelain should be treated as a large complex system in
itself.  That certainly is a valid question.  If one manages to get
past name-calling, one might answer this in one of several ways.

> So why do you make these idiotic arguments that are clearly crap?

Oooooh, I get the reference.  So _that's_ where the name comes from.

    Q:   WHAT DO YOU WANT?
    M:   Well, I was told outside that...
    Q:   Don't give me that, you snotty-faced heap of parrot
         droppings!
    M:   What?
    Q:   Shut your festering gob, you tit! Your type really makes me
         puke, you vacuous, coffee-nosed, maloderous, pervert!!!
    M:   Look, I CAME HERE FOR AN ARGUMENT, I'm not going to just
         stand...!! 
    Q:   OH, oh I'm sorry, but this is abuse.
    M:   Oh, I see, well, that explains it.
    Q:   Ah yes, you want room 12A, Just along the corridor.
    M:   Oh, Thank you very much. Sorry.
    Q:   Not at all.
    M:   Thank You.
    (Under his breath) Stupid git!!

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
