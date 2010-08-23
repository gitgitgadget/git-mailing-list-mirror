From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Creating a submodule and bringing history from the main project
Date: Mon, 23 Aug 2010 18:30:55 +0200
Message-ID: <4C72A23F.4030600@web.de>
References: <AANLkTi=JWdp7ZneDpN5r4Zi4VaDfvW40QBZ-=sGx66O2@mail.gmail.com> <AANLkTimoTN10EfeiE3Viim_x1Y3jRG89ANzRd69ah7jz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guillermo Gonzalez <guillermog@tricuspide.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 18:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZvK-0006en-5N
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 18:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab0HWQa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 12:30:57 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57842 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0HWQa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 12:30:56 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id B4EE416E7B9F9;
	Mon, 23 Aug 2010 18:30:55 +0200 (CEST)
Received: from [93.246.62.127] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OnZvD-0001Zk-00; Mon, 23 Aug 2010 18:30:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTimoTN10EfeiE3Viim_x1Y3jRG89ANzRd69ah7jz@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19qsZj0r8PpKC+alSSGUY0Y8H3+fQdJ+ZHOm2Pf
	Br+CGMfNs/IJexM3uTDFJU3r3ovXSxPIYSnmlfSGRm9EpZeQJl
	tR6PLwPp1ri8lM3PxSFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154234>

Am 22.08.2010 19:24, schrieb Guillermo Gonzalez:
> Is it possible to somehow export the history of say lib/componentX
> into a new repository componentX.git?

Sounds like you want to use "git filter-branch", see:
http://progit.org/book/ch6-4.html#making_a_subdirectory_the_new_root
