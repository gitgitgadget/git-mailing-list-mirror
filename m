From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration
 variables
Date: Sun, 01 Feb 2015 06:12:38 +0100
Message-ID: <54CDB5C6.3020702@alum.mit.edu>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com> <1422484393-4414-1-git-send-email-gitster@pobox.com> <1422484393-4414-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 06:19:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHmws-0006fB-T7
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 06:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbbBAFTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 00:19:50 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60580 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbbBAFTt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Feb 2015 00:19:49 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Feb 2015 00:19:48 EST
X-AuditID: 12074413-f79f26d0000030e7-63-54cdb5c90ecb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CB.93.12519.9C5BDC45; Sun,  1 Feb 2015 00:12:41 -0500 (EST)
Received: from [192.168.69.130] (p4FC97074.dip0.t-ipconnect.de [79.201.112.116])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t115Cd6U005773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 1 Feb 2015 00:12:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1422484393-4414-4-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqHty69kQg6k7ZSy6rnQzWTT0XmG2
	6F/exebA7PHhY5zHxUvKHp83yQUwR3HbJCWWlAVnpufp2yVwZ+x/tYi94KFSxZH5u9kaGGdK
	dzFyckgImEgcWn6VEcIWk7hwbz1bFyMXh5DAZUaJe9cWsEA455kkPndvZwWp4hXQlui8OZkF
	xGYRUJWYfOkPE4jNJqArsainGcwWFQiSuNKymRmiXlDi5MwnYPUiAtYSv39+B6thBtr85MZu
	sLiwQJzEtncvoDYvYZSY3LEb7CROAUeJafc3sUI06EnsuP4LypaXaN46m3kCo8AsJDtmISmb
	haRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ4BXewbjrpNwhRgEO
	RiUe3g6NsyFCrIllxZW5hxglOZiURHkZsoFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjz1IFy
	vCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXpstQI2CRanpqRVpmTkl
	CGkmDk6Q4VxSIsWpeSmpRYmlJRnxoGiNLwbGK0iKB2hvL0g7b3FBYi5QFKL1FKOilDhvCkhC
	ACSRUZoHNxaWkl4xigN9KQzRzgNMZ3Ddr4AGMwENXjbpDMjgkkSElFQDo1yzmd2Hkl1vjkau
	q7m3c92qp9ctinIXlM3R3S6lvZHz3/SeuOu9zdnurW1Sh9es6P7iNT/pzw77P60adxas+/I+
	9UzUvbXXDr+XUDP5F1Z56l/yj8iFU6//Fg0//XSxl72K28riPu5/Nl9C+ZdnVv7R 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263232>

On 01/28/2015 11:33 PM, Junio C Hamano wrote:
> We may want to say something about command line option names in the
> new section as well, but for now, let's make sure everybody is clear
> on how to structure and name their configuration variables.
> 
> The text for the rules are partly taken from the log message of
> Jonathan's 6b3020a2 (add: introduce add.ignoreerrors synonym for
> add.ignore-errors, 2010-12-01).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 894546d..8fbac15 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -413,6 +413,31 @@ Error Messages
>   - Say what the error is first ("cannot open %s", not "%s: cannot open")
>  
>  
> +Externally Visible Names
> +
> + - For configuration variable names, follow the existing convention:
> +
> +   . The section name indicates the affected subsystem.
> +
> +   . The subsection name, if any, indicates which of an unbounded set
> +     of things to set the value for.
> +
> +   . The variable name describes the effect of tweaking this knob.
> +
> +   The section and variable names that consist of multiple words are
> +   formed by concatenating the words without punctuations (e.g. `-`),
> +   and are broken using bumpyCaps in documentation as a hint to the
> +   reader.
> +
> +   When choosing the variable namespace, do not use variable name for
> +   specifying possibly unbounded set of things, most notably anything
> +   an end user can freely come up with (e.g. branch names), but also
> +   large fixed set defined by the system that can grow over time
> +   (e.g. what kind of common whitespace problems to notice).

I think we can all agree with this rule for "anything an end user can
freely come up with". Such sets are truly unbounded.

But what is the justification for applying it to "large fixed set
defined by the system that can grow over time"? Any set of items that
needs to be programmed one by one is not unbounded in the same sense. It
is true that it can grow over time, but there is a practical limit on
how many such options we would ever implement, and at any given time the
set has a well-defined, finite number of members.

I suppose that this is a reaction to Johannes's proposal [1] to add
configuration settings like

    git config fsck.badDate ignore

[2] which you didn't like [3] but I did [4]. (Did you miss [4], in which
I think I made some good arguments for Johannes's proposal? I don't
think you responded to it.)

I think it would be more productive to finish the concrete discussion
about the "fsck" proposal, and to use the insight gained in that
specific case to inform the decision about whether we need the new
general rule to cover "large fixed set[s] defined by the system".

> + [...] Use
> +   subsection names or variable values, like existing variables
> +   branch.<name>.description and core.whitespace do, instead.

But there is also a precedent for the opposite approach: "advice.*".

    [advice]
            pushUpdateRejected = true|false
            pushNonFFCurrent   = true|false
            statusHints        = true|false
            resolveConflict    = true|false

etc.

In fact, I would argue that

    [core]
            whitespace = blank-at-eol -indent-with-non-tab

is a bad model to follow, and would better have been expressed in a
style like

    [whitespace]
            blankAtEOL = warn
            indentWithNonTab = ignore

for the same reasons that I argued for "fsck.*". The latter style would
also have made it easier to add other choices like
"whitespace.spaceBeforeTab = error". Not that I am advocating that
particular enhancement; I am just giving an example of how the current
style of configuration is less flexible.

> [...]

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/261068
[2] Actually, the original proposal was for "fsck.bad-date", but I think
we agree that "fsck.badDate" would be the correct version of this proposal.
[3] http://article.gmane.org/gmane.comp.version-control.git/261738
[4] http://article.gmane.org/gmane.comp.version-control.git/262841

-- 
Michael Haggerty
mhagger@alum.mit.edu
