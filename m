From: Yuri <yuri@rawbw.com>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 18:28:10 -0800
Message-ID: <52D8953A.8010307@rawbw.com>
References: <52D87A79.6060600@rawbw.com> <20140117014758.GF7249@sigill.intra.peff.net> <52D88F30.4000807@rawbw.com> <20140117021320.GA12444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zAS-0007jw-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbaAQC2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:28:17 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:55842 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbaAQC2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:28:16 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0H2SAhS081715;
	Thu, 16 Jan 2014 18:28:10 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117021320.GA12444@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240561>

On 01/16/2014 18:13, Jeff King wrote:
> Interesting. I take it that "more" does not pass through ANSI codes at
> all, then.
>


Actually, 'more -R' also passes colors on FreeBSD. So maybe you can 
always add -R if PAGER=more on *BSD (any of them) ? This will fix this 
issue.

I know, it is unpleasant when you add some new minor feature (like term 
colors), and people begin to complain about some related issues. But 
turning colors off isn't a good approach also. App just needs to be 
smarter about when and how to use them.

I would go even further, and convey even more information with colors. 
For example, make all dates which are less than 24 hours red.

Yuri
