From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Tue, 18 Nov 2014 22:16:18 +0100
Message-ID: <546BB722.5020901@alum.mit.edu>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>	<546B2CE0.6020208@alum.mit.edu>	<CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>	<546BA21C.9030803@alum.mit.edu> <xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:16:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqq8V-0004Ju-FB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbaKRVQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:16:27 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60423 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932145AbaKRVQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 16:16:25 -0500
X-AuditID: 12074413-f79f26d0000030e7-50-546bb724ccf3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B7.0E.12519.427BB645; Tue, 18 Nov 2014 16:16:21 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3D42.dip0.t-ipconnect.de [93.219.61.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAILGIaQ026803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 18 Nov 2014 16:16:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqKu6PTvEoGsNk0XXlW4mi4beK8wW
	/ybUWGze3M7iwOKxYFOpx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGecv3mXqWAxX8XZbxsZ
	GxjvcnUxcnJICJhITFq6gQXCFpO4cG89G4gtJHCZUeL6fyCbC8g+xyRxY9VLVpAEr4C2xJGT
	lxlBbBYBVYmFc7vZQWw2AV2JRT3NTCC2qECQxMk919kh6gUlTs58ArZAREBNYmLbIRaQocwC
	zYwSKzb9BhrEwSEsYCrRvJ0RYtlXRon3006CNXAKWEsc7psCdhGzgJ7Ejuu/WCFseYnmrbOZ
	JzAKzEKyYxaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAlh
	4R2Mu07KHWIU4GBU4uFNmJoVIsSaWFZcmXuIUZKDSUmUN2BTdogQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEV7BbqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCl2Ub
	UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFbji4HRCpLiAdobDNLOW1yQmAsU
	hWg9xagoJc7rCZIQAElklObBjYUlpleM4kBfCvOWbAWq4gEmNbjuV0CDmYAGz9mQCTK4JBEh
	JdXAGCQgfKF2e48ko+xalsf+ZqvmdM5j4m0z5fKUsfuVZybusCrut5t61ubYhqoEnwsBPxeV
	BgTaM3z/9GKnkMeDDyuizMytcp7zNj2Muq64otve11ljUdvzy+kpp0X1GK+8kbP/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2014 09:30 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I'm still not convinced. For me, "reflog_expire()" is an unusual outlier
>> operation, much like "git gc" or "git pack-refs" or "git fsck". None of
>> these are part of the beautiful Git data model; they are messy
>> maintenance operations. Forcing reference transactions to be general
>> enough to allow reflog expiration to be implemented *outside* the refs
>> API sacrificies their simplicity for lots of infrastructure that will
>> probably only be used to implement this single operation. Better to
>> implement reflog expiration *inside* the refs API.
> 
> Sorry, but I lost track---which one is inside and which one is
> outside?

By "inside" I mean the code that would be within the reference-handling
library if we had such a thing; i.e., implemented in refs.c. By
"outside" I mean in the code that calls the library; in this case the
"outside" code would live in builtin/reflog.c.

In other words, I'd prefer the "outside" code in builtin/reflog.c to
look vaguely like

    expire_reflogs_for_me_please(refname,
                                 should_expire_cb, cbdata, flags)

rather than

    transaction = ...
    for_each_reflog_entry {
        if should_expire()
            adjust neighbor reflog entries if necessary (actually,
                   they're transaction entries so we would have to
                   preprocess them before putting them in the
                   transaction)
        else
            add reflog entry to transaction
    }
    ref_transaction_commit()

and instead handle as much of the iteration, bookkeeping, and rewriting
as possible inside expire_reflogs_for_me_please().

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
