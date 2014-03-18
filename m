From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Add grep.fullName config variable
Date: Tue, 18 Mar 2014 20:51:31 +0100
Message-ID: <87d2hj9tfg.fsf@igel.home>
References: <874n2w3abu.fsf@igel.home>
	<xmqq7g7sbh56.fsf@gitster.dls.corp.google.com>
	<mvmy507stf1.fsf@hawking.suse.de>
	<xmqqzjkn8i78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ035-00055y-K0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064AbaCRTvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:51:38 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55580 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbaCRTvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:51:37 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fpQ4R5qqlz3hhkk;
	Tue, 18 Mar 2014 20:51:32 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fpQ4N50pLzbbgQ;
	Tue, 18 Mar 2014 20:51:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Gy4v4BXGBlnr; Tue, 18 Mar 2014 20:51:32 +0100 (CET)
X-Auth-Info: gc7hxeveLYK6IPRDmDYzSUl4W7DPuRxPWSiE58aTiWQ=
Received: from igel.home (ppp-88-217-55-80.dynamic.mnet-online.de [88.217.55.80])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 18 Mar 2014 20:51:32 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id C6EF32C1AC7; Tue, 18 Mar 2014 20:51:31 +0100 (CET)
X-Yow: YOW!!  Now I understand advanced MICROBIOLOGY
 and th' new TAX REFORM laws!!
In-Reply-To: <xmqqzjkn8i78.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Mar 2014 11:39:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244376>

Junio C Hamano <gitster@pobox.com> writes:

> Don't we have the exact same issue for the editor, by the way?
> Shouldn't we be running it in the original subdirectory as well?

It's called with an absolute name, so it shouldn't care.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
