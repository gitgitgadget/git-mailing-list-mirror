From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Sat, 09 Jun 2012 11:16:38 +0200
Message-ID: <4FD31476.90104@in.waw.pl>
References: <1339122742-28677-1-git-send-email-martin@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Martin Langhoff <martin@laptop.org>
X-From: git-owner@vger.kernel.org Sat Jun 09 11:17:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdHn0-0003pC-Lo
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 11:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab2FIJQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 05:16:54 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38193 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab2FIJQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 05:16:53 -0400
Received: from aazh216.neoplus.adsl.tpnet.pl ([83.6.145.216] helo=[192.168.1.13])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SdHmn-0005Ha-R0; Sat, 09 Jun 2012 11:16:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1339122742-28677-1-git-send-email-martin@laptop.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199547>

On 06/08/2012 04:32 AM, Martin Langhoff wrote:
> git log -G'regex' is a very usable alternative to the classic
> pickaxe. Minimal patch to make it usable from gitk.

>      set gm [makedroplist .tf.lbar.gdttype gdttype \
>  		[mc "containing:"] \
>  		[mc "touching paths:"] \
> -		[mc "adding/removing string:"]]
> +		[mc "adding/removing string:"] \
> +		[mc "changes match regex:"]]

Hi,

this feature is definitely useful. One nitpick: the string that you add
becomes part of a sentence in the GUI: "prev/next commit changes match
regex", which is in different grammatical form then the existing
snippets. Should be something with '-ing'.

Zbyszek
