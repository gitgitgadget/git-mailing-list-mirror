From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 16:19:02 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.04.14.18.59.102722@smurf.noris.de>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain> <Pine.LNX.4.63.0510040321170.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 04 16:25:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMnhp-0001yP-0m
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 16:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVJDOXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 10:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVJDOXj
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 10:23:39 -0400
Received: from main.gmane.org ([80.91.229.2]:43704 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932471AbVJDOXj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 10:23:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EMnfU-0001Er-5P
	for git@vger.kernel.org; Tue, 04 Oct 2005 16:21:20 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Oct 2005 16:21:20 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Oct 2005 16:21:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9679>

Hi, Daniel Barkalow wrote:

> I'd guess that UNIX sockets have a
> similar capacity (although I'm not going to look it up tonight).

You can set TCP options to change the buffer sizes.

I would however assume that *nobody* sets both the send and receive
buffers such that their cumulative size is <4k, so 99 object IDs
at 41 bytes definitely should be OK.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I was going to include an ethnic slur in here, but I couldn't figure out how
to get you into this file.
