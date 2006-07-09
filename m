From: Nix <nix@esperi.org.uk>
Subject: Re: What *have* I done?
Date: Sun, 09 Jul 2006 23:25:21 +0100
Message-ID: <87hd1ql8ku.fsf@hades.wkstn.nix>
References: <87u05ru30p.fsf@hades.wkstn.nix>
	<20060709212113.GS29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:25:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzhiW-0004yI-Fr
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWGIWZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWGIWZ3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:25:29 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:47884 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1161197AbWGIWZ2
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:25:28 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id k69MPMQK001797;
	Sun, 9 Jul 2006 23:25:22 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id k69MPLh2005073;
	Sun, 9 Jul 2006 23:25:21 +0100
To: Petr Baudis <pasky@suse.cz>
X-Emacs: the Swiss Army of Editors.
In-Reply-To: <20060709212113.GS29115@pasky.or.cz> (Petr Baudis's message of "Sun, 9 Jul 2006 23:21:13 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23574>

On Sun, 9 Jul 2006, Petr Baudis yowled:
>   Hi,
> 
> Dear diary, on Sun, Jul 09, 2006 at 12:48:22AM CEST, I got a letter
> where Nix <nix@esperi.org.uk> said that...
>> loki 593 /usr/packages/linux/linux% cg-diff | diffstat
> 
>   Note that cg-diff -s might be useful.

Indeed :)

>> loki 594 /usr/packages/linux/linux% cg-reset
>> loki 595 /usr/packages/linux/linux% cg-diff
>> loki 596 /usr/packages/linux/linux%
> 
>   ...but when you switch away and switch back, the uncommitted changes
> appear again?

Yes.

>   Just in case, don't the tree happen to simply stay the same as in the
> branch you switched from? (Try cg-diff -r yourpreviousbranch.)

Yes. Also, that branch (which was forked recently from the misbehaving
one) claims that all changes are merged from that branch, but this is
demonstrably untrue.

>   And most importantly, does this also happen with just stock 0.17.3
> cg-switch? With stock master cg-switch? (If both is no, you probably
> forgot to cherrypick some associated cg-switch bugfix or something.)

This is 0.17.3 cg-switch plus the seek speedup 40f8a28806a1c5a7cb1f7d137f1bb271b71f890f.
(I doubt that's to blame, but I've been wrong before.)

I think the oddity is related to git-cherry-pick somehow, but I'm
not sure how: I took the original upstream pack again, rebuilt the
branches from scratch and now I can't make the problem happen anymore.

If it happens again I'll keep the tree around and collect more data.
(I'll have to dig some more disk space up...)

-- 
`She *is*, however, one of the few sf authors with a last name ending in O,
 which adds some extra appeal to those of us who obsess about things like
 having a book review of an author for each letter in the alphabet.' -- rra
