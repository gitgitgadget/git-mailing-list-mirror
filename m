From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: [RFC/FR] Should "git checkout (-B|-b) branch master...branch"
 work?
Date: Fri, 21 Dec 2012 20:43:24 +0100
Message-ID: <50D4BBDC.6030700@alum.mit.edu>
References: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org> <CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com> <CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com> <7vr4mj1g8j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 20:43:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm8VY-0001nz-6t
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 20:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab2LUTnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 14:43:31 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:60246 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748Ab2LUTn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 14:43:29 -0500
X-AuditID: 1207440e-b7f116d0000008ae-8d-50d4bbe0911b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F1.3F.02222.0EBB4D05; Fri, 21 Dec 2012 14:43:28 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBLJhO9F027604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 14:43:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vr4mj1g8j.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPtg95UAg75FShZdV7qZLBp6rzBb
	dH5sY3Fg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfMOr6HraCJr+LyuS6mBsYe
	7i5GDg4JAROJg+8cuhg5gUwxiQv31rN1MXJxCAlcZpQ49/E4I4RznEli6r41jCBVvALaEqte
	HmYHsVkEVCVO939mArHZBHQlFvU0g9miAgESi5ecY4eoF5Q4OfMJC4gtIqAmMbHtEJjNLOAq
	ceXOUmaQI4QFwiUubXYFCQsJvGSUaPiZBRLmFDCT6N4mBFGtI/Gu7wEzhC0vsf3tHOYJjAKz
	kCyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCwpZvB2P7
	eplDjAIcjEo8vJeargQIsSaWFVfmHmKU5GBSEuVdvgUoxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYTXfx5QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbtwF1CjYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChK44uBcQqS4gHa2w3SzltckJgLFIVoPcWo
	y3Gr4eZTRiGWvPy8VClx3iaQIgGQoozSPLgVsCT1ilEc6GNh3q0gVTzABAc36RXQEiagJSJK
	YEtKEhFSUg2M9mYzN3at564xcPO5+lbi5c3Ygq/86yf8FrBl7HbLPdmiuXy9+6yz59ou/n55
	PaVpxdV7jpdb+FrXMb+o9r8Zc+hPnbW50IY7TyYtScvxOfixj3GBcC6Dzeczq450 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212007>

On 12/21/2012 06:12 PM, Junio C Hamano wrote:
> "diff" is always about two endpoints, not the path that connects
> these two endpoints (aka "range"), and when you want to "diff"
> between two commits, you say "diff A B".  "A..B" happens to be
> accepted as such only by accident (e.g. the old command line parser
> did not have a reliable way to tell "^A B" and "A..B" apart), not by
> design.
> 
>     side note: incidentally, now we have rev_cmdline_info support,
>     we could start deprecating "diff A..B" syntax.

I often find myself using "git diff A..B" syntax when using the command
line history because the previous command used "A..B"; e.g.,

    git log A..B
    git diff A..B

It's quick to recall the previous command, edit "log" -> "diff", and
press enter; having to remove the dots would require a few extra keypresses.

> Actually, in many places where the command line parser knows it
> wants a single point, and never a range, we should be able to apply
> the "A...B as a notation to specify a single point" rule.  
> 
> Of course you could come up with a symbol other than "..." for that
> purpose, and migrate the current "git checkout A...B" special case
> to use that other symbol, but that would be more work and also you
> would need to retrain existing users.

OTOH making A...B sometimes mean a range and sometimes a merge-base
(depending on context) adds a confusing non-uniformity, and also has the
disadvantage of making merge-base shorthand unavailable in contexts that
allow a range.

OTOOH git already has so many notations that can be used on the command
line; inventing yet another one would make it that much more overwhelming.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
