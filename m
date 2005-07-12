From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Why is there no git-update-cache --modified (aka I give up)
Date: Tue, 12 Jul 2005 18:16:51 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.12.16.16.45.990714@smurf.noris.de>
References: <20050712055218.GA18192@buici.com> <7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net> <20050712155316.GA5841@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jul 12 18:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsNXc-0005ts-Tq
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 18:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVGLQUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGLQSg
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 12:18:36 -0400
Received: from main.gmane.org ([80.91.229.2]:37813 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261570AbVGLQR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 12:17:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsNRk-0004yg-9c
	for git@vger.kernel.org; Tue, 12 Jul 2005 18:17:24 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 18:17:24 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 18:17:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Marc Singer wrote:

>   # git-update-cache `git-diff-cache | cut -f2`

g-d-c should have an option to print file names only. All that cutting
and argument-backtick-ing gets pretty nasty when there are a lot of files,
or if they contain special characters.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
God is a perfect example of the kind of aberration that can result from
an untrained intellect combining with an unrestrained imagination.
		-- Simon Ewins
