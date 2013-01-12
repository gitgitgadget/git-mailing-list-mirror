From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] t/lib-cvs: cvsimport no longer works without Python >=
 2.7
Date: Sat, 12 Jan 2013 16:27:36 +0100
Message-ID: <50F180E8.8010907@alum.mit.edu>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com> <7v62339du4.fsf@alter.siamese.dyndns.org> <7vip72iykx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:28:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu305-0002bH-FW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 16:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab3ALP1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 10:27:41 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:61344 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753513Ab3ALP1k (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 10:27:40 -0500
X-AuditID: 1207440d-b7f306d0000008b7-b9-50f180ebba5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 25.E8.02231.BE081F05; Sat, 12 Jan 2013 10:27:39 -0500 (EST)
Received: from [192.168.69.140] (p57A24728.dip.t-dialin.net [87.162.71.40])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0CFRbDp004109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jan 2013 10:27:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vip72iykx.fsf_-_@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqPu64WOAwacmIYurW3wsuq50M1k0
	9F5hdmD2uHhJ2WPZ104Wj8+b5AKYo7htkhJLyoIz0/P07RK4M6Ye2slYcJWn4snpr+wNjJO4
	uhg5OSQETCR69s1hg7DFJC7cWw9kc3EICVxmlFjQdZsJwjnNJHF/6iywKl4BbYlzr++wgtgs
	AqoS968eA7PZBHQlFvU0M4HYogIBEouXnGOHqBeUODnzCQuILSKgJjGx7RCYzSxgI/GsvQHI
	5uAQFgiU6JxUBrFrBqPEnGXrwOZwClhKvJm5jRWiXkfiXd8DZghbXmL72znMExgFZiFZMQtJ
	2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihIQu7w7G/+tkDjEK
	cDAq8fCeCvgQIMSaWFZcmXuIUZKDSUmUt6nuY4AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4f
	JUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE74Z6oEbBotT01Iq0
	zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7T3Pkg7b3FBYi5QFKL1FKMux/bf
	7c8ZhVjy8vNSpcR5L4MUCYAUZZTmwa2AJapXjOJAHwvz7gSp4gEmObhJr4CWMAEtOXvhPciS
	kkSElFQDo56Q/q/7FWczYxoO8T/Kk/nLPVXe0zT/w56M92za/Vu2GX9Y5C30YYJOvuC28EU+
	p0//47cy9LR15WKI1znF9E8xLezDueefjnzmdrhYrGHKL2FmmvlKw0RotpazzvFy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213288>

I have the feeling I'm only seeing one side of this conversation...

On 01/12/2013 09:40 AM, Junio C Hamano wrote:
> The new cvsimport requires at least Python 2.7 to work; do not fail
> the cvsimport tests on platforms without one.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Junio C Hamano <gitster@pobox.com> writes:
> 
>  > http://docs.python.org/2/library/subprocess.html tells me that
>  > check_output has first become available in 2.7.
>  >
>  > So... does this mean that we now set the minimum required version of
>  > Python to 2.7?  I dunno.

It would be unfortunate to set the minimum Python version to 2.7 if "git
cvsimport" is considered an integral part of git.

>  Even if we were to rip out the fallback code that uses the 2.7-only
>  subprocess.check_output() on "cvsps -V", the function is also used
>  for doing the real work interacting with cvsps-3.x, so I think this
>  patch will be necessary.  Unless new cvsimport is tweaked not to
>  use the method, that is.
> 
>  A suggestion for a better alternative is of course very much
>  appreciated.

If the only reason to require Python 2.7 is subprocess.check_output(),
it would be easy to reimplement it (it is only 12 lines of
straightforward code, plus a few lines to define the exception type
CalledProcessError).  According to [1], the Python license is
GPL-compatible; therefore these lines could even be copied into
git-cvsimport.

Michael

[1] http://www.gnu.org/licenses/license-list.html#Python

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
