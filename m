From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Wed, 15 Oct 2014 13:24:22 +0200
Message-ID: <543E5966.80400@virtuell-zuhause.de>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net> <20141014095119.GC16686@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 13:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeMgy-0006jr-Oo
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 13:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbaJOLY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 07:24:29 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59143 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928AbaJOLY2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 07:24:28 -0400
Received: from p5ddc1cb8.dip0.t-ipconnect.de ([93.220.28.184] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XeMgr-0006I5-OJ; Wed, 15 Oct 2014 13:24:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <20141014095119.GC16686@peff.net>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1413372268;0fb1164c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.2014 um 11:51 schrieb Jeff King:
> What's the status on AsciiDoc versus AsciiDoctor? The latter seems more
> actively developed these days, but perhaps that is just my perception.
> The incompatibilities seem fairly minimal (if those first two patches
> are the extent of it, I have no problem at all trying to remain
> compatible with both). Would it ever make sense to switch to AsciiDoctor
> as our official command-line build program? I know it is supposed to be
> much faster (though a lot of the slowness in our build chain is due to
> docbook, not asciidoc itself).

Just recently we added the AsciiDoc toolchain to our git-for-windows/sdk
(formerly known as msysgit). So I'm not really fond of switching now to
something different again.

Remaining compatible with both would therefore be my choice.

Thomas
