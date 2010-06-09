From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Wed, 09 Jun 2010 08:23:17 +0200
Message-ID: <4C0F3355.7050202@web.de>
References: <4C0E7037.8080403@web.de> <201006090011.14995.johan@herland.net> <4C0EC201.9060309@web.de> <201006090149.22027.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 09 08:23:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMEhB-0000H2-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 08:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab0FIGXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 02:23:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34022 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0FIGXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 02:23:19 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4507B15E05FA0;
	Wed,  9 Jun 2010 08:23:18 +0200 (CEST)
Received: from [80.128.93.210] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OMEh4-0001VT-00; Wed, 09 Jun 2010 08:23:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006090149.22027.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/fhtaJx4e/PlyYyqFtmWJTqjclCDTx4bBcu0id
	Vp42eu9NfsJ43FhH2SNmV7s9pNt7pxRNP/8VcgZwio0JNu4xGk
	Gytz2zTMFdgAIIlDIuMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148744>

Am 09.06.2010 01:49, schrieb Johan Herland:
> On Wednesday 09 June 2010, Jens Lehmann wrote:
>> There are currently (since 1.7.0) three reasons a submodule is considered
>> dirty:
>>
>> 1) It contains untracked content
>> 2) It contains modified tracked content
>> 3) It contains newer commits than those committed in the superproject
> 
> I guess 3) really means that the submodule's HEAD points to a _different_ 
> (not necessarily _newer_) commit than what's referenced in the superproject.

Sure, please replace my inaccurate description with yours ;-)


>> "all" would ignore 1), 2) & 3)
>> "dirty" would ignore 1) & 2)
>> "untracked" would ignore 1)
> 
> ...and just to complete my understanding of this, 3) requires only checking 
> the submodule's current HEAD, while 1) and 2) require traversing its work 
> tree (i.e. the equivalent of a 'git status'), hence the potential 
> expensiveness.

Thats correct.


> Also, I guess 2) includes both staged and unstaged modifications to tracked 
> content?

Yes (as it doesn't make a difference to the superproject if modifications
inside the submodule are staged or not there is no distinction made between
those two).


> Thanks for your help. All the ideas in your cover letter seem good to me.

Thank you for your comments, I'll start hacking to show some more patches.
