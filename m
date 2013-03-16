From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Sat, 16 Mar 2013 09:48:42 +0100
Message-ID: <514431EA.2050402@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu> <7vwqtb2ood.fsf@alter.siamese.dyndns.org> <20130313215800.GA23838@sigill.intra.peff.net> <51415516.2070702@alum.mit.edu> <20130314052448.GA2300@sigill.intra.peff.net> <5141B475.1000707@alum.mit.edu> <20130314134032.GA9222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 09:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGmnv-0007eB-Ey
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 09:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab3CPIsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 04:48:51 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:64046 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751948Ab3CPIss (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Mar 2013 04:48:48 -0400
X-AuditID: 1207440f-b7f466d0000009dc-c1-514431efaa04
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 55.52.02524.FE134415; Sat, 16 Mar 2013 04:48:47 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A2D.dip.t-dialin.net [87.162.74.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2G8miBa009578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Mar 2013 04:48:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130314134032.GA9222@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqPve0CXQ4P1VXouuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BlnOxayFZxXrFh77gpjA+Na
	qS5GTg4JAROJN09Xs0PYYhIX7q1nA7GFBC4zSvz+otDFyAVkn2aSmHJ5LnMXIwcHr4C2xMHN
	aiA1LAKqEs8vLAHrZRPQlVjU08wEYosKhEnsvTANbA6vgKDEyZlPWEBsEQFZie+HNzKC2MwC
	URLnX/4HiwsLqEmsnvqcEWLXAiaJ61u/MYMkOAWsJFbtes8KspdZQF1i/TwhiF55ie1v5zBP
	YBSYhWTFLISqWUiqFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICVv+
	HYxd62UOMQpwMCrx8FbaOQcKsSaWFVfmHmKU5GBSEuXdr+MSKMSXlJ9SmZFYnBFfVJqTWnyI
	UYKDWUmE950+UDlvSmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYKXGxif
	QoJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaK8eSDtvcUFiLlAU
	ovUUozHHgmuPXjBy7H4HJIVY8vLzUqXEeW8bAJUKgJRmlObBLYIlrFeM4kB/C/M+AKniASY7
	uHmvgFYxAa3ad8UJZFVJIkJKqoGxZ2JwwqIS1hP+6rf/u27t3/Nu0aKP+/lfcj2y/G8qFDiZ
	4eflCYYaH53SQnd8+NATryZxwDKba51rHzvPR0/F+cItjYpZbx8oH/7NNWWj8OTt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218287>

On 03/14/2013 02:40 PM, Jeff King wrote:
> Hmph. I coincidentally ran across another problem with 435c833 today.
> Try this:
> [...]
> 
> But that's somewhat off-topic for this discussion. I'll look into it
> further and try to make a patch later today or tomorrow.
> 
> On Thu, Mar 14, 2013 at 12:28:53PM +0100, Michael Haggerty wrote:
>> Your patch looks about right aside from its lack of comments :-).  I was
>> going to implement approximately the same thing in a patch series that I
>> am working on, but if you prefer then go ahead and submit your patch and
>> I will rebase my branch on top of it.
> 
> I just meant it as a quick sketch, since you said you were working in
> the area. I'm not sure what you are working on. If we don't consider it
> an urgent bugfix, I'm just as happy for you to incorporate the idea into
> what you are doing.
> 
> But if we want to do it as a maint-track fix, I can clean up my patch.
> Junio?

My patch series is nearly done.  I will need another day or two to
review and make it submission-ready, but I wanted to give you an idea of
what I'm up to and I could also use your feedback on some points.

The (preliminary) patch series is available on GitHub:

    https://github.com/mhagger/git/commits/pack-refs-unification

Highlights:

* Move pack-refs code into refs.c

* Implement fully-peeled packed-refs files, as discussed upthread: peel
  references outside of refs/tags, and keep rigorous track of
  which references have REF_KNOWS_PEELED.

* Change how references are iterated over internally (without changing
  the exported API):

  * Provide direct access to the ref_entries

  * Don't set current_ref if not iterating over all refs

* Change pack-refs to use the peeled information from ref_entries if it
  is available, rather than looking up the references again.

* repack_without_ref() writes peeled refs to the packed-refs file.
  Use the old values if available; otherwise look them up.  (The old
  version of repack_without_refs() wrote a packed-refs file without
  any peeled values even if they were present in the old packed-refs
  file.)  Remove the deleted reference from the in-RAM packed ref cache
  in-place instead of discarding the whole cache.

* Add some tests and lots of comments.

Here are my questions for you:

1. There are multiple functions for peeling refs:
   peel_ref() (and peel_object(), which was extracted from it);
   peel_entry() (derived from pack-refs.c:pack_one_ref()).  It would be
   nice to combine these into the One True Function.  But given the
   problem that you mentioned above (which is rooted in parts of the
   code that I don't know) I don't know what that version should do.

2. repack_without_ref() now writes peeled refs, peeling them if
   necessary.  It does this *without* referring to the loose refs
   to avoid having to load all of the loose references, which can be
   time-consuming.  But this means that it might try to lookup SHA1s
   that are not the current value of the corresponding reference any
   more, and might even have been garbage collected.  Is the code that
   I use to do this, in peel_entry(), safe to call for nonexistent
   SHA1s (I would like it to return 0 if the SHA1 is invalid)?:

	o = parse_object(entry->u.value.sha1);
	if (o->type == OBJ_TAG) {
		o = deref_tag(o, entry->name, 0);
		if (o) {
			hashcpy(entry->u.value.peeled, o->sha1);
			entry->flag |= REF_KNOWS_PEELED;
			return 1;
		}
	}
	return 0;

   I've tried to test this experimentally and it seems to work, but I
   would like to have some theoretical support :-)

3. This same change to repack_with_ref() means that it could become
   significantly slower to delete a packed ref if the packed-ref file
   is not fully-peeled.  On the plus side, once this is done once, the
   packed-refs files will be rewritten in fully-peeled form.  But if
   two versions of Git are being used in a repository, this cost could
   be incurred repeatedly.  Does anybody object?

4. Should I change the locking policy as discussed in this thread?:

       http://article.gmane.org/gmane.comp.version-control.git/212131

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
