From: Andrew Harfoot <ajph@geodata.soton.ac.uk>
Subject: Re: No auto CRLF conversion in Commit Message comments
Date: Thu, 17 Dec 2015 11:58:10 +0000
Organization: GeoData Institute, University of Southampton
Message-ID: <5672A352.60001@geodata.soton.ac.uk>
References: <FBEAE9E9FAB4174499E31C0F26B4BACD2DED2E66@SRV00048.soton.ac.uk>
 <alpine.DEB.2.20.1512161738080.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 12:58:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9XCP-0001AP-0z
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 12:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbbLQL6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 06:58:16 -0500
Received: from mailgate6.iss.soton.ac.uk ([152.78.128.11]:59336 "EHLO
	mailgate6.iss.soton.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbLQL6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 06:58:15 -0500
Received: from mailgate6.iss.soton.ac.uk (localhost.localdomain [127.0.0.1])
	by mailgate6.iss.soton.ac.uk (8.13.8/8.13.4) with ESMTP id tBHBwBxX022004;
	Thu, 17 Dec 2015 11:58:11 GMT
Received: from UOS-MSG00035-VS.soton.ac.uk (uos-msg00035-vs.soton.ac.uk [152.78.119.49])
	by mailgate6.iss.soton.ac.uk (mailgate6.iss.soton.ac.uk [152.78.128.11]) envelope-from <A.J.P.Harfoot@soton.ac.uk> with ESMTP
	id rBGBwB2311028957Q7 ret-id none; Thu, 17 Dec 2015 11:58:11 +0000
Received: from [152.78.222.136] (152.78.222.136) by smtp.soton.ac.uk
 (152.78.119.49) with Microsoft SMTP Server (TLS) id 14.3.248.2; Thu, 17 Dec
 2015 11:58:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <alpine.DEB.2.20.1512161738080.6483@virtualbox>
X-smtpf-Report: sid=rBGBwB231102895700; tid=rBGBwB2311028957Q7; client=relay,white,ipv6; mail=; rcpt=; nrcpt=2:0; fails=0
Received-SPF: None; receiver=mailgate6.iss.soton.ac.uk; client-ip=152.78.119.49; helo=<UOS-MSG00035-VS.soton.ac.uk>
Received-SPF: None; receiver=mailgate6.iss.soton.ac.uk; client-ip=152.78.119.49; envelope-from=<A.J.P.Harfoot@soton.ac.uk>
X-UOS-MailScanner-Information: Please contact Serviceline@soton.ac.uk for more information
X-UOS-MailScanner-ID: tBHBwBxX022004
X-UOS-MailScanner: Found to be clean
X-UOS-MailScanner-From: a.j.p.harfoot@soton.ac.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282648>

Hi Johannes,

On 16/12/2015 16:45, Johannes Schindelin wrote:
> However, if you have `core.editor = notepad`, it should Just Work because
> there is a `notepad` helper that performs the LF<->CR/LF translation
> transparently.

The problem in my case was that I had

`core.editor = notepad.exe`

This wasn't triggering the helper, I've changed it, dropping the '.exe' 
and it now works nicely.

Thanks for your help,

Andy

-- 
Andy Harfoot

GeoData Institute
University of Southampton
Southampton
SO17 1BJ

Tel:  +44 (0)23 8059 2719
Fax:  +44 (0)23 8059 2849

www.geodata.soton.ac.uk
