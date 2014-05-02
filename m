From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 10:46:09 +0200
Organization: Organization?!?
Message-ID: <87wqe4y3e6.fsf@fencepost.gnu.org>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
	<536152D3.5050107@xiplink.com>
	<xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
	<20140502074027.GB6288@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 10:46:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg971-0003yv-1C
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 10:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaEBIq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 04:46:28 -0400
Received: from plane.gmane.org ([80.91.229.3]:40818 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaEBIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 04:46:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wg96t-0003oP-FY
	for git@vger.kernel.org; Fri, 02 May 2014 10:46:23 +0200
Received: from x2f52453.dyn.telefonica.de ([2.245.36.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 May 2014 10:46:23 +0200
Received: from dak by x2f52453.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 May 2014 10:46:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f52453.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:DGFjFrF3ESlPfuf61jFuaNpI1F0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247931>

Andreas Krey <a.krey@gmx.de> writes:

> On Wed, 30 Apr 2014 13:01:49 +0000, Junio C Hamano wrote:
> ...
>> I didn't mean "replace 'pull' with 'update' everywhere".  I meant
>> "Introduce 'update' that lets integrate your history into that from
>> the remote, which is to integrate in a direction opposite from how
>> 'pull' does".  
>
> That still doesn't quite solve my problem. If I'm tracking origin/master
> in a local master branch, I can just use 'git pull' to get my 'feature'
> branch (which is named master) updated to the current state of the origin.
> This amounts to 'integrating' origin/master into my master.

This discussion makes as much sense to me as debating whether "git
fiddle" should, in case a simple "git hammer" does not apply, should
translate to an implied "git screwdriver", and when it does, whether
more people's workflows involve turning a screw left rather than right
by default.

What the gibbins?  I don't even use git pull.  I use git fetch, and
then, depending on my needs, I rebase or merge.  git pull is not part of
my workflow exactly because it does non-connected things not translating
unambiguously to a particular identifiable workflow.  It might
sometimes, more by accident than design, do what I would have done
anyway.  But I prefer making that choice on my own, depending on the
particular circumstances.

-- 
David Kastrup
