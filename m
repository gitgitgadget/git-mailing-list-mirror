From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Is there something like a blamed diff?
Date: Mon, 17 Feb 2014 18:41:13 +0100
Message-ID: <87ppmltz5y.fsf@thomasrast.ch>
References: <8738jk1as7.fsf@fencepost.gnu.org> <87ioseujej.fsf@thomasrast.ch>
	<8761oeuhmg.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 17 18:41:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFSCA-0002nW-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 18:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbaBQRlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 12:41:17 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:52764 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbaBQRlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 12:41:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id EFECB4D65D8;
	Mon, 17 Feb 2014 18:41:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oRN10kYqameg; Mon, 17 Feb 2014 18:41:14 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (84-73-49-17.dclient.hispeed.ch [84.73.49.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D996F4D64BD;
	Mon, 17 Feb 2014 18:41:13 +0100 (CET)
In-Reply-To: <8761oeuhmg.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Mon, 17 Feb 2014 12:02:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242265>

David Kastrup <dak@gnu.org> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> When comparing two branches, decorating the flat diff with the
>>> respectively responsible commits seems like it would be nice to do/have
>>> (the blame on the identical parts, in contrast, is not really
>>> interesting).  Is there any tool that provides something like that?
>>
>> This seems to come up every year or so:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/110369/focus=110383
>
> Nice.  That one could likely be sped up by calling git-blame just once
> on each file with multiple -L options.

Yes.  You'll note that the email predates the support for multiple -L
options by a few years :-)

I never had a need for such a script, I just wrote that in response to
someone asking about it.  If you find it useful, please clean it up for
inclusion in contrib/.

-- 
Thomas Rast
tr@thomasrast.ch
