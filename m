From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 05 Feb 2013 11:29:49 +0100
Message-ID: <5110DF1D.8010505@alum.mit.edu>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com> <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 11:30:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2fn8-00079T-6w
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 11:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab3BEK34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 05:29:56 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:63852 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751148Ab3BEK3y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 05:29:54 -0500
X-AuditID: 1207440e-b7f116d0000008ae-ab-5110df216047
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 83.07.02222.12FD0115; Tue,  5 Feb 2013 05:29:53 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r15ATox0031968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 5 Feb 2013 05:29:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130205083327.GA4931@elie.Belkin>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqKt4XyDQYOUcWYuuK91MFg29V5gt
	3t5cwmjxo6WH2WL+oYmsDqweO2fdZfd41ruH0ePiJWWPP+f3sHp83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xuPcca8Fy84oL97cwNTBu0uli5OSQEDCReDd3LxOELSZx4d56ti5GLg4hgcuMEic/
	z2EBSQgJHGOSOHwgH8TmFdCWmLHqEjOIzSKgKtE+5z07iM0moCuxqKcZbJCoQJhE7+tzjBD1
	ghInZz4BmyMioCHx/NM3sAXMAs2MEkuuPwEbJCygLrGr/RA7xOZWRonDq5aCTeUUMJA4t2gX
	G4jNLKAj8a7vATOELS+x/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3SN9XIzS/RSU0o3MULCnG8HY/t6mUOMAhyMSjy8Qdf4A4VYE8uKK3MPMUpyMCmJ8nrf
	EggU4kvKT6nMSCzOiC8qzUktPsQowcGsJML78QZQOW9KYmVValE+TEqag0VJnFdtibqfkEB6
	YklqdmpqQWoRTFaGg0NJglfkHtBQwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFC0
	xhcD4xUkxQO0d+9doHbe4oLEXKAoROspRmOO/U/anzNybP8NJIVY8vLzUqXEeX+BlAqAlGaU
	5sEtgiW4V4ziQH8L8/KB3MMDTI5w814BrWICWqWUA/JicUkiQkqqgbFuXcN++ZAFx7J/Vr3n
	ZYgpiDyfv7FpQlgc96zOE0frLz0PU7u6PXN13SqbB9sXLBfp1qlbzDXd23PLnM4X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215475>

On 02/05/2013 09:33 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> I would again like to express my discomfort about this feature, which is
>> already listed as "will merge to next".  Frankly, I have the feeling
>> that this feature is being steamrolled in before a community consensus
>> has been reached and indeed before many valid points raised by other
>> members of the community have even been addressed.  For example:
> 
> In $dayjob I work with Gerrit, so I think I can start to answer some
> of these questions.
> 
>> * I didn't see a response to Peff's convincing arguments that this
>> should be a client-side feature rather than a server-side feature [1].
> 
> The client can't control the size of the ref advertisement.  That is
> the main motivation if I understood correctly.

Not according to Junio [4]:

  Look at this as a mechanism for the repository owner to control the
  clutter in what is shown to the intended audience of what s/he
  publishes in the repository.  Network bandwidth reduction of
  advertisement is a side effect of clutter reduction, and not
  necessarily the primary goal.

>> * I didn't see an answer to Duy's question [2] about what is different
>> between the proposed feature and gitnamespaces.
> 
> Namespaces are more complicated and don't sit well in existing setups
> involving git repositories whose refs are not namespaced.

Thanks.

>> * I didn't see a response to my worries that this feature could be
>> abused [3].
> 
> Can you elaborate?  Do you mean that through social engineering an
> attacker would convince the server admin to store secrets using a
> hidden ref and enable the upload-archive service?

The upload-archive service is not needed; after patch v3 "7/8" remote
clients are able to retrieve hidden content by SHA1.

Hiderefs creates a "dark" corner of a remote git repo that can hold
arbitrary content that is impossible for anybody to discover but
nevertheless possible for anybody to download (if they know the name of
a hidden reference).  In earlier versions of the patch series I believe
that it was possible to push to a hidden reference hierarchy, which made
it possible to upload dark content.  The new version appears (from the
code) to prohibit adding references in a hidden hierarchy, which would
close the main loophole that I was worried about.  But the documentation
and the unit tests only explicitly say that updates and deletes are
prohibited; nothing is said about adding references (unless "update" is
understood to include "add").  I think the true behavior should be
clarified and tested.

I was worried that somehow this "dark" content could be used for
malicious purposes; for example, pushing compromised code then
convincing somebody to download it by SHA1 with the implicit argument
"it's safe since it comes directly from the project's official
repository".  If it is indeed impossible to populate the dark namespace
remotely then I can't think of a way to exploit it.

> That does sound like a reasonable concern.  Perhaps the documentation
> should be updated along these lines
> 
> 	transfer.hiderefs::
> 		String(s) `upload-pack` and `receive-pack` use to decide
> 		which refs to omit from their initial advertisement.  Use
> 		more than one transfer.hiderefs configuration variables to
> 		specify multiple prefix strings. A ref that are under the
> 		hierarchies listed on the value of this variable is excluded,
> 		and is hidden from `git ls-remote`, `git fetch`, `git push :`,
> 		etc.  An attempt to update or delete a hidden ref by `git push`
> 		is rejected, and an attempt to fetch a hidden ref by `git fetch`
> 		will fail.
> 	+
> 	This setting does not currently affect the `upload-archive` service.
> 
> until someone interested implements the same for upload-archive.

Yes, this sounds reasonable.

>> I also think that the feature is poorly designed.  For example:
> 
> That's another reasonable concern.  It's very hard to get a design
> correct right away, which is presumably part of the motivation of
> getting this into the hands of interested users who can give feedback
> on it.  What would potentially be worth blocking even that is concerns
> about the wire protocol, since it is hard to take back mistakes there.
> 
>> * Why should a repository have exactly one setting for what refs should
>> be hidden?  Wouldn't it make more sense to allow multiple "views" to be
>> defined?:
> 
> How do I request a different view of the repository at
> /path/to/repo.git over the network?  How can we make the common case
> of only one view easy to achieve?  Isn't the multiple-views case
> exactly what gitnamespaces is for?

Hidden references can only be configured by somebody with local access
to the repository being served.  Somebody with that access could also
configure views.  He could also probably organize a mapping from URL ->
(GIT_PATH, GIT_VIEW) and offer several different views of the same
repository.  If the setting of environment variables is thought to
sometimes be too problematic, the default view could be defined via
configuration, too:

[view]
	default = official
[view "official"]
	hiderefs = refs/pull

Or perhaps, if views are made available locally too, then one view could
be designated as the default for transfer purposes:

[transfer]
	defaultview = official

gitnamespaces have the disadvantage that you mentioned yourself earlier.

> [...]
>> * Is it enough to support only reference exclusion (as opposed to
>> exclusion and inclusion rules)?
> 
> The motivating example is turning off advertisement of the
> refs/changes hierarchy.  If and when more complicated cases come up,
> that would presumably be the time to support more complicated
> configuration.

I suppose should the need arise we could later introduce
"transfer.showrefs" and let the longest match to a given reference
(i.e., "transfer.hiderefs" vs. "transfer.showrefs") win.

> [...]
>> * Why should this feature only be available remotely?
> 
> It is about transport.  Ref namespaces have their own set of use cases
> and are a distinct feature.

gitnamespaces offer multiple perspectives of a single object database,
using independent sets of references to define the subset.  Changing a
reference in one namespace has no effect on similarly-named references
in another namespace.

The "views" feature that I vaguely suggested, on the other hand, would
offer multiple subsets of a single set of references, a bit like an SQL
view.  Changing a reference in one view would automatically affect it in
other views that include the reference.  It could be a handy way to
reduce clutter *locally* in the same way that hiderefs would reduce
clutter *remotely*.  But more importantly, both features could be built
on the same foundation.

Michael

[4] http://article.gmane.org/gmane.comp.version-control.git/213984

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
