From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Sat, 09 Oct 2010 22:37:30 +0200
Message-ID: <4CB0D28A.10506@web.de>
References: <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <20101006232243.GA30302@burratino> <4CB0C279.8050407@web.de> <20101009200232.GB19064@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:37:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gAw-0001In-E0
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760560Ab0JIUhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:37:36 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:50093 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab0JIUhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:37:32 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id A538F1663ED65;
	Sat,  9 Oct 2010 22:37:30 +0200 (CEST)
Received: from [93.246.43.182] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P4gAc-0003Im-00; Sat, 09 Oct 2010 22:37:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20101009200232.GB19064@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18BSzV5zAZrceAXuJu+84lBl+H/pVuokzsyZrNe
	+dkqsbukHaJAiUmayAx2DRrrgfAEnOfqGcloKiCR70FWz1fDJL
	GJytxbm3GzhvahAjRPsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158606>

Am 09.10.2010 22:02, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> Am 07.10.2010 01:22, schrieb Jonathan Nieder:
> 
>>>     I also
>>> don't want to pay the penalty of fetching, say, git-gui when I don't
>>> need it.
>>
>> I'm not sure I understand your setup, do you want to configure that for
>> each remote or for each submodule?
> 
> Without thinking too hard about it, I imagine listing submodules in
> the [remote "foo"] stanza, just like I list branches there now.

Yup, that makes sense.


>> Because you can already do the latter
>> with my patches. And configuring that via .gitmodules has the advantage
>> that every clone inherits that setting
> 
> I certainly do _not_ want that property.  Upstream can tell what
> submodules to check out by default, but aside from that, the choice of
> what to fetch has nothing to do with them.

Ok, I take that as a vote to remove the parsing of .gitmodules in patch
2/3. But I assume you are fine with being able to configure that for
each submodule via .git/config?
