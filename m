From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Tue, 06 Oct 2009 13:51:09 +0200
Message-ID: <4ACB2F2D.8010503@web.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de> <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de> <4ACB22E9.3010001@web.de> <7vocok21pw.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910061344070.4686@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 13:54:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv8cJ-00017d-J3
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 13:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbZJFLw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 07:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbZJFLw4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 07:52:56 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52091 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbZJFLwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 07:52:55 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1C839125872F9;
	Tue,  6 Oct 2009 13:51:10 +0200 (CEST)
Received: from [80.128.52.8] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mv8ZR-0006m9-00; Tue, 06 Oct 2009 13:51:09 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <alpine.DEB.1.00.0910061344070.4686@intel-tinevez-2-302>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Vc/l3S2fbQCtiPq2Qho8jkMe9daRhffD9es6B
	hAOfML291t6yK0hnEqtvYQDOxSqxYylETFhlh9ra21jtLMJsnx
	fu7qj3747gZcPLs6joDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129625>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 6 Oct 2009, Junio C Hamano wrote:
> 
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>>> But I really, really, really want to avoid a fork() in the common case.  I 
>>>> do have some users on Windows, and I do have a few submodules in that 
>>>> project.  Having too many fork() calls there would just give Git a bad 
>>>> reputation.  And it has enough of that, it does not need more.
>>> Me too thinks performance matters here. We do have a repo at my dayjob
>>> with more than a handful of submodules and its main target platform is
>>> windows ... so having that perform nicely is a win for us.
>> Numbers?
>>
>> I'd prefer to avoid kludges that favors unsubstantiated performance
>> argument over correctness.
> 
> Well, having worked with msysGit for such a long time, I just _know_ that 
> a subprocess costs a substantial amount of time.
> 
> But as you don't trust my words, maybe Jens could be so kind as to perform 
> some benchmarks?  I am short on Git time budget, but I will make a commit 
> on my submodule-summary branch that allows to start a subprocess always.

Sure, will do.

Jens
