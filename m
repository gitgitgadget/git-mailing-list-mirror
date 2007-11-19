From: David Kastrup <dak@gnu.org>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 14:37:51 +0100
Message-ID: <861wamz780.fsf@lola.quinscape.zz>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr> <86k5oez9f5.fsf@lola.quinscape.zz> <vpqzlxa2y2f.fsf@bauges.imag.fr> <EB96D9F3-D69C-4D46-961C-27885CBC0E52@lrde.epita.fr> <474190EB.2090701@ogersoft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 14:45:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6vr-0008Om-8K
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbXKSNol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbXKSNol
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:44:41 -0500
Received: from main.gmane.org ([80.91.229.2]:47834 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbXKSNok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:44:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu6rb-0005Cq-GN
	for git@vger.kernel.org; Mon, 19 Nov 2007 13:40:35 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 13:40:35 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 13:40:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:JreQO3hTIeZHOFntstbl5dVoX+o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65444>


gerhard.oettl.ml@ogersoft.at writes:

> Benoit Sigoure schrieb:
>> On Nov 19, 2007, at 1:56 PM, Matthieu Moy wrote:
>
>> I think this is irrelevant to the question he asked.
>>
>> Now I think that the fact that SVN does "lightweight" copies by
>> recording that such modification was in fact an `svn cp' / `svn mv'
>> isn't important for git-svn, because the data end up in the Git
>> repository which handles copies and moves much much better than SVN
>> does.  
>
> I hoped this and it was one of the motivations for looking at git  ;-)
>
> But why is so much traffic necessary to transfer data that is
> already _complete_ present in the local git repository?

Is it?  What is the right behavior when the file has been changed
within the git repository (after all, we are rebasing and not tracking
the svn archive)?

While I would probably prefer getting a copy from the changed file
rather than the original one, the matter does not seem completely
trivial in its implications.

> Traffic that seams not to be necessary when using the "not so good"
> svn.

It is not a git problem (git has good packing properties) but rather a
git-svn issue.  So don't blame git in general.

-- 
David Kastrup
