From: Miles Bader <miles@gnu.org>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 06 Feb 2010 17:17:31 +0900
Message-ID: <87mxzmsrqc.fsf@catnip.gol.com>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
	<7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
	<20100206035143.GA31784@sigill.intra.peff.net>
	<7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jan Engelhardt <jengelh@medozas.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 09:21:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndfus-0000xV-Os
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 09:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0BFIRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 03:17:46 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:43137 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0BFIRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 03:17:45 -0500
Received: from 218.231.148.164.eo.eaccess.ne.jp ([218.231.148.164] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NdfrA-0006hS-De; Sat, 06 Feb 2010 17:17:32 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 82B54DF8F; Sat,  6 Feb 2010 17:17:31 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7v7hqrdkxb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 05 Feb 2010 20:53:36 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139148>

Junio C Hamano <gitster@pobox.com> writes:
> I have known GNU extended grep implementations long enough but never saw
> that "--" used to quote a pattern.  Is it worth supporting to begin with?

Well, it is a natural consequence of the way command-line parsing works
in typical GNU progs; "--" doesn't mean "files follow", it means "no
more options"....

-Miles

-- 
I'd rather be consing.
