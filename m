From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sat, 14 Apr 2012 21:36:38 +0200
Message-ID: <4F89D1C6.8090705@kdbg.org>
References: <20120414182907.GA3915@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, gitster@pobox.com,
	Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:36:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8m8-0004WN-PE
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab2DNTgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:36:44 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:60619 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785Ab2DNTgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:36:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A0560130045;
	Sat, 14 Apr 2012 21:33:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 016AA19F69F;
	Sat, 14 Apr 2012 21:36:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120414182907.GA3915@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195510>

Am 14.04.2012 20:29, schrieb Clemens Buchacher:
> +	r = read_line(proc.err, buf, sizeof(buf));

We have strbuf_getwholeline_fd().

> +	memset(&cat, 0, sizeof(cat));
> +	cat.argv = (const char **)cat_argv;
> +	cat.in = proc.err;
> +	cat.out = 2;

Useless use of cat?

-- Hannes
