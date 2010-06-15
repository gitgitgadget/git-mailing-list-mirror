From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Changled submodule cannot be "git added"
Date: Tue, 15 Jun 2010 18:05:41 +0200
Message-ID: <4C17A4D5.5040100@web.de>
References: <20100615072514.GA3260@schottelius.org> <20100615073720.GB3260@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:05:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYe7-0001jv-PM
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab0FOQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:05:46 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41413 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0FOQFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:05:46 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id DCAE016702B88;
	Tue, 15 Jun 2010 18:05:44 +0200 (CEST)
Received: from [80.128.78.142] (helo=[192.168.178.26])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OOYe0-00029b-00; Tue, 15 Jun 2010 18:05:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100615073720.GB3260@schottelius.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18nc3nnOtZfoxFvfdNI/YW4No3jmOD3N7ZkN6NE
	fX2PhfVwxULBupZbDWvOw5N5gVgw2BZaUYN7aPPM8XopWZapyf
	iCIDddYIv2im3X9QWV3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149193>

Am 15.06.2010 09:37, schrieb Nico -telmich- Schottelius:
> Nico -telmich- Schottelius [Tue, Jun 15, 2010 at 09:25:14AM +0200]:
>> % git status
>> #       modified:   modules/tftpd_hpa (modified content)
> 
> Ok, found out that I changed stuff within modules/tftpd_hpa, instead of
> merging from the source.

To make such surprises visible is the intent of showing "(modified
content)" here.


> Imho the git status output is a bit misleading, as I assume that
> I can git add stuff that's modified.

Maybe you just overlooked this line in the output of "git status":
"(commit or discard the untracked or modified content in submodules)"


> Regarding the other problem
> 
>> - Why does git checkout not remove modules/ethz_systems_private/,
>>   when switching from the master to the private branch?
>>   (the module is only registered in the private branch)
> 
> I'm still not sure what's the reason for that.

Because there might be stuff in there which is not tracked but you
might hate loosing by switching a branch.
