From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 01:39:12 +0200
Message-ID: <85wsvnjg0v.fsf@lola.goethe.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	<46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	<Pine.LNX.4.64.0708221713540.20400@racer.site>
	<86mywjcwv7.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
	<86absjcqfq.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org>
	<85ir77ky0u.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708221607590.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 01:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INznI-00049X-Ed
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 01:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXHVXjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 19:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764127AbXHVXjV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 19:39:21 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:47547 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763575AbXHVXjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 19:39:20 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id E4A1A183E80;
	Thu, 23 Aug 2007 01:39:18 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id B67BF12DFF3;
	Thu, 23 Aug 2007 01:39:18 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-060-116.pools.arcor-ip.net [84.61.60.116])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 92BFB8C463;
	Thu, 23 Aug 2007 01:39:14 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2002C1C36605; Thu, 23 Aug 2007 01:39:12 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708221607590.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 22 Aug 2007 16\:10\:30 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56436>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 23 Aug 2007, David Kastrup wrote:
>> >
>> > But your statement is provably wrong. Just *look* at well-maintained
>> > projects that have extended way past their original design and usage
>> > model. A lot of them are in C.
>> 
>> You mean like Emacs which is mostly scripted in Elisp?  Or the Gimp
>> which is mainly scripted using script-fu?
>
> No. I mean standard C code projects. Like the kernel. Like a huge
> class of other projects that are C. Not scripts.

By golly, you are right.  Pretty much all projects that are defined by
not including a script language don't include a script language.

> Big, huge, projects are all done in C, and they are well-maintained.

Ok, so Emacs is a small project.  And Plone is a small project.  And
Ajax is a small project.  And LaTeX is a small project.  And autoconf
is a small project.  And gcc is a small project (we can't have RTL in
a big, huge, project, after all).  And the Linux kernel doesn't
include Makefiles or any other stuff that would be scripted in
anything but C.

> Scripting is not the rule at all. And it is silly to say that
> regular all-C projects need to have scripting.

Actually, if they are defined as all-C, they _can't_ have scripting
by definition.

I am not really interested in continuing this.  I don't think that
there is much I can do to make my point clearer than I did, so any
further amount of "does not" -- "does too" will not make anybody
including ourselves change his mind.

All the best,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
