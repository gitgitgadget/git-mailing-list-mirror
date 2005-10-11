From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Tue, 11 Oct 2005 21:55:53 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.11.19.55.52.92821@smurf.noris.de>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com> <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com> <4349ED5D.6020703@catalyst.net.nz> <7v4q7p927d.fsf@assigned-by-dhcp.cox.net> <7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net> <7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 11 22:02:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPQIL-0002XI-R7
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 22:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVJKUAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 16:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJKUAO
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 16:00:14 -0400
Received: from main.gmane.org ([80.91.229.2]:32403 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751197AbVJKUAM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 16:00:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EPQG1-0001qK-FH
	for git@vger.kernel.org; Tue, 11 Oct 2005 21:57:53 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Oct 2005 21:57:53 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Oct 2005 21:57:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9984>

Hi, Junio C Hamano wrote:

> I cheated by creating a small repository
>     with funky tag names locally while testing.

Your patch is missing the file "t/t5410-send-funky-names.sh".

;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Being generous is inborn; being altruistic is a learned perversity. No
resemblance ...
					-- Lazarus Long
