From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 09:35:59 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.07.35.56.960375@smurf.noris.de>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net> <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Sep 19 09:39:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHGF1-00031x-UV
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 09:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVISHjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 03:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVISHjE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 03:39:04 -0400
Received: from main.gmane.org ([80.91.229.2]:31455 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932360AbVISHjC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 03:39:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHGDd-0002oV-4a
	for git@vger.kernel.org; Mon, 19 Sep 2005 09:37:41 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 09:37:41 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 09:37:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8843>

Hi, Junio C Hamano wrote:

> * Perhaps a tool to revert a single file to pre-modification
>   state?  git-cat-file blob `git-ls-files | grep foo` >foo or
>   git-cat-file blob `git-ls-tree HEAD foo` >foo?  What should
>   the command be called?  git-revert is taken so is
>   git-checkout.

git-checkout can be extended to accept filenames, which would have the
additional benefit of enabling me to get any revision, not just HEAD.

So can git-reset.

I agree with Anton's "git clean"; with an optional -r <commit>
argument, that would be a better solution.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BOFH excuse #396:

Mail server hit by UniSpammer.
