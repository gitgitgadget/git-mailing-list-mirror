From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 2/4] push: introduce new push.default mode "simple"
Date: Sun, 22 Apr 2012 18:24:58 +0200
Message-ID: <4F9430DA.4030304@in.waw.pl>
References: <vpqfwbye9re.fsf@bauges.imag.fr> <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr> <1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr> <20120420203324.GB13103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLzbK-00049x-QU
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 18:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab2DVQZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 12:25:14 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35345 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab2DVQZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 12:25:12 -0400
Received: from 213-238-114-173.adsl.inetia.pl ([213.238.114.173] helo=[192.168.2.4])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SLzay-0002hC-8z; Sun, 22 Apr 2012 18:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <20120420203324.GB13103@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196082>

Some minor spelling fixes:

> When calling "git push" without argument, we want to allow Git to do
> something simple to explain and safe. push.default=matching is unsafe
> when use to push to shared repositories, and hard to explain to beginners
       used
> in some context. It is debatable whether 'upstream' or 'current' is the
       contexts
> safest or the easiest to explain, so introduce a new mode called 'simple'
> that is the intersection of them: push the upstream branch, but only if
                                    push to the
> it has the same name remotely. If not, give an error that suggest the
> right command to push explicitely to 'upstream' or 'current'.


On 04/20/2012 10:33 PM, Jeff King wrote:
> On Fri, Apr 20, 2012 at 04:59:02PM +0200, Matthieu Moy wrote:
> 
>> it has the same name remotely. If not, give an error that suggest the
>> right command to push explicitely to 'upstream' or 'current'.
> 
> s/suggest/&s/
> 
>> beneficial on the next pull. Lacking better argument, we chose to deny
>> the push, because it will be easier to change in the future is someone
>> shows us wrong.
> 
> s/is/if/
> 
>> Original-patch-by: Jeff King <peff@peff.net>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Except for the broken-ness, this adds the last line in the warning message:
>>
>> "To chose either option permanently, read about push.default in git-config(1)"
       choose

> I don't think that makes sense if I have set "push.default" to "simple"
> myself. IOW, shouldn't that get added later, when it eventually becomes
> the default (and then, only when it was chosen because it is the
> default, not because somebody explicitly said they wanted it)?

-
Zbyszek
