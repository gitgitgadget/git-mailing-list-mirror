From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 16:34:51 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.14.34.50.221824@smurf.noris.de>
References: <20050919134838.GC2903@pasky.or.cz> <20050919141106.GA31983@compsoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Sep 19 16:41:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMmt-00023g-Fw
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVISOi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVISOi3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:38:29 -0400
Received: from main.gmane.org ([80.91.229.2]:37866 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932438AbVISOi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:38:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHMl5-0001Xl-VX
	for git@vger.kernel.org; Mon, 19 Sep 2005 16:36:40 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:36:39 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:36:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8868>

Hi, Kevin O'Riordan wrote:

> In case this hasn't been suggested, how about cutting on "," but taking
> the first and second fields instead of just the first, and then
> discarding the second if it contains numbers (or is empty, or whatever) ?

... or contains a room name or a street or ...  Bah.

*If* we want heuristics, then I'd check for the presence of more than one
semicolon or comma (semicolon to be checked first). Yes => use the part
before the semicolon or comma. No => use the whole field.

However, I'd argue that we don't want heuristics, we should cut at the
first delimiter, and anybody who wants to change their commit info gets to
set an envvar.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I've got a patent pending on swallowing, oxidation, and chewing gum.
