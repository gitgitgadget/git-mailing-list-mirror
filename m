From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: filter-branch: Remove original/*
Date: Mon, 16 Feb 2009 01:19:16 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngphfok.hul.sitaramc@sitaramc.homelinux.net>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
 <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de>
 <7vvdrblcl0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de>
 <7vvdrbie7k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 02:21:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYsAL-0008Ow-NP
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 02:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZBPBTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbZBPBTa
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 20:19:30 -0500
Received: from main.gmane.org ([80.91.229.2]:52733 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749AbZBPBT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 20:19:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYs8r-0005GF-Uq
	for git@vger.kernel.org; Mon, 16 Feb 2009 01:19:25 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 01:19:25 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 01:19:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110107>

On 2009-02-15, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> Why?  Most tags will be created once and will stay there.  That is how 
>>> tags are supposed to behave, isn't it?
>>
>> Exactly my point.  In the common case, it does not change a thing.
>
> Wrong.
>
> In the common case, you will create tons of useless files that waste a
> disk block to store 180-byte or so perr each tag.

Instead of a separate file for each tag, why not something
like logs/TAGS, which just records tag creations.

The downside is it wouldn't represent a *continuous state*
of anything in particular, because you can create tags for
any commit while on any (other) branch.  I'm not smart
enough to figure out the implications of that across the
entire system.
