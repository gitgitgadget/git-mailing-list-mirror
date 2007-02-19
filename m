From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really
 altering the ref
Date: Tue, 20 Feb 2007 09:59:28 +1300
Message-ID: <45DA0FB0.8030403@catalyst.net.nz>
References: <200702131512.45412.andyparkins@gmail.com>	<7v4pppuwpv.fsf@assigned-by-dhcp.cox.net>	<200702140913.55506.andyparkins@gmail.com> <7vfy99t761.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>,
	Martyn Smith <martyn@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 22:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJFcN-000587-7I
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 22:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbXBSU7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbXBSU7l
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:59:41 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:36387 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbXBSU7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:59:40 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HJFbg-0005U7-SW; Tue, 20 Feb 2007 09:59:32 +1300
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <7vfy99t761.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40152>

Junio C Hamano wrote:
> I suspect Martin and Martyn chose 1 to match EPERM (I am looking
> at /usr/include/asm-generic/errno-base.h), and I think your new
> error case falls into EPERM category as well.  Since your patch
> is currently queued in 'pu', I can just go ahead and fix it
> myself with "git commit --amend", but an Ack from down under
> would certainly be appreciated ;-).

ACK -- we were either smart in using EPERM or, more likely, super smart
in forcing an error against a real CVS server and watching what it did.

It's better than saying "I don't remember" in any case.

(Sorry about the delay, justback from holidays)

cheers


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
