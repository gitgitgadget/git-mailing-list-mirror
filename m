From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Request for help from binary packaging people.
Date: Wed, 10 Aug 2005 23:15:42 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Aug 10 23:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2xy3-0001ns-Ge
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 23:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVHJVS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 17:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVHJVS1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 17:18:27 -0400
Received: from main.gmane.org ([80.91.229.2]:2759 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030273AbVHJVS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 17:18:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E2xxE-0001by-4L
	for git@vger.kernel.org; Wed, 10 Aug 2005 23:17:40 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Aug 2005 23:17:40 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Aug 2005 23:17:40 +0200
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

> For Debian, we recommend lib*-*-perl packages.  Do we need to recommend
> perl itself as well, or is it the case that things that are covered with
> the automatic dependency chain need not be listed? 

No, yes.  ;-)

What happens if the lib*-perl packages are not installed? If some scripts
break, that's a Bad Thing, and would require those packages to be moved to
Depends:.

> Earlier I said that
> the Debian side is reasonably accurate to the best of my knowledge, but I
> would appreciate it if somebody ran lintian on it.

Will do.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"I say we take off; nuke the site from orbit.  It's the only way to be sure."
- Corporal Hicks, in "Aliens"
