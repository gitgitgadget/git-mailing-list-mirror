From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/8] Making reflog modifications part of the transactions
 API
Date: Mon, 15 Dec 2014 00:17:05 +0100
Message-ID: <548E1A71.7080707@alum.mit.edu>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>	<548B150C.2090606@alum.mit.edu> <CAN05THRiMiQCqO1VZX7zQeWLBZMPG_sx1aVvdGirAoEh2Hd9Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: ronnie sahlberg <ronniesahlberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:17:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0IPl-0007Um-W4
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 00:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbaLNXRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2014 18:17:21 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62185 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbaLNXRU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Dec 2014 18:17:20 -0500
X-AuditID: 12074412-f79e46d0000036b4-25-548e1a734110
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F6.EB.14004.37A1E845; Sun, 14 Dec 2014 18:17:07 -0500 (EST)
Received: from [192.168.69.130] (p5DDB23FD.dip0.t-ipconnect.de [93.219.35.253])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBENH5ds008365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 14 Dec 2014 18:17:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAN05THRiMiQCqO1VZX7zQeWLBZMPG_sx1aVvdGirAoEh2Hd9Dw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqFss1Rdi0PfV3KLrSjeTRUPvFWaL
	tzeXMFr09n1itdi8uZ3FgdVj56y77B4LNpV6XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd8b6
	w1tYC/rlKiYs/szUwNgo0cXIySEhYCKxrGkBI4QtJnHh3nq2LkYuDiGBy4wSkw5tZodwzjNJ
	rHjxkR2kildAW+L85A+sIDaLgKrEjvMHwWw2AV2JRT3NTCC2qECQxMk916HqBSVOznzCAmKL
	COhJzFlwjRFkKLPAdEaJm50XwZqFBYIlup5/AGsQEljOKHH2pROIzSkQKNHV3A5WwyygLvFn
	3iVmCFteonnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRy
	M0v0UlNKNzFCQltoB+P6k3KHGAU4GJV4eCMY+0KEWBPLiitzDzFKcjApifLa3OgNEeJLyk+p
	zEgszogvKs1JLT7EKMHBrCTCO4UJqJw3JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFq
	EUxWhoNDSYI3SBKoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UrfHFwHgFSfEA
	7W2TANlbXJCYCxSFaD3FqCglzusGMlcAJJFRmgc3FpawXjGKA30pzJsLUsUDTHZw3a+ABjMB
	Db7M2AMyuCQRISXVwJjFkZJqM3PF45j3ure/rPLoe8y5LdJx3pLql8Z3drcK8S6rFIzLt6xi
	MM6zMvUqn7VDa/EM69csee1f0ln4bEOFPn4slYp4Im1fNsPfVEMvOTtuVuH3CF72 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261403>

On 12/12/2014 10:16 PM, ronnie sahlberg wrote:
> On Fri, Dec 12, 2014 at 11:17 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> What am I missing?
> 
> My original idea was to clean up a bit of the reflog handling API and
> have one single transaction API for all  ref and reflog operations.
> 
> Think future use cases where you have a database backend for both refs
> and reflogs. It would be very nice to have a single atomic transaction
> that would either commit or fail atomically any update to refs and/or
> reflogs.
> Otherwise you would have all consumers of the API have to invent their
> own transaction and rewind support : 'oh the ref transaction failed
> and I have already done the reflog commit,   have to manually uncommit
> ...".
> And this quickly becomes quite burdensome for consumers.
> 
> I think a transaction API should remove this burden from consumers and
> make it as easy as possible to use the API.
> 
> Conditional of if it is desireable to have transactions for reflogs at all.

Nobody is against ACID. But the API to trigger an ACID update doesn't
always have to look like

    ref_transaction_begin()
    ref_transaction_update_XXX()
    /* ... */
    ref_transaction_commit()

The reflog_expire() function that I wrote does everything within an
internal transaction that the caller doesn't have to know about.
Similarly, the reflog update that happens when a reference is updated
also occurs within a transaction, even without the caller having to ask
for the reflog update explicitly.

> About the cleanup part. The current API, and I think also the current
> direction of both my old patches (which I think did not go far enough
> in the transactifications) or this current patchseries is that they
> all
> have a very confusing and inconsistent API for reflog updates.
> With this I mean,   sometimes reflog updates happen within a
> transaction as a side effect of a ref_transaction_update().
> Other times reflog updates happens ooutside of transactions by calling
> a special reflog API.
> 
> I.e.  reflogs sometimes update as part of a transaction and sometimes not.
> A follow up question then on this API is what should happen if you
> have a transaction open, but not committed, and while the transaction
> is open you call the non-transactional reflog API for a reflog for the
> same ref that is already beeing/or going to be/ updated as the
> ref-update-side-effect ?

The same thing happens as when two independent processes try to update
the same reference simultaneously: one fails. But there is currently no
need for any command that would do such a thing.

> I think an api where "sometimes you operate on foo from within a
> transaction and sometimes you do not, and if you do the latter when a
> transaction is open, it is unclear what should happen" is not great.
> IMHO, refs and reflog updates are related and I think:
> 
> * a transaction should be the ONLY way to mutate either a ref or a
> reflog or both.
> * if you update both a ref and a reflog then that should happen as
> part of one single transaction.
> * (later) it would probably make the API better if the code was
> refactored so write_ref_sha1() will NOT call log_ref_write() anymore
> and instead make the reflog update that happens explicit perhaps by
> calling something like a ref_transaction_update_reflog() as part of
> the ref_transaction_update() call.

I disagree. The reflog should be updated *whenever* a reference is
updated (for references that have reflogs enabled). So why should
callers have to remember to trigger the reflog update as an extra step?
It's better that the reflog update is an intrinsic part of updating the
reference; that way nobody can forget it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
