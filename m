From: Pavel Roskin <proski@gnu.org>
Subject: Re: Segfaults with USE_CURL_MULTI
Date: Mon, 22 May 2006 11:56:34 -0400
Message-ID: <1148313394.29228.11.camel@dv>
References: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 17:56:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiClx-0004G0-9a
	for gcvg-git@gmane.org; Mon, 22 May 2006 17:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWEVP4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 11:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWEVP4m
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 11:56:42 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:28141 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750729AbWEVP4l
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 11:56:41 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FiCls-0000Gb-Q5
	for git@vger.kernel.org; Mon, 22 May 2006 11:56:40 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FiCln-0006jh-2q; Mon, 22 May 2006 11:56:35 -0400
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20512>

On Sat, 2006-05-20 at 20:47 +0200, Florian Weimer wrote:
> Is anybody else seeing segfaults on dumb HTTP pull with
> USE_CURL_MULTI?

_Everybody_ is seeing them!  Just look for "segfaults" in the archives:

http://marc.theaimsgroup.com/?l=git&w=2&r=1&s=segfaults&q=b

This patch looks promising, but I'm yet to test it:
http://marc.theaimsgroup.com/?l=git&m=114816558325617&w=2

>   For example, this crashes for me:
> 
> $ git clone http://git.enyo.de/fw/debian/debfoster.git upstream
> 
> GDB shows that this happens inside the call to curl_multi_perform.

Same for me:
http://marc.theaimsgroup.com/?l=git&m=114790994726570&w=2

-- 
Regards,
Pavel Roskin
