From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Bisecting through the middle of a big merge?
Date: Sat, 28 Jan 2012 20:47:52 +0100
Message-ID: <m2ty3ffw2f.fsf@igel.home>
References: <jfve09$ih5$1@dough.gmane.org> <m239b0fbpb.fsf@igel.home>
	<jg1e0t$5cs$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 20:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrEGD-0006MM-7T
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 20:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab2A1Tr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 14:47:56 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:46033 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2A1Tr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 14:47:56 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id AA36118001A0;
	Sat, 28 Jan 2012 20:47:52 +0100 (CET)
X-Auth-Info: 2l/JOfpKmqpEYm2x+80yyo8r6tR40NAHe1hBJNGjltY=
Received: from igel.home (ppp-88-217-122-153.dynamic.mnet-online.de [88.217.122.153])
	by mail.mnet-online.de (Postfix) with ESMTPA id C2DD51C000AC;
	Sat, 28 Jan 2012 20:47:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 70DC9CA29F; Sat, 28 Jan 2012 20:47:52 +0100 (CET)
X-Yow: World War Three can be averted by adherence to a strictly enforced
 dress code!
In-Reply-To: <jg1e0t$5cs$1@dough.gmane.org> (walt's message of "Sat, 28 Jan
	2012 10:15:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189265>

walt <w41ter@gmail.com> writes:

> With an eye to doing that, is there an easy way to get a list of all
> the commits included in Linus's merge?

$ git log merge-commit^..merge-commit

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
