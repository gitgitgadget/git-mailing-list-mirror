From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: A case for tailor
Date: Thu, 17 Nov 2005 00:40:20 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.16.23.40.20.119887@smurf.noris.de>
References: <Pine.LNX.4.63.0511151931001.1157@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Nov 17 00:45:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWwb-0001oR-A2
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbVKPXn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVKPXn6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:43:58 -0500
Received: from main.gmane.org ([80.91.229.2]:12931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030555AbVKPXn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 18:43:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EcWus-00019Q-2x
	for git@vger.kernel.org; Thu, 17 Nov 2005 00:42:14 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:42:14 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:42:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12074>

Hi, Johannes Schindelin wrote:

> Possible explanation: at some early stage, the trunk was named "trunk=
",=20
> but somehow (don=C2=B4t ask me how, I am a fan of git, not svn) renam=
ed to=20
> "head".

Well, you *could* use "-T trunk" to import the first part, ^C when it
starts complaining about 'head', duplicate the last line of .git/svn2gi=
t
(incrementing the SVN change number), and continue with "-T head".

That hackery sortof depends on Upstream not changing anything *else* wh=
ile
renaming 'trunk' to 'head' ...

Of course, the second possibility is to allow patterns as prefixes, dro=
p
the distinction of "trunk" and "branch", and store the refs as full
paths under .git/refs/heads/**. You're welcome to submit a patch; pleas=
e
don't forget backwards compatibility for those poor souls who need to d=
o
incremental imports. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.nor=
is.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.nor=
is.de
 - -
Got a dictionary?  I want to know the meaning of life.
