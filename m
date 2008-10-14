From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Problem with CRLF line endings and colored diff
Date: Wed, 15 Oct 2008 01:08:17 +0200
Message-ID: <48F52661.4010800@gmx.ch>
References: <48F50B97.9090106@gmx.ch> <7v4p3e7r9e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 01:09:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpt1A-0005Zb-GX
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbYJNXIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 19:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYJNXIU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 19:08:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:60721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751056AbYJNXIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 19:08:20 -0400
Received: (qmail invoked by alias); 14 Oct 2008 23:08:18 -0000
Received: from 174-52.79-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.79.52.174]
  by mail.gmx.net (mp046) with SMTP; 15 Oct 2008 01:08:18 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19iDv49KUNiAuLkk9zq4vuibyQnsRtWqUMoWNFdcS
	wJwRm89kdG1mXL
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
In-Reply-To: <7v4p3e7r9e.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98224>

Junio C Hamano wrote:
> Jean-Luc Herren <jlh@gmx.ch> writes:
>>     <GREEN FOREGROUND>+<RESET><GREEN FOREGROUND>
>>     line2<RESET><RED BACKGROUND><CR><RESET><LF>
> 
> This is expected and deliberate, as you haven't told about your desire to
> consider carriage-returns not as line termination letter.  By default CR
> is just one of the whitespace letters, and colored diff output is
> reminding you that you introduced a line with a trailing whitespace.

Ah, I see, I didn't know I have to tell it that I want to use
CRLF...  Works fine now.  Sorry for the noise.

jlh
