From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Fri, 21 Mar 2014 22:45:57 +0100
Message-ID: <532CB315.50607@alum.mit.edu>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <loom.20140318T124348-742@post.gmane.org> <lg9l22$qto$1@ger.gmane.org> <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com> <lgekju$u6t$1@ger.gmane.org> <CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com> <xmqqr45vv5q8.fsf@gitster.dls.corp.google.com> <532CAB89.7030303@alum.mit.edu> <CAPig+cSYieZRA-kx0PUnrLjG5E6LYi_qOFqnZiE09wqeCvN3oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksey Mokhovikov <moxobukob@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR7GX-00051p-3S
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaCUVqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:46:08 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50663 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750881AbaCUVqC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 17:46:02 -0400
X-AuditID: 1207440e-f79c76d000003e2c-3c-532cb318dfa7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 59.B0.15916.813BC235; Fri, 21 Mar 2014 17:46:01 -0400 (EDT)
Received: from [192.168.69.148] (p57A25836.dip0.t-ipconnect.de [87.162.88.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2LLjwTA005434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Mar 2014 17:45:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAPig+cSYieZRA-kx0PUnrLjG5E6LYi_qOFqnZiE09wqeCvN3oA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqCu5WSfYYP42JouuK91MFg29V5gt
	Lq+ayWZx5k0jowOLx85Zd9k9Ll5S9lj8wMvj8ya5AJYobpukxJKy4Mz0PH27BO6Mk3O62Qou
	8FS0ne5hb2Ccx9XFyMEhIWAisf9mXhcjJ5ApJnHh3nq2LkYuDiGBy4wS32auYgNJCAmcY5L4
	tV8TxOYV0JRYuuImC4jNIqAqceXeBHYQm01AV2JRTzMTiC0qECyx+vIDFoh6QYmTM5+A2SIC
	2hIfNmxiBFnALNDEKPH52wuwhLBAtcSJXfNZITYfZZZYfaEHLMEpECixr+UIC8Sl4hI9jUEg
	YWYBHYl3fQ+YIWx5ie1v5zBPYBSchWTfLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiX
	l1qka6yXm1mil5pSuokREuR8Oxjb18scYhTgYFTi4a3g1A4WYk0sK67MPcQoycGkJMrbu0kn
	WIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb+AyoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJ
	anZqakFqEUxWhoNDSYLXAWSoYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCiC44uB
	MQyS4gHa6wvSzltckJgLFIVoPcWoy7Fh25pGJiGWvPy8VClx3qUgRQIgRRmleXArYCntFaM4
	0MfCvMogVTzAdAg36RXQEiagJfxTtUCWlCQipKQaGHX3vBIP+Fy/2qYktv7Sx6PX38y2Ypp/
	/qS7+NPPXI0GFV7zC2fNz3W2Ofdzf9rX/BVHdGfpCU9vO3f29ueUIvOap4GrGTd6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244756>

On 03/21/2014 10:33 PM, Eric Sunshine wrote:
> On Fri, Mar 21, 2014 at 5:13 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 03/21/2014 06:09 PM, Junio C Hamano wrote:
>>> Assert() often becomes no-op in production build.  I think this may
>>> be an indication that "table-driven" may not be as good an approach
>>> as many candidates thought.  The microproject suggestion asks them
>>> to think _if_ that makes sense, and it is perfectly fine for them if
>>> they answer "no, it introduces more problems than it solves".
>>
>> My expectation when I invented that microproject was that converting the
>> code to be table-driven would be judged *not* to be an improvement.  I
>> was hoping that a student would say "the 'if' statement is OK, but let's
>> delete this ridiculous unreachable else branch".  Possibly they would
>> convert the "if" chain into nested "if"s, which I think would allow some
>> code consolidation in one of the branches.
>>
>> But not a single student agreed with me, so I must be in a minority of
>> one (which, unfortunately, is the definition of lunacy).
> 
> Adam NoLastName did stick with the 'if' statements and removed the
> unreachable branch  [1], although he didn't say if he had considered
> the table-driven approach and discarded it.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/243704

Thanks for correcting my oversight.

So...there's still hope for my sanity after all :-)  Adam must have
tasted from the tree of wisdom :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
