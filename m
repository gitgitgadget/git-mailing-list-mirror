From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: GIT character codecs
Date: Mon, 14 Nov 2005 05:47:28 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.14.04.47.25.899163@smurf.noris.de>
References: <20051113081443.38296.qmail@web26309.mail.ukl.yahoo.com> <7v3bm0c0gf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Nov 14 05:53:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbWJh-0007rM-AL
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 05:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVKNEvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 23:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVKNEvZ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 23:51:25 -0500
Received: from main.gmane.org ([80.91.229.2]:29338 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750911AbVKNEvY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 23:51:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbWHF-0005Vh-OW
	for git@vger.kernel.org; Mon, 14 Nov 2005 05:49:10 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 05:49:09 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 05:49:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11766>

Hi, Junio C Hamano wrote:

> I suspect you could just take the default from LANG and LC_CTYPE
> to cover 98% of the cases, and to cover the rest 2% the
> problematic cases have a per-window override menu.

Or, if you want to be super-flexible, just try to decode as UTF-8.
Success? fine -- otherwise use whatever your application's default is
set to, or your local encoding (which may of course also be UTF-8), or
fall back to 8859-15.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Difficult:
	Disciplines like physics, math, engineering, which is why I don't
	want to do them.
		-- Fashionable Dictionary (www.butterfliesandwheels.com)
