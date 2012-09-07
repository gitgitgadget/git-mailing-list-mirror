From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] ls-remote: document the '--get-url' option
Date: Fri, 07 Sep 2012 10:28:17 +0200
Message-ID: <m2pq5yxmn2.fsf@igel.home>
References: <7v7gs63mio.fsf@alter.siamese.dyndns.org>
	<1347000079-7945-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 10:28:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9tvW-0007Hi-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 10:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab2IGI21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 04:28:27 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57107 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2IGI2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 04:28:24 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XCsH60D1Wz3hhf6;
	Fri,  7 Sep 2012 10:28:18 +0200 (CEST)
X-Auth-Info: 4mocxYbOBRz0TupFn44QskUwO9AwHxb4xxtzg1gvlGQ=
Received: from igel.home (ppp-88-217-117-28.dynamic.mnet-online.de [88.217.117.28])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XCsH56ts4zbbhp;
	Fri,  7 Sep 2012 10:28:17 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 9A85FCA2A4; Fri,  7 Sep 2012 10:28:17 +0200 (CEST)
X-Yow: World War Three can be averted by adherence to a strictly enforced
 dress code!
In-Reply-To: <1347000079-7945-1-git-send-email-stefan.naewe@gmail.com> (Stefan
	Naewe's message of "Fri, 7 Sep 2012 08:41:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204951>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> +--get-url::
> +	Expand the URL of the given remote repository taking into account any
> +	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]).

This should probably also mention that it suppresses the normal output.

(I wonder why this isn't a subcommand of git remote.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
