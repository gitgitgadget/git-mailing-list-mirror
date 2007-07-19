From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 19:47:02 +0200
Message-ID: <867iow2smh.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site> <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com> <Pine.LNX.4.64.0707191642270.14781@racer.site> <6C96EBA9-CDCE-40EA-B0EC-F9195DBE83DB@silverinsanity.com> <Pine.LNX.4.64.0707191715000.14781@racer.site> <CC669745-4434-478E-9A24-E474071578C6@silverinsanity.com> <Pine.LNX.4.64.070719
 1829530.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 19:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBa63-0005lJ-Bo
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 19:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765607AbXGSRrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 13:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbXGSRrV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 13:47:21 -0400
Received: from main.gmane.org ([80.91.229.2]:57069 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S940407AbXGSRrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 13:47:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBa5q-0005Pz-Fp
	for git@vger.kernel.org; Thu, 19 Jul 2007 19:47:14 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 19:47:14 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 19:47:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:5j3XLR9CwgU/jE5+n8EuUyQXH1c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53012>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 19 Jul 2007, Brian Gernhardt wrote:
>
>> On Jul 19, 2007, at 12:17 PM, Johannes Schindelin wrote:
>> 
>> > Alas, we already have such a marker.  It is called ".gitignore", and has
>> > been ignored by _you_.  There is _nothing_ wrong, from a technical
>> > standpoint, to call this marker ".gitignore", and it is _also_ not wrong
>> > to put this marker into the file system _in addition_ to the index.
>> > 
>> > So go and add your directories via that marker, and _be done with it_.
>> 
>> But this alters the content of the directory away from what I want it to be,
>> namely empty.  You aren't addressing the concept of tracking an empty
>> directory, you're just saying you won't do it.
>
> OMG last time I checked, my _empty_ directory contained "." and "..".  
> What do I do now?

If you have a suitable Solaris system, you could try

sudo unlink .
sudo unlink ..

and have a chance that this will work until the next file system
check.

I don't think that adding tracking of ".." would be easy to implement
in git, but I seem to remember that somebody recently proposed a plan
of at least tracking "." which would seem better than nothing and
possibly more useful than "sudo unlink .".

All the best,

-- 
David Kastrup
