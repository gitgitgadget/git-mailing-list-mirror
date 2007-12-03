From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Many things pushed out to 'master'
Date: Mon, 3 Dec 2007 11:12:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031109380.27959@racer.site>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
 <7vabosse23.fsf@gitster.siamese.dyndns.org> <7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 12:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz9El-0002O7-0m
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXLCLM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 06:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbXLCLM7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:12:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:44519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751525AbXLCLM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 06:12:58 -0500
Received: (qmail invoked by alias); 03 Dec 2007 11:12:56 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 03 Dec 2007 12:12:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jL4VL9/0jX762NCfg34GjSkW++roI1zOfiz4TIg
	M1A+vi+6I+CxJW
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66909>

Hi,

On Mon, 3 Dec 2007, Junio C Hamano wrote:

> I've merged a handful topics that have been cooking in 'next' to 
> 'master'.  Except for a few big topics still in 'next', this brings the 
> tip of 'master' much closer to what will become 1.5.4.

I usually run off next + patches, so I do not know if fast-export already 
made it to "master".

But I remembered that you requested a mode for signed tags where they 
would just be copied.  I just realised while implementing "verbatim" that 
"ignore" does just that.  Maybe we should rename this mode to "verbatim"?

And maybe you want to make it the default (even if I think that this will 
result in more surprise moments than the current mode which aborts).

Ciao,
Dscho
