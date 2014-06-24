From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Tue, 24 Jun 2014 12:07:03 +0200
Message-ID: <lobik7$a7b$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo9mg1$bma$1@ger.gmane.org> <lo9ogu$4in$1@ger.gmane.org> <lo9rcn$8tu$1@ger.gmane.org> <53A88067.5010908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 12:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzNdd-0005Iz-0g
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 12:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbaFXKHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 06:07:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:59647 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbaFXKHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 06:07:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WzNdQ-0005AQ-MU
	for git@vger.kernel.org; Tue, 24 Jun 2014 12:07:28 +0200
Received: from g226035061.adsl.alicedsl.de ([92.226.35.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 12:07:28 +0200
Received: from steveire by g226035061.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 12:07:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g226035061.adsl.alicedsl.de
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252395>

Jens Lehmann wrote:

> Am 23.06.2014 20:24, schrieb Stephen Kelly:
>> Stephen Kelly wrote:
>> 
>>> I see that gitk is showing the output of git diff --submodule, similar
>>> to git submodule summary.
> 
> Right, and for your use case --submodule would have to learn a
> different value in addition to 'log' and 'short'. And the default
> is already configurable via the 'diff.submodule' config option.

Right.

>>> Assuming that is not going to be changed, maybe I can hack
>>> parseblobdiffline locally. I have not really tried to read of write tcl
>>> code before though, so I'd still prefer a 'proper' solution somehow.
> 
> I'd prefer a proper solution too, which is exactly why I tried
> to understand your use case first before speculating about how
> it could be solved.

Thanks for your help!

>> I dug deeper and came up with this patch which suits my needs:
> 
> Yup, I think that's the core of the change necessary to help
> your workflow.

Ok, so I guess we can add --summary=commits ?

I don't write C code generally, so I'm not certain how that needs to be 
propagated.

Thanks,

Steve.
