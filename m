From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Tue, 13 Sep 2005 19:46:00 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.13.17.45.59.307129@smurf.noris.de>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com> <432060B8.6080408@gmail.com> <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net> <432089D5.7000102@gmail.com> <pan.2005.09.11.16.37.20.483911@smurf.noris.de> <43247298.2010500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 13 19:51:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFEuB-0000cL-6o
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 19:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVIMRtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 13:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVIMRtK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 13:49:10 -0400
Received: from main.gmane.org ([80.91.229.2]:22148 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964935AbVIMRtI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 13:49:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFEsL-00006g-CU
	for git@vger.kernel.org; Tue, 13 Sep 2005 19:47:21 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Sep 2005 19:47:21 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Sep 2005 19:47:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8475>

Hi, A Large Angry SCM wrote:

>> I propose using no extensions whatsoever: simply mirror the refs/ tree.
> 
> The extensions allow the annotation of directories as well as files. 
> That's something that can't be done if extensions are not used.

IMHO, that is the sort of information that's best saved in the "how is our
source organized" section of your ./HACKING file.

Or you can simply use reiserfs4, with its files-are-directories feature.
(*ducks and runs*)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Ask yourself whether you are happy and you cease to be so.
