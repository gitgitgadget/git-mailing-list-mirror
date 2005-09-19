From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 16:47:54 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.14.47.51.811409@smurf.noris.de>
References: <20050919134838.GC2903@pasky.or.cz> <432ECB92.5000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Sep 19 16:54:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMzr-00060F-4L
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVISOvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVISOvw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:51:52 -0400
Received: from main.gmane.org ([80.91.229.2]:33413 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932446AbVISOvw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:51:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHMxd-0005NP-8V
	for git@vger.kernel.org; Mon, 19 Sep 2005 16:49:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:49:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:49:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8871>

Hi, A Large Angry SCM wrote:

> Saying that the user's name is first and a particular punctuation 
> character SHALL be the standard cut point and everyone not happy with 
> the results should explicitly set the Git environment variables is the 
> wrong approach.

I disagree. Standard add-user tools use the gecos field in one of two ways:
- fullname
- fullname,and,some,other,cruft

Sure, many organizations bake their own, but I'd argue that the majority
doesn't.

> AND/OR to include 
> the what Git thinks the user's name name might be in the commit message
> template they're editing (like the file list).

I think that's a good idea, as long as people are told how to change it
(i.e., an envvar -- NOT by editing the file).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
On those occasions when the angel managed to get his mind into the
twentieth century, it always gravitated to 1950.
        -- (Terry Pratchett & Neil Gaiman, Good Omens)
