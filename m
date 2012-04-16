From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v3] git-daemon wrapper to wait until daemon is ready
Date: Mon, 16 Apr 2012 17:46:30 +0200
Message-ID: <4F8C3ED6.5050802@in.waw.pl>
References: <20120414182907.GA3915@ecki> <4F89D1C6.8090705@kdbg.org> <20120414220606.GA18137@ecki> <20120415115322.GA11786@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:46:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJo8Z-00019E-AT
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab2DPPqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:46:38 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34978 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab2DPPqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:46:38 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SJo8S-0007dg-T2; Mon, 16 Apr 2012 17:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120415115322.GA11786@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195649>

On 04/15/2012 01:53 PM, Clemens Buchacher wrote:
> The shell script which is currently used to parse git daemon output does
> not seem to work reliably. In order to work around such issues,
> re-implement the same procedure in C and write the daemon pid to a file.
>
> This means that we can no longer wait on the daemon process, since it is
> no longer a direct child of the shell process.
>
> Signed-off-by: Clemens Buchacher<drizzd@aon.at>
> ---

> Here's the re-roll for completeness. Still waiting on feedback from the
> OP if this actually solves the problem, though.
I posted a reply in the other thread, but I'm replying here too for 
completeness: yes, the problem is solved.

Thanks,
Zbyszek
