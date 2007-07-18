From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 08:16:07 +0200
Organization: Organization?!?
Message-ID: <85zm1uxmmw.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <vpqfy3m7dex.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 08:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB2u8-0007bn-9v
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 08:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXGRGUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 02:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXGRGUx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 02:20:53 -0400
Received: from main.gmane.org ([80.91.229.2]:34135 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbXGRGUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 02:20:52 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IB2tG-0006T5-KW
	for git@vger.kernel.org; Wed, 18 Jul 2007 08:20:02 +0200
Received: from dslb-084-061-042-236.pools.arcor-ip.net ([84.61.42.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 08:20:02 +0200
Received: from dak by dslb-084-061-042-236.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 08:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-042-236.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:jrrjI1ma7TQuXndJl5n8Fw9h0I0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52831>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> or has somebody a better idea or interface or rationale?  I understand
>> that there are use cases where one does not bother about empty
>> directories, but for a _content_ tracker, not tracking directories
>> because they are empty seems quite serious.
>
> ,----[ http://www.spinics.net/lists/git/msg30730.html ]
> | From: Linus Torvalds <torvalds@xxxxxxxxxxxxxxxxxxxx>
> | 
> | I wouldn't personally mind if somebody taught git to just track empty
> | directories too.
> | 
> | There is no fundamental git database reason not to allow them:
> | it's in fact quite easy to create an empty tree object.
> | The problems with empty directories are in the *index*, and they
> | shouldn't be insurmountable.

Stop right here: does that mean that I can script some "put empty
directories into the last commit manually" procedure bypassing the
index?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
