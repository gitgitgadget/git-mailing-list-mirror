From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Sun, 31 Oct 2010 21:26:14 +0100
Message-ID: <m24oc2p0rd.fsf@igel.home>
References: <20101031174430.GA30236@arf.padd.com>
	<20101031195933.GA21240@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 21:26:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCeTw-0003J3-F9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 21:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab0JaU0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 16:26:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58890 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0JaU0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 16:26:18 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 323E81C15828;
	Sun, 31 Oct 2010 21:26:15 +0100 (CET)
Received: from igel.home (ppp-88-217-112-158.dynamic.mnet-online.de [88.217.112.158])
	by mail.mnet-online.de (Postfix) with ESMTP id 22D1B1C003BD;
	Sun, 31 Oct 2010 21:26:15 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D4C6FCA2A0; Sun, 31 Oct 2010 21:26:14 +0100 (CET)
X-Yow: ..  I see TOILET SEATS...
In-Reply-To: <20101031195933.GA21240@burratino> (Jonathan Nieder's message of
	"Sun, 31 Oct 2010 14:59:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160451>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index bc7aedd..b210188 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -81,6 +81,19 @@ test_expect_success 'revert after renaming branch' '
>  
>  '
>  
> +test_expect_success 'revert on stat-dirty working tree' '

ITYM s/revert/cherry-pick/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
