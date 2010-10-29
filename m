From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: Unable to remove git branch
Date: Fri, 29 Oct 2010 09:56:50 +0200
Message-ID: <4CCA7E42.7080906@debugon.org>
References: <201010290943.13177.sasch.pe@gmx.de> <4CCA7DA8.3020607@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sascha Peilicke <sasch.pe@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 29 09:56:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBjpZ-0007Wu-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 09:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760134Ab0J2H4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 03:56:53 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:50334 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab0J2H4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 03:56:52 -0400
Received: from [172.20.2.23] (p578D1B63.dip.t-dialin.net [87.141.27.99])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0M5tNd-1ONSdH3YtN-00xRH6; Fri, 29 Oct 2010 09:56:51 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <4CCA7DA8.3020607@debugon.org>
X-Provags-ID: V02:K0:VgemFF5zekv+r6C4PkBbT99Db9ieARtgT/BqlNRjbhX
 HwRs9SGehbAQvaiZILMurOscf90/zIir/NWFUCrwn7p0GwLyLo
 l7U0dIiCoiMdt92H/BcOn9cae3aHiAoWsGHuAkaZEt477pFdMw
 GEXAdqm2JiZnhRx23wj7bVFFjfE7jhG9SCIhBZjC98uPSm/EJs
 HaXK2dEgVUe84XKpCgmgFLRryPo1PmZhNQT+doUjbM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160315>

Mathias Lafeldt wrote:
> Sascha Peilicke wrote:
>> Hi guys,
>>
>> I accidentally did an 'git co -b --track origin/foo' ending up with a local 
>> branch '--track'. Sadly, git is unable to remove or rename that branch because 
>> it always interprets it as a parameter. 
>>
>> As a consequence, 'git br -d "--track"' does nothing and 'git br -m "--track" 
>> foo' even renames the current branch, say, master,  to 'foo'. Any hints on how 
>> to get rid of that pesky branch?
>>
>> BTW please CC me as I'm not subscribed to this list.
> 
> Try:
> 
> $ git br -D -- --track

It really should be:

$ git branch -D -- --track

('br' is an alias of mine)

Sorry for the noise.

-Mathias
