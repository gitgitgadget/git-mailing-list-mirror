From: Yuri <yuri@rawbw.com>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Fri, 17 Jan 2014 12:15:20 -0800
Message-ID: <52D98F58.9050808@rawbw.com>
References: <52D87A79.6060600@rawbw.com> <20140117014758.GF7249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:15:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FpE-0001dJ-Qa
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbaAQUP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:15:28 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:59718 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbaAQUP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:15:27 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0HKFK3b066243;
	Fri, 17 Jan 2014 12:15:21 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117014758.GF7249@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240626>

One other idea to handle this is at configuration phase. You can test 
more and less with every option used on every platform for each of them 
respectively. Test could run the command with the option, and check if 
it passes the given escape sequence. This would be reflected in config.h 
defines like this: MORE_DASH_R_WORKS This would be very accurate.

Not sure if this is an overkill for this issue.

Yuri
