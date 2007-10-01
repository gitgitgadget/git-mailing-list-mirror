From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] rebase: add --signoff option
Date: Mon, 1 Oct 2007 06:59:08 +0200
Message-ID: <8135FFD1-D6BB-41FF-9C3A-D02B3D223BF3@zib.de>
References: <11911689111797-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0709302229320.28395@racer.site> <C94CC989-096D-43B5-BA16-DBD4D84038C0@zib.de> <Pine.LNX.4.64.0709302240450.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 06:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcDLk-00035c-6G
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 06:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbXJAE5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 00:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXJAE5g
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 00:57:36 -0400
Received: from mailer.zib.de ([130.73.108.11]:41341 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbXJAE5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 00:57:35 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l914vXxi004139;
	Mon, 1 Oct 2007 06:57:33 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db119cd.pool.einsundeins.de [77.177.25.205])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l914vWkZ022854
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 1 Oct 2007 06:57:33 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0709302240450.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59581>


On Sep 30, 2007, at 11:41 PM, Johannes Schindelin wrote:

> On Sun, 30 Sep 2007, Steffen Prohaska wrote:
>
>> On Sep 30, 2007, at 11:30 PM, Johannes Schindelin wrote:
>>
>>> On Sun, 30 Sep 2007, Steffen Prohaska wrote:
>>>
>>>> When preparing a series of commits for upstream you may need to
>>>> signoff commits if you forgot to do so earlier.
>>>
>>> Why not use format-patch's --signoff option for that?
>>
>> format-patch is fine for mail. But if I either push the commits to a
>> shared repo (like msysgit's mob) or ask upstream to pull from my  
>> public
>> repo format-patch doesn't help directly.
>
> Fair enough.  But maybe "rebase --interactive" is not too difficult,
> either?

But not too easy either because "rebase --interactive" is based on
"git merge" and not "git am". You can just use a two step process
instead and first "rebase --interactive" followed by
"rebase --signoff".

	Steffen
