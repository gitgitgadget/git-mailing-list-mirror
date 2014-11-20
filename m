From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Thu, 20 Nov 2014 11:56:41 +0100
Message-ID: <546DC8E9.6090504@alum.mit.edu>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>	<546B2CE0.6020208@alum.mit.edu>	<CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>	<546BA21C.9030803@alum.mit.edu>	<xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>	<546BB722.5020901@alum.mit.edu>	<xmqqsihgtcyx.fsf@gitster.dls.corp.google.com> <CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:56:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrPQ3-0004Eo-FF
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 11:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbaKTK4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 05:56:55 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46751 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780AbaKTK4x (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 05:56:53 -0500
X-AuditID: 12074413-f79f26d0000030e7-76-546dc8ec3578
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 62.3D.12519.CE8CD645; Thu, 20 Nov 2014 05:56:45 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3256.dip0.t-ipconnect.de [93.219.50.86])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAKAugYt028870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Nov 2014 05:56:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqPv2RG6Iwf9Ei64r3UwWDb1XmC3+
	Taix2Ly5ncWBxWPBplKPi5eUPT5vkgtgjuK2SUosKQvOTM/Tt0vgznhy9ihzwV/FihenNrI0
	MK6X7mLk5JAQMJGYOmkDM4QtJnHh3nq2LkYuDiGBy4wSm6ceY4FwzjFJzD7YDVbFK6Atsfnm
	VTCbRUBVYsmE+YwgNpuArsSinmYmEFtUIEji5J7r7BD1ghInZz5hAbFFBLwkTq2bAdbLLBAv
	8ej5WaBtHBzCAqYSzdsZIXZ1MkssnXUDbA6nQKDEyr5lrBD16hJ/5l2C6pWXaN46m3kCo8As
	JCtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQABbewbjr
	pNwhRgEORiUe3gSL3BAh1sSy4srcQ4ySHExKorz3lgOF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifBq7ATK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeC8fB2oULEpN
	T61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VqfDEwWkFSPEB7f4K08xYXJOYCRSFaTzEq
	SonzCgITi5AASCKjNA9uLCwtvWIUB/pSmPc9SDsPMKXBdb8CGswENPjvUrDBJYkIKakGRpG4
	i9s+/TXcGV99JuFPxiz/iL3qjHMeTeDL5P2pWFGzNfOki1DKidtbcha2PFfyZmv0eX3B33lG
	5DzeiAN/lGXXvsxMqmCaEjGT6/010f7U8quXH7NkH+3+wPTtKVu/WODOjxr23Z8v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2014 12:22 AM, Stefan Beller wrote:
> Sorry for the long delay.
> Thanks for the explanation and discussion.
> 
> So do I understand it right, that you are not opposing
> the introduction of "everything should go through transactions"
> but rather the detail and abstraction level of the API?

Correct.

> So starting from Michaels proposal in the first response:
> 
> 1. Add a reflog entry when a reference is updated in a transaction.
> 
> ok
> 
> 2. Rename a reflog file when the corresponding reference is renamed.
> 
> This should happen within the same transaction as the reference is
> renamed, right?

Yes. Maybe there should be a "rename reference" operation that can be
added to a transaction, and it simply knows to rename any associated
reflogs. Then the calling code wouldn't have to worry about reflogs
explicitly in this case at all.

> So we don't have a multistep process here, which may abort in between having the
> reference updated and a broken reflog or vice versa. We want to either
> have both
> the ref and the reflog updated or neither.

Yes.

> 3. Delete the reflog when the corresponding reference is deleted [1].
> 
> also as one transaction?

It would be a side-effect of committing a transaction that contains a
reference deletion. The deletion of the reflog would be done at the same
time that the rest of the transaction is committed, and again the
calling code wouldn't have to explicitly worry about the reflogs.

> 4. Configure a reference to be reflogged.
> 5. Configure a reference to not be reflogged anymore and delete any
>    existing reflog.
> 
> Why do we need 4 and 5 here? Wouldn't all refs be reflog by default and
> why do I want to exclude some?
> 
> 6. Selectively expire old reflog entries, e.g., based on their age.
> 
> This is the maintenance operation, which you were talking about.
> In my vision, this also should go into one transaction. So you have the
> business logic figuring out all the changes ("drop reflog entry a b and d")
> and within one transaction we can perform all of the changes.

But if we take the approach described above, AFAICT this operation is
the only one that would require the caller to manipulate reflog entries
explicitly. And it has to iterate through the old reflog entries, decide
which ones to keep, possibly change its neighbors to eliminate gaps in
the chain, then stuff each of the reflog entries into a transaction one
by one. To allow this to be implemented on the caller side, the
transaction API has to be complicated in the following ways:

* Add a transaction_update_type (UPDATE_SHA1 vs. UPDATE_LOG).
* Add reflog_fd, reflog_lock, and committer members to struct ref_update.
* New function transaction_update_reflog().
* A new flag REFLOG_TRUNCATE that allows the reflog file to be truncated
before writing.
* Machinery that recognizes that a transaction contains multiple reflog
updates for the same reference and processes them specially to avoid
locking and rewriting the reflog file multiple times.

So this design has the caller serializing all reflog entries into
separate ref_update structs (which implies that they are held in RAM!)
only for ref_transaction_commit() to scan through all ref_updates
looking for reflog updates that go together so that they can be
processed as a whole. In other words, the caller picks the reflog apart
and then ref_transaction_commit() glues it back together. It's all very
contrived.

I suggest that the caller only be responsible for deciding which reflog
entries to keep (by supplying a callback function), and a new
expire_reflogs_for_me_please() API function be responsible for taking
out a lock, feeding the old reflog entries to the callback, expiring the
unwanted entries, optionally eliminating gaps in the chain (for the use
of "reflog [expire|delete] --rewrite"), writing the new reflog entries,
and optionally updating the reference itself (for the use of "reflog
[expire|delete] --updateref").

The benefit will be simpler code, a better separation of
responsibilities, and a simpler VTABLE that future reference backends
have to implement.

I would love to work on this but unfortunately have way too much on my
plate right now.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
