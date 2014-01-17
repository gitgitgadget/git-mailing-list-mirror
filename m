From: Yuri <yuri@rawbw.com>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 18:46:01 -0800
Message-ID: <52D89969.3040802@rawbw.com>
References: <52D87A79.6060600@rawbw.com> <20140117014758.GF7249@sigill.intra.peff.net> <52D88F30.4000807@rawbw.com> <20140117021320.GA12444@sigill.intra.peff.net> <52D8953A.8010307@rawbw.com> <20140117023205.GA13023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:46:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zRl-00021N-LB
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbaAQCqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:46:08 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:54849 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbaAQCqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:46:07 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0H2k1pN084584;
	Thu, 16 Jan 2014 18:46:01 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117023205.GA13023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240566>

On 01/16/2014 18:32, Jeff King wrote:
> Ah, if "more" can handle the colors, then that is preferable.
>
> I do think it would have to be system-specific, though. Unlike "less",
> there are many implementations of "more", and quite a lot of them will
> probably not support colors. We can make it a build-time option, and
> set it to "on" for FreeBSD.

Build-time option would be perfect.
#if defined(__FreeBSD__) || defined(__NetBSD__) || defined(__OpenBSD__)
I think they all use 'more' derived from the same root.

> I would go even further, and convey even more information with
> colors. For example, make all dates which are less than 24 hours red.
> That's an orthogonal issue. I'm not sure I agree, but if you are
> interested, feel free to prepare a patch, which will get some discussion
> going.

Orthogonal, I know. Conveying more info in aesthetic way is always good, 
without making it look like a rainbow.

Yuri
