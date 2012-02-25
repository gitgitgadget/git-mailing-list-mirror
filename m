From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: send-email SMTP/TLS Debugging
Date: Sat, 25 Feb 2012 18:55:11 +0100
Message-ID: <4F49207F.8050506@in.waw.pl>
References: <874nufv4ov.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sat Feb 25 18:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1LqB-0001mO-Bv
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 18:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400Ab2BYRzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 12:55:23 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55149 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab2BYRzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 12:55:22 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S1Lq0-0004So-Pq; Sat, 25 Feb 2012 18:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <874nufv4ov.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191541>

On 02/25/2012 06:54 AM, David A. Greene wrote:
> Is there some way to turn on TLS authentication debugging using
> git-send-mail?  I'm trying to send a patch but git (or the mail server,
> I suppose) keeps telling me I have "Incorrect authentication data."
> I've checked the settings in .git/config multiple times and they look
> correct.  How can I debug this further?
Please try 'git send-email --smtp-debug=1 ...'

Zbyszek
