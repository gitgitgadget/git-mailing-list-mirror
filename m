From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 00/39] Lockfile correctness and refactoring
Date: Tue, 30 Sep 2014 11:55:57 +0200
Message-ID: <542A7E2D.6030305@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu> <xmqqwq8q8hsa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershaus?= =?windows-1252?Q?en?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 11:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYuAN-0004rc-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 11:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaI3J4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 05:56:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46206 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978AbaI3J4P (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 05:56:15 -0400
X-AuditID: 1207440d-f797f6d000000a4a-9c-542a7e311004
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.CD.02634.13E7A245; Tue, 30 Sep 2014 05:56:01 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741E.dip0.t-ipconnect.de [79.201.116.30])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8U9tvSO025561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 30 Sep 2014 05:55:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqwq8q8hsa.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqGtYpxViMGmGkEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBnPNhxgrWgka/iwNf5TA2ME7i7GDk5JARMJFb/WskK
	YYtJXLi3nq2LkYtDSOAyo8STb58YIZzzTBJft3xlBqniFdCWeHeyB6yDRUBVounUTkYQm01A
	V2JRTzMTiC0qECDxofMBI0S9oMTJmU9YQGwRATWJiW2HWECGMgt0Mklsa3rLBpIQFnCSePZy
	KlizkECxxP1fD9lBbE4Ba4ldrZvBapgF9CR2XP/FCmHLSzRvnc08gVFgFpIds5CUzUJStoCR
	eRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSCzw7mD8v07mEKMAB6MSD2+C
	olaIEGtiWXFl7iFGSQ4mJVHeXwVAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8PFlAOd6UxMqq
	1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/nGqBGwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFC0xhcD4xUkxQO0N7oWZG9xQWIuUBSi9RSjLse6zm/9TEIsefl5
	qVLivA4gRQIgRRmleXArYInvFaM40MfCvDYgVTzApAk36RXQEiagJWkb1EGWlCQipKQaGIuW
	T3GdNPdVu4GA4Nc/94zct0Sl9rCoee6ukGj3ip20yMW/PnQCS4B2h1LiRfuPlyX4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257663>

On 09/26/2014 06:31 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> * Rebase to current master.
> 
> When you say this, could you be a bit more descriptive?  Has the
> series updated to use something new that appeared on 'master' since
> the last series was posted and needed to be rebased?  Or did you
> just made sure that the series applied on top of the current master
> still works, even though you have been running "rebase -i" on the
> same fork point since the previous round?
> 
> If the former, naming what it now uses i.e. "rebased to current
> master, to redo PATCH x,y,z using the new X recently graduated"
> would be helpful.
> 
> If the latter, well, not rebasing is preferrable if the changes are
> still viable on the previous fork point, to be absolutely honest.

I have always routinely rebased my series to the current master each
time I reroll them. I thought that was helpful. Thanks for the info that
you prefer that I not do it. In the future I will only rebase to master
if I see that there would be nontrivial conflicts or if I would like to
take advantage of something that has graduated.

I've always tried to mention when the rebases were nontrivial. In this
case it was unproblematic.


As an aside, I've always found it wishy-washy to talk about "current
master" and "fork points" and stuff when (AFAIK) format-patch-generated
emails don't mention the fork point. So unless my cover letter specifies
the fork point as an unambiguous commit name, there is no basis *anyway*
to expect that you will apply the patch series in the same context that
I developed it.

Another victim of the format-patch information shredder :-(

Cheers,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
