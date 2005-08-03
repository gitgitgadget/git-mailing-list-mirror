From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Wed, 03 Aug 2005 09:32:15 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.03.07.32.15.169731@smurf.noris.de>
References: <11227978451100@foobar.com> <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net> <20050803013042.GF5762@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Aug 03 09:35:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0DlQ-0001Ks-0Z
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 09:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVHCHd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 03:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVHCHd6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 03:33:58 -0400
Received: from main.gmane.org ([80.91.229.2]:30651 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262109AbVHCHd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 03:33:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E0Dk1-000199-FN
	for git@vger.kernel.org; Wed, 03 Aug 2005 09:32:41 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Aug 2005 09:32:41 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Aug 2005 09:32:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Ryan Anderson wrote:

> Since these emails are sent *very* fast, delivery order tends to be the
> dominating factor in how they sort in your inbox, as they will all have
> the same time.  So that's a trifle annoying.

That's trivially fixable: just generate your own Date: header and
add a second for each email.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Be careful whilst playing under the anvil tree.
