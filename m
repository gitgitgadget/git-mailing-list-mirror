From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Thu, 06 Sep 2007 18:33:01 +0200
Organization: Organization?!?
Message-ID: <85bqcfbvpe.fsf@lola.goethe.zz>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com> <46DBB2BE.8030505@eudaptics.com>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?20070903112110.G?= =?ISO-8859-1?Q?E148=0453@genesis.?=
	=?ISO-8859-1?Q?frugalware.org>?= <86y7fohtmw.fsf@lola.quinscape.zz> <20070905160206.GY14853@genesis.frugalware.org> <85abs1hr6t.fsf@lola.goethe.zz> <20070906162657.GF2329@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 18:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKIF-0004A9-9u
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbXIFQdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbXIFQdS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:33:18 -0400
Received: from main.gmane.org ([80.91.229.2]:46302 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbXIFQdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:33:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITKI0-0000uB-My
	for git@vger.kernel.org; Thu, 06 Sep 2007 18:33:08 +0200
Received: from dslb-084-061-055-071.pools.arcor-ip.net ([84.61.55.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 18:33:08 +0200
Received: from dak by dslb-084-061-055-071.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 18:33:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-055-071.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:xTQxXRhq81ImzzaqSy2rx2rkEa4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57901>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Wed, Sep 05, 2007 at 09:01:46PM +0200, David Kastrup <dak@gnu.org> wrote:
>> > the situation what triggers the 'no such file' problem is:
>> >
>> > ----
>> > $ touch foo/Makefile
>> > $ mkdir bar
>> > $ ln -s foo/Makefile bar
>> > $ cd bar
>> > $ cat Makefile
>> > cat: Makefile: No such file or directory
>> > ----
>> 
>> This is under Vista?  It would be the same under Unix.
>
> no, i never stated that this is Vista ;-) this is Linux.

Ok, so now we have established that we have not actually established
anything with regard to relative links under Vista short of what
Microsoft claims in its developer information (which has its fair
share of misleading and wrong information).

If anybody is as fortunate as to actually have Vista available, it
would be nice if he corroborated that relative links under Vista are
indeed (as Microsoft appears to claim) relative with regard to the
current work directory rather than the directory containing the link.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
