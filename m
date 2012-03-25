From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Sun, 25 Mar 2012 22:00:01 +0200
Message-ID: <4F6F7941.8060008@gmx.net>
References: <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3446.9080001@gmx.net> <20120325011948.GC27651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 21:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBtbM-0007j1-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 21:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931Ab2CYT7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 15:59:39 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:47398 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755087Ab2CYT7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 15:59:39 -0400
Received: (qmail invoked by alias); 25 Mar 2012 19:59:37 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.173.43]
  by mail.gmx.net (mp040) with SMTP; 25 Mar 2012 21:59:37 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1/TpnUB3O3TVkWvzdpZoSJbdjhwnZ8qXU6HNcZD55
	Qor00SCR/GOX27
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120325011948.GC27651@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193882>

On 25.03.2012 03:19, Jeff King wrote:
> On Sat, Mar 24, 2012 at 09:53:26PM +0100, Ivan Todoroski wrote:
> I think there is a minor formatting bug in the above. Asciidoc will make
> your two paragraphs into a single one, won't it? I think you need to do
> the (horribly ugly):
> 
>   --stdin::
>       First paragraph.
>   +
>   Second paragraph.

Apparently this works too (i.e. indent the "+" too):

   --stdin::
       First paragraph.
       +
       Second paragraph.
