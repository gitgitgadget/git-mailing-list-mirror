From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: MinGW port usable
Date: Fri, 2 Feb 2007 00:49:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702020044460.3673@alien.or.mcafeemobile.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <45C18A3B.2070004@zytor.com>
 <45C1C24A.471F40AD@eudaptics.com> <45C2560E.6090504@zytor.com>
 <45C2F648.9030105@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCuF7-0004LB-HI
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXBBI56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXBBI56
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:57:58 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:2555 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbXBBI56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:57:58 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Feb 2007 03:57:58 EST
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S2120E1> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 2 Feb 2007 03:49:44 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <45C2F648.9030105@zytor.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38481>

On Fri, 2 Feb 2007, H. Peter Anvin wrote:

> The Internet is full of people using this technique, but I haven't found a way
> to get a socket which is *not* opened for overlapping I/O.

Doesn't WSASocket() w/out WSA_FLAG_OVERLAPPED work for you? I use that and 
it works just fine with ReadFile/WriteFile (example, I use to to feed std 
handles to CreateProcess - and those are always accessed with ReadFile/WriteFile 
by childs).


- Davide
