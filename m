From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sun, 15 Apr 2012 21:57:17 +0200
Message-ID: <4F8B281D.2000305@kdbg.org>
References: <20120414182907.GA3915@ecki> <4F89D1C6.8090705@kdbg.org> <20120414220606.GA18137@ecki> <4F8B0158.4040407@kdbg.org> <20120415193242.GA1960@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, gitster@pobox.com,
	Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:57:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVZe-0003Gm-Dy
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab2DOT5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:57:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17333 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab2DOT5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 15:57:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E41A72C400A;
	Sun, 15 Apr 2012 21:57:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DC19319F6BD;
	Sun, 15 Apr 2012 21:57:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120415193242.GA1960@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195584>

Am 15.04.2012 21:32, schrieb Clemens Buchacher:
> The strbuf_getwholeline_fd implementation calls xread(fd, buf, 1),
> reading only one byte at a time. It does not try to read beyond the
> newline.

Point taken. I only saw "xread" and didn't look further. Sorry for the
noise. I now crawl back under my rock.

-- Hannes
