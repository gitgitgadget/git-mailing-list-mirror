From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git_progname (was: Re: User-relative paths)
Date: Thu, 27 Oct 2005 10:34:12 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.27.08.34.11.285742@smurf.noris.de>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net> <435DF6DA.6010205@op5.se> <20051025093150.GB30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 27 10:39:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV3Fi-000123-RV
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 10:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVJ0Igk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVJ0Igj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 04:36:39 -0400
Received: from main.gmane.org ([80.91.229.2]:53471 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965004AbVJ0Igj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 04:36:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EV3Df-0000Rr-Hi
	for git@vger.kernel.org; Thu, 27 Oct 2005 10:34:43 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 10:34:43 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 10:34:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10701>

Hi, Petr Baudis wrote:

> Someone said that converting main()s to git_main()s would help the
> libification effort,

Wasn't me, and frankly I doubt it. "old-style" programs just call the
compatibility interface instead, and "new-style" ones call the libraries'
initialization *after* they've parsed any environment vars or flags 
that are necessary.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
While the difficulties and dangers of problems tend to increase at a
geometric rate, the knowledge and manpower qualified to deal with these
problems tend to increase at an arithmetic rate.
					-- Yehezkel Dror
