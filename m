From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RefTree: Alternate ref backend
Date: Wed, 23 Dec 2015 05:59:48 +0100
Message-ID: <567A2A44.3050003@alum.mit.edu>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <56796F37.1000600@alum.mit.edu>
 <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
 <567985A8.2020301@alum.mit.edu>
 <CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
 <xmqq1taee1w9.fsf@gitster.mtv.corp.google.com>
 <CAJo=hJswuPdLT0KtGdf_=UGxD7-5NjGk2mwFjRU=uYb-Su-y+A@mail.gmail.com>
 <xmqqsi2ucm60.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 23 06:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBbdn-0001r3-CM
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 06:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbbLWFHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 00:07:04 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64685 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbbLWFHD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 00:07:03 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2015 00:07:03 EST
X-AuditID: 1207440e-f79516d0000012b3-16-567a2a47bf3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.BF.04787.74A2A765; Tue, 22 Dec 2015 23:59:51 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBN4xmLf005016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Dec 2015 23:59:50 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <xmqqsi2ucm60.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqOuuVRVmsGWqjsX8TScYLbqudDNZ
	NPReYba4/34dk8WPlh5mi/mHJrI6sHlc7utl8njWu4fR4+IlZY8/5/eweix4fp/d4/MmuQC2
	KG6bpMSSsuDM9Dx9uwTujJ2Nj5kLdqhVHN/ayNLA+EWui5GTQ0LAROLY8+NsELaYxIV764Fs
	Lg4hgcuMEs/f7IdyLjBJrHvWwg5SJSygLfG8+xcriC0i4CXxf9pbdoii08wSfQt2MIE4zAJ9
	jBLffl8Bq2IT0JVY1NPMBLFDTqK3exJLFyMHBy/QpJ1HPUBMFgFVie7PwiAVogIhEnt3drCA
	2LwCghInZz4BszkFrCWW3nkIdgOzgJ7EjusQNzALyEs0b53NPIFRcBaSlllIymYhKVvAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyQi+HYwtq+XOcQowMGoxMPr2FYZ
	JsSaWFZcmXuIUZKDSUmUV5e7KkyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/6O6By3pTEyqrU
	onyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb74m0FDBotT01Iq0zJwShDQTByfI
	cC4pkeLUvJTUosTSkox4UAzHFwOjGCTFA7TXHqSdt7ggMRcoCtF6ilFRSpy3VgMoIQCSyCjN
	gxsLS3OvGMWBvhTm5Qdp5wGmSLjuV0CDmYAG/1lXDjK4JBEhJdXAmH9CP3kVx5mKrZ5n23VN
	HdMTPbgr1u360LzrRo3f66/bYir3ekw4VRVf96QrgO2Kz+5LLuc+7V73/NXetITF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282922>

On 12/22/2015 08:34 PM, Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
>> On Tue, Dec 22, 2015 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Shawn Pearce <spearce@spearce.org> writes:
>>>
>>>>> But really, aside from slightly helping
>>>>> disambiguate references from paths in the command line, what is it good
>>>>> for?
>>>>
>>>> Nothing really; today refs/ prefix is used to encourage to the tools
>>>> that you really meant refs/heads/master and not
>>>> refs/heads/heads/master or some other crazy construct. You can thank
>>>> the DWIMery inside the ref rev parse logic for needing this.
>>>
>>> Aren't you two forgetting one minor thing, though?
>>>
>>> A layout without refs/, i.e. $GIT_DIR/{heads,tags,...}, will force
>>> us to keep track of where the tips of histories are anchored for
>>> reachability purposes, every time you would add a new hierarchy
>>> (e.g. $GIT_DIR/changes)--and those unfortunate souls who run a
>>> slightly older version of Git that is unaware of 'changes' hierarchy
>>> would weep after running "git gc", no?
>>
>> You still store them under refs/
> 
> Well I know; the comment was merely a reaction to the exchange
> between you two, "What is refs/ good for?", "Nothing really".
> 
> You'd benefit by having "refs/" that is known to contain all the
> anchoring points for reachability without knowing what subhierarchy
> it may contain in the future, that is what it is good for.

You are answering "What is 'refs/' good for in the pathnames of files
that store loose references?" I was asking "What is 'refs/' good for in
the logical names of references?"

It would have been totally possible to make the full name of a branch
be, for example, "heads/master" and nevertheless store its loose
reference in "$GIT_DIR/refs/heads/master". The obvious place to store
HEAD in such a scheme would have been "$GIT_DIR/refs/HEAD" while still
calling it "HEAD". This could have avoided the problem that we now have
with pseudo-references like FETCH_HEAD being stored directly in $GIT_DIR.

On 12/22/2015 09:56 PM, Martin Fick wrote:
> On Tuesday, December 22, 2015 06:17:28 PM you wrote:
>> On Tue, Dec 22, 2015 at 7:41 AM, Michael Haggerty
> <mhagger@alum.mit.edu> wrote:
>>
>> [...] Would we really be worse off if
>> references' full names were
>>
>>     HEAD
>>     heads/master
>>     tags/v1.0.0
>>     remotes/origin/master (or remotes/origin/heads/master)
>
> I think this is a bit off, because
>
>   HEAD != refs/HEAD
>
> so not quite useless.

A reference called "refs/HEAD" is not forbidden today but it's still not
very useful, is it? Do you know of some system that uses reference names
like this or are you just pointing out that it's theoretically possible?

> But, I agree that the whole refs notation has always bugged
> me, it is quirky.  It makes it hard to disambiguate when
> something is meant to be absolute or not.  What if we added
> a leading slash for absolute references? Then I could do
> something like:
>
> /HEAD
> /refs/heads/master
> /refs/tags/v1.0.0
> /refs/remotes/origin/master

I like the idea of having a way to express "absolute" reference names.
But maybe if we do so we could take a step towards deprecating "refs/"
in references' logical names, by instead using the following absolute
notation for the above references:

    /HEAD
    /heads/master
    /tags/v1.0.0
    /remotes/origin/master

Specifically:

* Any name of the form "/$name" for which is_pseudoref_syntax($name)
  returns true would be mapped to what we today call "$name" (e.g.,
  "/FETCH_HEAD" would be mapped to today's "FETCH_HEAD")

* Any other name of the form "/$name" would be mapped to today's
  "refs/$name".

Note that all of the absolute reference listed above, with their leading
"/" removed, have the same interpretation under DWIM as they would as
absolute names under my proposal (provided of course, that there is no
DWIM ambiguity with other reference names).

The only disadvantage that I can see with this scheme is that there
would be no "absolute" notation for a reference that currently has a
full name like "refs/HEAD" (or more generally a reference currently
called "refs/$name" where is_pseudoref_syntax($name) returns true). I
think that is acceptable: (1) such references are probably not in wide
use; (2) we wouldn't (yet) have to prohibit such references; even though
there would be no absolute notation to represent them, their old-style
names would still work.

If we ever decide to go further in banishing "refs/", the next step in
the transition would be to disallow names like "refs/HEAD", treat the
absolute reference names as the "canonical" version, and adding DWIM
rules that treat a prefix "refs/" very much like a leading "/".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
