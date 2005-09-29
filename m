From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Use of the -f flag on checkout
Date: Thu, 29 Sep 2005 09:09:52 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.29.07.09.51.516956@smurf.noris.de>
References: <433B84BD.8030003@pobox.com> <7vbr2cmle2.fsf@assigned-by-dhcp.cox.net> <200509290754.30017.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 29 09:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKsaG-00085x-52
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 09:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVI2HL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 03:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVI2HL5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 03:11:57 -0400
Received: from main.gmane.org ([80.91.229.2]:17542 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932107AbVI2HL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 03:11:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EKsZb-0007zz-FM
	for git@vger.kernel.org; Thu, 29 Sep 2005 09:11:19 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 09:11:19 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 09:11:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9472>

Hi, Alan Chandler wrote:

> What is the risk in not using it (ie what are the cases when you should
> use it)?

The risk of using it is that you kill your local changes, even if you want
to keep them. They're *gone*.

The risk of not using it is that you check local changes into a branch
where they don't belong.

=> IMHO, "checkout -f" should be avoided in scripts. If you want to be
safe, check that you don't have local changes or additional files *before*
doing the work.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
To me, home is not rooms and places. It is the people I want to be with.
		-- FJ van Wingerde
