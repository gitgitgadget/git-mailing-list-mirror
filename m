From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: make test
Date: Mon, 15 Oct 2012 14:34:59 +0200
Message-ID: <m2mwznrk0c.fsf@igel.home>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net>
	<003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de>
	<507BF0EA.7000805@viscovery.net>
	<003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de>
	<507BF8FE.1060502@viscovery.net>
	<003901cdaacc$6f87e640$4e97b2c0$@schmitz-digital.de>
	<507BFD03.7060208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joachim Schmitz <jojo@schmitz-digital.de>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 14:35:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNjtA-0001HQ-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 14:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab2JOMfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 08:35:07 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:45794 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab2JOMfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 08:35:06 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XgJyD4grPz3hhcF;
	Mon, 15 Oct 2012 14:35:00 +0200 (CEST)
X-Auth-Info: 6KaZgy1gZJvgQbA9iHKYVSsKoIlc4iMqCTDfHnmO+zE=
Received: from igel.home (ppp-88-217-104-12.dynamic.mnet-online.de [88.217.104.12])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XgJyD4J3Lzbbjw;
	Mon, 15 Oct 2012 14:35:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 2C70ECA2A4; Mon, 15 Oct 2012 14:35:00 +0200 (CEST)
X-Yow: I've got a COUSIN who works in the GARMENT DISTRICT...
In-Reply-To: <507BFD03.7060208@viscovery.net> (Johannes Sixt's message of
	"Mon, 15 Oct 2012 14:09:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207743>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 10/15/2012 13:58, schrieb Joachim Schmitz:
>> ++ mkdir failing-cleanup
>> ++ cd failing-cleanup
>> ++ cat
>> ++ chmod +x failing-cleanup.sh
>> ++ test_must_fail ./failing-cleanup.sh
>> + eval_ret=1
>
> I wonder why the log does not show the commands of function
> test_must_fail.

That's because stderr is redirected.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
