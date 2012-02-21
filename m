From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Tue, 21 Feb 2012 17:11:40 +0100
Message-ID: <4F43C23C.8070304@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> <CACsJy8AXH6xm-ShH_HF6RwATFwsYtAZQfcWoB9VpaiCMj6e8vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>,
	j.sixt@viscovery.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 17:12:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzsK7-0006GR-TH
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 17:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab2BUQML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 11:12:11 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52916 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab2BUQMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 11:12:10 -0500
Received: from planck.fuw.edu.pl ([193.0.81.236] helo=[192.168.0.175])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzsJe-0007b0-RG; Tue, 21 Feb 2012 17:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <CACsJy8AXH6xm-ShH_HF6RwATFwsYtAZQfcWoB9VpaiCMj6e8vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191167>

On 02/21/2012 04:16 PM, Nguyen Thai Ngoc Duy wrote:
> Not related to changes in the series, but on the same topic. Have you
> considered grouping pathnames to reduce pressure on truncating them?
> Instead of showing
>
> a/b/c | ++--
> a/b/d | --++
>
> you could show
>
> a/b:
> c | ++--
> d | --++
>
> Optimal grouping strategy could be hard, but at least we could use it
> for the case "git diff --stat -- one/path/deep/in/here"
I use (or would like to be able to use) the --stat output to select with 
the mouse and paste into something like
   emacsclient -n <pathname>
This would be harder with the grouping, because I'd have to select two 
parts and paste two times and type a slash. So for me this would be a minus.

Also, I'm not sure about grouping if there's more than one group. The 
graph wouldn't be as readable. But if there's only one group, i.e. if 
all filenames have a common prefix ending in a slash, like in your 
example, this could be useful.

Zbyszek
