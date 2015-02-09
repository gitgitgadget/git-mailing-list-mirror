From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/11] Allow reference values to be checked in a transaction
Date: Mon, 09 Feb 2015 21:40:04 +0100
Message-ID: <54D91B24.5050808@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>	<xmqqtwyvapx7.fsf@gitster.dls.corp.google.com> <CAGZ79kZmwk5=ViPdRVd+0ncMyAhGAbid6TJUznvMuK6pQ_VSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKv7w-0005Cb-62
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760733AbbBIUkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:40:09 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62441 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760683AbbBIUkI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 15:40:08 -0500
X-AuditID: 12074413-f79f26d0000030e7-22-54d91b27d22a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.47.12519.72B19D45; Mon,  9 Feb 2015 15:40:07 -0500 (EST)
Received: from [192.168.69.130] (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t19Ke4Nu027186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 15:40:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kZmwk5=ViPdRVd+0ncMyAhGAbid6TJUznvMuK6pQ_VSRw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqKsufTPEYNJ5NouuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZ2ydvp+94IJwReeJxAbGz/xdjJwcEgImEpf3LGCHsMUkLtxbz9bFyMUhJHCZUWLR9e2M
	EM55JokfXzazgFTxCmhLvF9zhxnEZhFQlVhzdSdYN5uArsSinmYmEFtUIEji0OnHUPWCEidn
	PgGzRQS8JE6tm8EMMpRZ4BajxI+Ol0DNHBzCAgESOx8UgdQICexglNjcHwBicwoESjx5fQ9s
	PrOAusSfeZeYIWx5ieats5knMArMQrJiFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszL
	Sy3SNdfLzSzRS00p3cQICXDhHYy7TsodYhTgYFTi4a34eD1EiDWxrLgy9xCjJAeTkiivhcTN
	ECG+pPyUyozE4oz4otKc1OJDjBIczEoivD/O3AgR4k1JrKxKLcqHSUlzsCiJ86otUfcTEkhP
	LEnNTk0tSC2CycpwcChJ8GZLAQ0VLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0Vq
	fDEwVkFSPEB7c0DaeYsLEnOBohCtpxgVpcQh5gqAJDJK8+DGwtLWK0ZxoC+FeVdLAlXxAFMe
	XPcroMFMQIMLCkAeKi5JREhJNTBynm4VTz6wZ4L9bJvP3NNLhX9+SPT8f35ST7fk9NVeojv2
	SOs39ug4Wm//venoucUht56uVL6X2rCwrnbLovoXn+4s5lx+YpPhPvXNq+0YPJNu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263590>

On 02/09/2015 08:05 PM, Stefan Beller wrote:
> On Mon, Feb 9, 2015 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> [...]
>>> This patch series applies on top of master merged together with
>>> sb/atomic-push, which in turn depends on mh/reflog-expire.
>>
>> I am a bit puzzled by your intentions, so help me out.
>>
>> I see that your understanding is that Stefan will be rerolling the
>> push atomicity thing; wouldn't we then want to have a "fix and
>> clean" topic like this one first and build the push atomicity thing
>> on top instead?
> 
> My understanding is to not reroll origin/sb/atomic-push, but
> origin/sb/atomic-push-fix (which is worded misleading. It is not about
> atomic pushes, but about enabling large transactions in my understanding)

Yes, that is what I thought.

>> In other words, would it make sense to extend mh/reflog-expire (in
>> 'next') topic with commits from "Fix some problems with reflog
>> expiration (8 patches)" series and this series to fix and clean it?

Both series have to do with reflogs, but they are logically pretty
independent. In particular, "Fix some problems with reflog expiration"
fixes problems that existed before mh/reflog-expire. And considering
that one topic is quite mature whereas the the other is just making its
debut, it seemed like yoking them together would slow down the first
topic for no good reason.

> I am not sure what advantages this would bring. A better history
> for bisection? I cannot speak for Michael, but my understanding was
> to have mh/reflog-expire and sb/atomic-push-fix merged now that 2.3
> is out and everything else on top is unclear/rerolled/discussed as needed.

Stefan, I think you mean sb/atomic-push, not sb/atomic-push-fix, right?

>> We may even want to rebase/reroll mh/reflog-expire on top of v2.3
>> while doing so to adjust to the transaction stuff, if that makes
>> some of the changes in the two new series unnecessary (if these "fix
>> and clean up" changes made in mh/reflog-expire in 'next', that is).

I see all of these topics as pretty independent, though given that they
touch similar areas of the code they often have annoying (but small)
conflicts with each other.

I expected that mh/reflog-expire and sb/atomic-push would be merged
pretty early in the 2.4 cycle (they are both in next already). Junio, is
that not your plan?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
