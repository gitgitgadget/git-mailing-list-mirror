From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fsck: return non-zero status on missing ref tips
Date: Mon, 15 Sep 2014 16:42:26 +0200
Message-ID: <5416FAD2.5020002@alum.mit.edu>
References: <1409177412.15185.3.camel@leckie> <20140829185325.GC29456@peff.net> <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com> <1409343480.19256.2.camel@leckie> <20140829203145.GA510@peff.net> <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com> <20140909220709.GA14029@peff.net> <20140912033830.GA5507@peff.net> <20140912042939.GA5968@peff.net> <CAPc5daXMMpqtH=DwLLXgHXVfHThN5MfHwn6dPK6OaZvAQGXT_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 16:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTXbC-00012u-87
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 16:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbaIOOtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 10:49:45 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43405 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751847AbaIOOta (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 10:49:30 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Sep 2014 10:49:30 EDT
X-AuditID: 12074412-f792e6d000005517-83-5416fad414f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.A6.21783.4DAF6145; Mon, 15 Sep 2014 10:42:28 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2598.dip0.t-ipconnect.de [93.219.37.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8FEgQSG018431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 15 Sep 2014 10:42:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <CAPc5daXMMpqtH=DwLLXgHXVfHThN5MfHwn6dPK6OaZvAQGXT_Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqHvll1iIwYaTOhbzN51gtOi60s1k
	0dB7hdniR0sPswOLx7PePYweFy8peyx4fp/d4/MmuQCWKG6bpMSSsuDM9Dx9uwTujEtfOpkK
	7olU7D7E1cC4V6CLkZNDQsBEouPRXmYIW0ziwr31bF2MXBxCApcZJR7/mssC4Zxnkrjdd5IJ
	pIpXQFtiyqnd7CA2i4CqxLaNp9hAbDYBXYlFPc1gNaICARIfOh8wQtQLSpyc+YQFxBYRcJQ4
	8eA6K4jNLBAjsW7qMrDNwgKuEhfXfGSGWDabWWLto1lgCzgFAiWePp3PCNGgLvFn3iVmCFte
	onnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNK
	NzFCAlpoB+P6k3KHGAU4GJV4eAv6xEKEWBPLiitzDzFKcjApifLO/QoU4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMJbux8ox5uSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wSvyE6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDtlQJp5y0u
	SMwFikK0nmLU5VjX+a2fSYglLz8vVUqcd9EPoCIBkKKM0jy4FbD09YpRHOhjYV4jkFE8wNQH
	N+kV0BImoCVne8CWlCQipKQaGDVtuK3NX814mbQoedLbLdEFtxlkvXUazhxgX/xv0aNv21gv
	2H9dMNcg3uA/c+uiA53Pz+7t+esTXZJy4/bFg20bhb4UreuMXvckVpPj6+Kg1Tsm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257051>

On 09/12/2014 06:58 AM, Junio C Hamano wrote:
> On Thu, Sep 11, 2014 at 9:29 PM, Jeff King <peff@peff.net> wrote:
>> [+cc mhagger for packed-refs wisdom]
>>
>> If we only have a packed copy of "refs/heads/master" and it is broken,
>> then deleting any _other_ unrelated ref will cause refs/heads/master to
>> be dropped from the packed-refs file entirely. We get an error message,
>> but that's easy to miss, and the pointer to master's sha1 is lost
>> forever.
> 
> Hmph, and the significance of losing a random 20-byte object name that
> is useless in your repository is? You could of course ask around other
> repositories (i.e. your origin, others that fork from the same origin,
> etc.), and having the name might make it easier to locate the exact
> object.
> 
> But in such a case, either they have it at the tip (in which case you
> can just fetch the branch you lost), or they have it reachable from
> one of their tips of branches you had shown interest in (that is why
> you had that lost object in the first place). Either way, you would be
> running "git fetch" or asking them to send "git bundle" output to be
> unbundled at your end, and the way you ask would be by refname, not
> the object name, so I am not sure if the loss is that grave.
> 
> Perhaps I am missing something, of course, though.

I don't understand your argument.

First, you would not just lose the SHA-1 of the object. You would also
lose the name of the reference that was previously pointing at it.

Second, the discarded information *is* useful. The more information you
have, the more likely you can restore it and/or diagnose the original
cause of the corruption.

Third, even if the discarded information were not useful, the fact that
*information has gone missing* is of overwhelming importance, and that
fact would be forgotten as soon as the warning message scrolls off of
your terminal. The reference deletion that triggered the warning might
even have been done in the background by some other process (e.g., a
GUI) and the output discarded or shunted into some "debug" window that
the user would have no reason to look at.

So I agree with Peff that it would be prudent to preserve the corrupt
reference at least until the next "git fsck", which (a) is run by the
user specifically to look for corruption, and (b) can return an error
result to make the failure obvious.

The only thing that is unclear to me is whether the user would be able
to get rid of the broken reference once it is discovered (short of
opening packed-refs in an editor).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
