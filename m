From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: On blame/pickaxe
Date: Mon, 16 Oct 2006 16:02:49 +0200
Message-ID: <200610161602.49811.Josef.Weidendorfer@gmx.de>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net> <20061016022159.GZ20017@pasky.or.cz> <7v8xjgvjys.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 16:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZT3g-0006Zn-0p
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 16:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJPODJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 10:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWJPODI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 10:03:08 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:22949 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750764AbWJPODG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 10:03:06 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 40E4D2819;
	Mon, 16 Oct 2006 16:03:04 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v8xjgvjys.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28961>

Hi,

this blame-passing thing really looks very promising and powerful.

On Monday 16 October 2006 08:43, you wrote:
> If the user is not prepared to see code movement, pickaxe can be
> run without -M nor -C to get the classic blame output.

Another blame-passing heuristic would be very interesting for code:
"Ignore white-space changes".
This way, commits which only do some reindentations simply are skipped.

It looks like such a thing would just be a matter of passing "-b" to
executions of "diff" in the blame-passing algorithm.

Josef
