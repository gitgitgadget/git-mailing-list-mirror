From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: asciidoc/xmlto problem building manpages
Date: Tue, 13 Sep 2005 16:11:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.13.14.11.10.995089@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 13 16:18:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFBZn-0008G3-JE
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 16:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVIMOP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 10:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVIMOP5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 10:15:57 -0400
Received: from main.gmane.org ([80.91.229.2]:60599 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964785AbVIMOP4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 10:15:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFBXV-0007Xm-6O
	for git@vger.kernel.org; Tue, 13 Sep 2005 16:13:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Sep 2005 16:13:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Sep 2005 16:13:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8465>

Hmmm...

$ make -C Documentation man
asciidoc -b docbook -d manpage git-add-script.txt
xmlto man git-add-script.xml
XPath error : Undefined variable
compilation error: file file:///usr/share/xml/docbook/stylesheet/nwalsh/html/autotoc.xsl line 528 element div
Attribute template class: failed to compile $titles
[ lots more ]

That's on Debian Sarge, with asciidoc 7.0.0-1 and xmlto 0.0.18-5.

Ideas?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
A waste is a terrible thing to mind.
					-- Custodians of Love Canal
