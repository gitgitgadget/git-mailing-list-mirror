From: Sam Vilain <sam@vilain.net>
Subject: Re: FastCGI support in gitweb
Date: Tue, 04 Mar 2008 01:28:02 +1300
Message-ID: <47CBEED2.30808@vilain.net>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com> <m38x12jeqt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Juan Jose Comellas <juanjo@comellas.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 13:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW9kN-0007sY-18
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 13:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbYCCMZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 07:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYCCMZq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 07:25:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52147 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbYCCMZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 07:25:45 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 695F021D227; Tue,  4 Mar 2008 01:25:43 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 17B4A21D223;
	Tue,  4 Mar 2008 01:25:38 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <m38x12jeqt.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75922>

Jakub Narebski wrote:
> First, as far as I understand it, the patch made gitweb had to be used
> with FastCGI server.  It has no comments in code, and if I remember
> correctly the commit message was also fairly nonexistent.  It mixes
> FastCGI changes with site-wide changes.  It wrapped the whole file in
> "until last request" loop instead of wrapping dispatch only.
> 
> Also I am not sure if gitweb doesn't rely on variables being correctly
> set which they are not in FastCGI mode.
> 
> But most important part: it was never resend (IIRC it was send when
> gitweb development was in separate repository)
> 
> 
> I have attached the FastCGI patch and CC-ed the author.

Thanks.  I didn't submit this because I couldn't fix the bugs in it.
Glad you found it.  I had to make many changes in a similar vein with a
current gitweb version; did it work for you in its current form?

You can get it to run externally using FCGI_SOCKET=:3000 (eg, to listen
on FastCGI TCP port 3000)

Sam.



