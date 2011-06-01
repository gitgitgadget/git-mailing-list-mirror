From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Tests for some submodule corner cases.
Date: Wed, 01 Jun 2011 21:26:50 +0200
Message-ID: <4DE6927A.8010902@web.de>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE55857.3090706@xiplink.com> <4DE55D0F.1020905@web.de> <4DE664A1.5060206@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRr4G-0000f3-IA
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758946Ab1FAT04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:26:56 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:58481 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab1FAT0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:26:55 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 307BA1A101458;
	Wed,  1 Jun 2011 21:26:54 +0200 (CEST)
Received: from [93.246.50.133] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QRr4A-0001RQ-00; Wed, 01 Jun 2011 21:26:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DE664A1.5060206@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19ImeePgBW6GnCKxULcWbEI8n+wy8UNirROcy1M
	iml8uk2kbuPNPizJqGM3nUsKyjhb2ila7fjnrDzktnYfXk/awU
	+HcoNkAj+CxB7l2wCdPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174895>

Am 01.06.2011 18:11, schrieb Marc Branchaud:
> On 11-05-31 05:26 PM, Jens Lehmann wrote:
>> No problem, maybe that's just an indication that a reference to "git status"
>> being more capable of telling what is going on inside a submodule is missing
>> to the man page for "git submodule status".
> 
> Yes, that'd possibly help.

Ok, I'll see if I can come up with something ...

> So here's my basic question: How can my build system be sure that a submodule
> contains the correct working directory?  Do I need to do both "git submodule
> status" to check the submodule's HEAD, then also use "git status" to see if
> that HEAD is correctly checked out?

No, "git status" will do both. The only thing it will be silent about is when
a submodule isn't initialized at all ("git submodule status" shows this with
a '-').
