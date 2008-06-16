From: David Kastrup <dak@gnu.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 13:26:34 +0200
Organization: Organization?!?
Message-ID: <85bq21fwnp.fsf@lola.goethe.zz>
References: <20080616110113.GA22945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 13:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8CsJ-0003mr-Vq
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbYFPL0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYFPL0s
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:26:48 -0400
Received: from main.gmane.org ([80.91.229.2]:36734 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbYFPL0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:26:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K8CrD-0007tj-IE
	for git@vger.kernel.org; Mon, 16 Jun 2008 11:26:43 +0000
Received: from dslb-084-061-063-029.pools.arcor-ip.net ([84.61.63.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 11:26:43 +0000
Received: from dak by dslb-084-061-063-029.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 11:26:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-063-029.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:JJEMh25IYUlj3uSyCc+ddNXu24w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85178>

Ingo Molnar <mingo@elte.hu> writes:

>    ( Also, it's a GPL nitpicky issue: the conflict resolution database 
>      can be argued to be part of "source code" and as such it should be 
>      shared with everyone who asks.

I don't think that interpretation holds water.  Not even the version
control history is part of the _corresponding_ source code AFAICT.  If
it were, GPLed software distributions would be a nightmare since you
would have to deliver everything with complete history.

Only very nonstandard usage of version control might make the
_corresponding_ source code be contained in more than HEAD of the
release branch.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
