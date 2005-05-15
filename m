From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: README rewrite
Date: Sun, 15 May 2005 19:33:34 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.15.17.33.33.721750@smurf.noris.de>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com> <42876B30.1070404@saville.com> <20050515154041.GD7391@tumblerings.org> <20050515155315.GE7391@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun May 15 19:34:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXN0e-0004wt-MR
	for gcvg-git@gmane.org; Sun, 15 May 2005 19:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVEORet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVEORet
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 13:34:49 -0400
Received: from main.gmane.org ([80.91.229.2]:23455 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261166AbVEOReo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 13:34:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DXN0K-0004v6-Hq
	for git@vger.kernel.org; Sun, 15 May 2005 19:34:16 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 May 2005 19:34:16 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 May 2005 19:34:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Zack Brown wrote:

> Clearly 'branches' are diverging branches of development. But if I have my
> own tree, with several branches in it, it's unclear to me how to specify
> which branch I'm actually working on at any given moment.
> 
Branches == multiple source directories. You work on the branch whose
directory you're in. This is why there's no cg-branch-switch command.

cg-branch-add doesn't actually add or create a branch. It just tells
cogito your name for one other branch, plus its location so that you may
pull the branch's data from there.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


