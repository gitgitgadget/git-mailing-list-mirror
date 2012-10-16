From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/PATCH 3/4v2] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 18:28:12 +0200
Message-ID: <m2mwzmxtyb.fsf@igel.home>
References: <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de>
	<28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOA0M-0004nW-4i
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab2JPQ2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 12:28:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47095 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab2JPQ2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 12:28:18 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Xh24s0Qf1z4KKBT;
	Tue, 16 Oct 2012 18:28:12 +0200 (CEST)
X-Auth-Info: fdJs1KRRojxjiRPmJaI+R5NoOUcl5sL6pIvuuf5zDck=
Received: from igel.home (ppp-88-217-123-14.dynamic.mnet-online.de [88.217.123.14])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Xh24r60WFzbbgb;
	Tue, 16 Oct 2012 18:28:12 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7AAB3CA2A4; Tue, 16 Oct 2012 18:28:12 +0200 (CEST)
X-Yow: I think my CAREER is RUINED!!
In-Reply-To: <28ca29e59c5905ba7232dcdbe4661f37ef90cac5.1350399860.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 16 Oct 2012 17:07:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207844>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Some test want to use the time command (not the shell builtin) and test
> for its availability at /usr/bin/time.

An alternative way to suppress the builtin meaning is to quote it, like
\time.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
