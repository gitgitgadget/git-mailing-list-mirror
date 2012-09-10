From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Using doxygen (or something similar) to generate API docs [was [PATCH
 4/4] Add a function string_list_longest_prefix()]
Date: Mon, 10 Sep 2012 21:21:12 +0200
Message-ID: <504E3DA8.7040906@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu> <7vbohfser4.fsf@alter.siamese.dyndns.org> <504DBA62.3080001@alum.mit.edu> <7v1ui9q21a.fsf@alter.siamese.dyndns.org> <20120910163310.GE9435@sigill.intra.peff.net> <504E27D7.8010505@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Sep 10 21:21:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB9Y8-0001gq-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 21:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251Ab2IJTVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 15:21:18 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:55544 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758097Ab2IJTVR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 15:21:17 -0400
X-AuditID: 12074412-b7f216d0000008e3-2d-504e3dacab8f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A0.6B.02275.CAD3E405; Mon, 10 Sep 2012 15:21:16 -0400 (EDT)
Received: from [192.168.69.140] (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8AJLDFm014652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 15:21:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <504E27D7.8010505@op5.se>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqLvG1i/A4NEfdYvWNTcYLbqudDNZ
	NPReYbb40dLD7MDisW3zPSaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y9Lz/4wF
	F0UqTvdxNzAeEOhi5OSQEDCRODbrEBOELSZx4d56ti5GLg4hgcuMElvmzmGHcE4zSSy6+pkR
	pIpXQFvi/qJtYB0sAqoS827fBIuzCehKLOppBouLCoRIzLg8mRmiXlDi5MwnLCC2iICCxLGz
	91hBbGaBeIkZjR9YQRYICzQxSszd9BFq23Ymibm73oJ1cAqoSey/2MQC0aEr8aNpJRuELS+x
	/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3
	MUJCWmgH4/qTcocYBTgYlXh4NXj8AoRYE8uKK3MPMUpyMCmJ8uraAIX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8MZrAuV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4
	V4AMFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFa3wxMF5BUjxAez9ag+wtLkjM
	BYpCtJ5iNOaYfXPFfUaOux+BpBBLXn5eqpQ47zsroFIBkNKM0jy4RbBk9opRHOhvYd5ZIPfw
	ABMh3LxXQKuYgFb5eviArCpJREhJNTBOm2R1acPlY29q5znMqpPL3rjue9HykG+bjoouef6l
	fV7H3Amft0ydmMAhK3w8jslshqHm7RV7HW525wQuWb9xs5+pi3jx5Q9XNgReWvXK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205162>

I'm renaming this thread so that the bikeshedding can get over ASAP.

On 09/10/2012 07:48 PM, Andreas Ericsson wrote:
> On 09/10/2012 06:33 PM, Jeff King wrote:
>> On Mon, Sep 10, 2012 at 09:24:17AM -0700, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>> Also, better documentation in header files could enable the automatic
>>>> generation of API docs (e.g., via doxygen).
>>>
>>> Yeah, perhaps you may want to look into doing an automated
>>> generation of Documentation/technical/api-*.txt files out of the
>>> headers.
>>
>> I was just documenting something in technical/api-* the other day, and
>> had the same feeling. I'd be very happy if we moved to some kind of
>> literate-programming system. I have no idea which ones are good or bad,
>> though. I have used doxygen, but all I remember is it being painfully
>> baroque. I'd much rather have something simple and lightweight, with an
>> easy markup format. For example, this:
>>
>>    http://tomdoc.org/
>>
>> Looks much nicer to me than most doxygen I've seen. But again, it's been
>> a while, so maybe doxygen is nicer than I remember.

I don't have a personal preference for what system is used.  I mentioned
doxygen only because it seems to be a well-known example.

>From a glance at the URL you mentioned, it looks like TomDoc is only
applicable to Ruby code.

> Doxygen has a the very nifty feature of being able to generate
> callgraphs though. We use it extensively at $dayjob, so if you need a
> hand building something sensible out of git's headers, I'd be happy
> to help.

My plate is full.  If you are able to work on this, it would be awesome.
 As far as I'm concerned, you are the new literate documentation czar :-)

Most importantly, having a convenient system of converting header
comments into documentation would hopefully motivate other people to add
better header comments in the first place, and motivate reviewers to
insist on them.  It's shocking (to me) how few functions are documented,
and how often I have to read masses of C code to figure out what a
function is for, its pre- and post-conditions, its memory policy, etc.
Often I find myself having to read functions three layers down the call
tree to figure out the behavior of the top-layer function.  I try to
document things as I go, but it's only a drop in the bucket.

> libgit2 uses doxygen btw, and has done since the start. If we ever
> merge the two, it would be neat to use the same.

That would be a nice bonus.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
