From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: shared GIT repos
Date: Tue, 27 Sep 2005 12:29:32 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.27.10.29.32.813139@smurf.noris.de>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <pan.2005.09.27.06.35.35.834134@smurf.noris.de> <7vu0g70yqg.fsf_-_@assigned-by-dhcp.cox.net> <20050927084513.GU31276@kiste.smurf.noris.de> <20050927135903.6b20a76b.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 27 12:34:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKClF-0003Rt-R4
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 12:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVI0Kca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 06:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVI0Kca
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 06:32:30 -0400
Received: from main.gmane.org ([80.91.229.2]:37568 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964890AbVI0Kc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 06:32:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EKCjm-0002s6-5G
	for git@vger.kernel.org; Tue, 27 Sep 2005 12:31:02 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 12:31:02 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 12:31:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9390>

Hi, Sergey Vlasov wrote:

> On Tue, 27 Sep 2005 10:45:13 +0200 Matthias Urlichs wrote:
> 
>> > If one has commit privileges, then one can already do enough
>> > harm to the project without being able to remove objects nor
>> > updating a ref with non-fast-forward ref.
>> 
>> But in that case it's traceable what happened and whodunit.
> 
> Don't forget that the user who has rights to invoke git-receive-pack
> can set the "author" and "committer" fields in his commits to anything
> he wants - unless you check these fields in hooks/update.

Sure. I plan to; "committer" at least should match one of the user's known
email addresses. In addition to that, the files will belong to the user.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Never count your chickens before they rip your lips off.
