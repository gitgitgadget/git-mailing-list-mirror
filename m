From: Yuri <yuri@rawbw.com>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 18:02:24 -0800
Message-ID: <52D88F30.4000807@rawbw.com>
References: <52D87A79.6060600@rawbw.com> <20140117014758.GF7249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:02:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ylY-0000zN-EM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaAQCCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:02:32 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:63900 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbaAQCCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:02:30 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0H22OX9077115;
	Thu, 16 Jan 2014 18:02:24 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117014758.GF7249@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240557>

On 01/16/2014 17:47, Jeff King wrote:
> Are you using "less" as your pager (it is the default in git unless you
> have set your PAGER environment variable)? If so, do you have the "R"
> option set to pass through ANSI codes? Git will set this automatically
> in your "LESS" variable if you do not already have such a variable (but
> it will not touch it if you already have it set, and are missing "R").

My PAGER variable was set to "more". PAGER=more is also a default for a 
newly created user in FreeBSD.

So what would be the correct fix here in general, so that git will work 
fine for a new unchanged user?

Yuri
