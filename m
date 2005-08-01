From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Mon, 01 Aug 2005 09:59:52 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.01.07.59.50.252244@smurf.noris.de>
References: <11227978451100@foobar.com> <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net> <20050731235242.GH32263@mythryan2.michonline.com> <7vk6j6a3rh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Aug 01 10:13:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzVQ9-000730-IO
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 10:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVHAIMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 04:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVHAIMr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 04:12:47 -0400
Received: from main.gmane.org ([80.91.229.2]:8374 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262003AbVHAILl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 04:11:41 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DzVNk-0006ov-D9
	for git@vger.kernel.org; Mon, 01 Aug 2005 10:10:44 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 10:10:44 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Aug 2005 10:10:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio C Hamano wrote:

> Also, I wonder if running lc() to downcase the local-part[*] is
> safe/allowed/correct

mostly/no/no.

It's unlikely to be a real-life problem, but we still shouldn't do it.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Amusements to virtue are like breezes of air to the flame -- gentle ones will
fan it, but strong ones will put it out.
					-- David Thomas
