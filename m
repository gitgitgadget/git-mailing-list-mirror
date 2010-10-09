From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/3] Submodules: Add the new "fetch" config option for
 fetch and pull
Date: Sat, 09 Oct 2010 21:22:04 +0200
Message-ID: <4CB0C0DC.40108@web.de>
References: <4C7A819B.3000403@web.de>	<7vocckhcb6.fsf@alter.siamese.dyndns.org>	<778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>	<89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org>	<4C9221B6.7070807@web.de>	<AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org>	<4C9351A7.7050609@web.de>	<4C9359D4.2030109@viscovery.net>	<4C935D77.3080008@web.de>	<329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org>	<4C953DE5.6020900@web.de>	<DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>	<4C963D00.9050207@web.de>	<28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>	<4CAB8DDF.8080004@web.de>	<4CAB8E33.1030208@web.de> <AANLkTikUdNdDDK9-+AjuSO_RJHNBZEp5mHPRnsV0Fo0v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 21:22:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ezk-0006uE-CC
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 21:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005Ab0JITWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 15:22:06 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46356 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760473Ab0JITWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 15:22:05 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7D9EE16DB57E7;
	Sat,  9 Oct 2010 21:22:04 +0200 (CEST)
Received: from [93.246.43.182] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P4ezc-0005Kb-00; Sat, 09 Oct 2010 21:22:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTikUdNdDDK9-+AjuSO_RJHNBZEp5mHPRnsV0Fo0v@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX186tYpybXfEYxXDnFkpJyuZug/GHalOxBAcLvmq
	/96SPxftW8liLQymmY1CQXmIcFUa3217vJ6V1CGNPiFcod8ZBr
	kU0EBa+Mssl+BfYJHLwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158599>

Am 07.10.2010 15:33, schrieb Jon Seymour:
>> The .gitmodules file is parsed for "submodule.<name>.fetch" entries before
>> looking for them in .git/config. Thus settings found in .git/config will
>> override those from .gitmodules, thereby allowing the local developer to
>> ignore settings given by the remote side while also letting upstream set
>> defaults for those users who don't have special needs.
>>
> 
> I wonder if the name is a little too general for the function of this
> configuration variable and if it might not be better to qualify it a
> little further, perhaps
> with the recursive suffix, e.g.:
> 
>     submodule.<name>.fetch.recursive
> 
> This would allow us to define other attributes that configure fetch on
> a per submodule basis later should the need arise.

I think that's a valid point (especially as we might add the --recursive
option to other commands too). I will change the option name as proposed
in the next version.
