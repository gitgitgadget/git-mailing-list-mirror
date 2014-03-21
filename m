From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Fri, 21 Mar 2014 22:13:45 +0100
Message-ID: <532CAB89.7030303@alum.mit.edu>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <loom.20140318T124348-742@post.gmane.org> <lg9l22$qto$1@ger.gmane.org> <CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com> <lgekju$u6t$1@ger.gmane.org> <CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com> <xmqqr45vv5q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Aleksey Mokhovikov <moxobukob@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6lF-0001jo-VT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbaCUVNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:13:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47096 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbaCUVNt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 17:13:49 -0400
X-AuditID: 1207440c-f79656d000003eba-b4-532cab8cabce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B2.D7.16058.C8BAC235; Fri, 21 Mar 2014 17:13:48 -0400 (EDT)
Received: from [192.168.69.148] (p57A25836.dip0.t-ipconnect.de [87.162.88.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2LLDjsr003847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Mar 2014 17:13:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqr45vv5q8.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqNuzWifYYMcKUYuuK91MFg29V5gt
	Lq+ayWZx5k0jowOLx85Zd9k9Ll5S9lj8wMvj8ya5AJYobpukxJKy4Mz0PH27BO6MW02PWQrm
	cVXcXPuQpYFxCUcXIyeHhICJxMonE5ggbDGJC/fWs3UxcnEICVxmlFi1ey0rhHOOSeLN13+M
	IFW8AtoSTcuvsIPYLAKqEkc/3AGLswnoSizqaQabJCoQLLH68gMWiHpBiZMzn4DZIgJqEhPb
	DrGADGUWaGeUaNjVBTZIWKBa4sSu+VDbHjBJLD/7FmwSp4C1xISmK0AdHED3iUv0NAaBhJkF
	dCTe9T1ghrDlJba/ncM8gVFwFpJ9s5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqR
	rqFebmaJXmpK6SZGSKDz7GD8tk7mEKMAB6MSD28Fp3awEGtiWXFl7iFGSQ4mJVHe0GU6wUJ8
	SfkplRmJxRnxRaU5qcWHGCU4mJVEeANBcrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2amp
	BalFMFkZDg4lCd7iVUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAoji8GxjFI
	igdob8EKkL3FBYm5QFGI1lOMuhwbtq1pZBJiycvPS5US59UB2SEAUpRRmge3ApbWXjGKA30s
	zJsIUsUDTIlwk14BLWECWsI/VQtkSUkiQkqqgXFh4Lwlz4v3zSs9LepdIN9rxHbIlL0xYt37
	W7/iXkpasG6R/V9vGX6riX9h+OEP8pVf7j482SKxRdvVcdmh874cEwoerFx/Zs+O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244749>

On 03/21/2014 06:09 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> Sorry, you're right about message[0] case not being a crasher (though
>> the assert() still seems overkill).
> 
> Assert() often becomes no-op in production build.  I think this may
> be an indication that "table-driven" may not be as good an approach
> as many candidates thought.  The microproject suggestion asks them
> to think _if_ that makes sense, and it is perfectly fine for them if
> they answer "no, it introduces more problems than it solves".

My expectation when I invented that microproject was that converting the
code to be table-driven would be judged *not* to be an improvement.  I
was hoping that a student would say "the 'if' statement is OK, but let's
delete this ridiculous unreachable else branch".  Possibly they would
convert the "if" chain into nested "if"s, which I think would allow some
code consolidation in one of the branches.

But not a single student agreed with me, so I must be in a minority of
one (which, unfortunately, is the definition of lunacy).

The multidimensional array lookup table is not so terrible, but I
personally still prefer the "if".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
