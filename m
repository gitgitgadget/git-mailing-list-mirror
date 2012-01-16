From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] test_interactive: interactive debugging in test scripts
Date: Mon, 16 Jan 2012 21:48:59 +0100
Message-ID: <4F148D3B.4070206@web.de>
References: <4F133069.10308@web.de> <20120115232413.GA14724@sigill.intra.peff.net> <20120116154953.GA21238@padd.com> <4F148211.70106@web.de> <20120116201123.GA18699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 21:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmtUS-00050N-6m
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 21:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab2APUtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 15:49:11 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36428 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab2APUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 15:49:10 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7EB251AFD1E5C
	for <git@vger.kernel.org>; Mon, 16 Jan 2012 21:49:01 +0100 (CET)
Received: from [192.168.178.43] ([91.3.194.97]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MTgqe-1SDOaC04Q4-00Qcgl; Mon, 16 Jan 2012 21:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120116201123.GA18699@sigill.intra.peff.net>
X-Provags-ID: V02:K0:e5xHj0KmaK+av2a27aeWPPbeAXKB7rCkHeWdtqmGz8+
 4fCXcnv58eWhUbAbl3lUM9iC6iUh2LBlXcw9gHlFlBvxwfitZy
 aC1LFbrQoGA5DG4m5iFfGRS94WHVMvocEZEvjQnruL4fhNQisf
 4fUrzWy0zts9aHrfnOEfhzR7hI1fPw4LeBGe5n+twfDrG6u57m
 CNgYOqpSoynWcVF5MqG8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188652>

Am 16.01.2012 21:11, schrieb Jeff King:
> On Mon, Jan 16, 2012 at 09:01:21PM +0100, Jens Lehmann wrote:
> 
>> So I vote for your patch as it takes my initial idea even further. I
>> really like that HOME, TERM and SHELL are honored in your version
>> leaving the user with a fully functional shell of his choice.
> 
> I'm actually mildly negative on this feature, as it interferes with the
> tests themselves. Probably TERM and SHELL don't matter. But $HOME means
> git will read your personal .gitconfig, not any config (or lack thereof)
> in the trash directory.

Good point, I haven't thought of that ... so yes, at least $HOME should
go.
