From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 06 Mar 2014 09:42:46 +0100
Message-ID: <53183506.5080002@alum.mit.edu>
References: <20140304174806.GA11561@sigill.intra.peff.net> <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com> <20140305005649.GB11509@sigill.intra.peff.net> <xmqqy50oh45n.fsf@gitster.dls.corp.google.com> <20140305185212.GA23907@sigill.intra.peff.net> <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 09:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLU0Z-0001X4-1t
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 09:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbaCFItw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 03:49:52 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56123 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087AbaCFItv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 03:49:51 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Mar 2014 03:49:50 EST
X-AuditID: 12074412-f79d46d000002e58-22-531835088488
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BA.1E.11864.80538135; Thu,  6 Mar 2014 03:42:48 -0500 (EST)
Received: from [192.168.69.148] (p57A24A5D.dip0.t-ipconnect.de [87.162.74.93])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s268gkXT031786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 6 Mar 2014 03:42:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqMthKhFscLVf3aLrSjeTRUPvFWaL
	Hy09zA7MHs969zB6XLyk7PF5k1wAcxS3TVJiSVlwZnqevl0Cd0bX6QnMBVf4Kg7sf8fWwPiQ
	u4uRk0NCwETi9uc5jBC2mMSFe+vZuhi5OIQELjNKfJy2HCwhJHCWSWLJSnsQm1dAW2Ljnncs
	IDaLgKrE1eazTCA2m4CuxKKeZjBbVCBYYvXlBywQ9YISJ2c+AbNFBNQkJrYdArI5OJgFjCTm
	na4HCQsL2EjcPPqLCWLvUiaJu79+sIIkOAWsJZ7vnsYGUi8hIC7R0xgEEmYW0JF41/eAGcKW
	l9j+dg7zBEbBWUi2zUJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkp
	pZsYIQEttINx/Um5Q4wCHIxKPLwb/MSDhVgTy4orcw8xSnIwKYnyKhpLBAvxJeWnVGYkFmfE
	F5XmpBYfYpTgYFYS4d1iCJTjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHg
	UJLgrTICahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxW98MTCCQVI8QHt1TED2
	Fhck5gJFIVpPMepy3G779YlRiCUvPy9VSpz3FsjhAiBFGaV5cCtg6esVozjQx8K85iCjeICp
	D27SK6AlTEBLovnEQZaUJCKkpBoYw5rrPPjnFHSu3XGPZdfWd+E+Zq/cVdzlb59IrC7kLZap
	MBI9NSWC85bm/iaBbzYqd/14/xc++j43yfvLJ6bqdbnNU1ZPqZnAUxX5dHWEwOyN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243504>

On 03/05/2014 08:18 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Mar 05, 2014 at 10:49:24AM -0800, Junio C Hamano wrote:
>>
>>> ... the plan, at least in my mind, has always been exactly that: grafts
>>> were a nice little attempt but is broken---if you really wanted to
>>> muck with the history without rewriting (which is still discouraged,
>>> by the way), do not use "graft", but use "replace".
>>
>> I certainly had in the back of my mind that grafts were a lesser form of
>> "replace", and that eventually we could get rid of the former. Perhaps
>> my question should have been: "why haven't we deprecated grafts yet?".
> 
> Given that we discourage "grafts" strongly and "replace" less so
> (but still discourage it), telling the users that biting the bullet
> and rewriting the history is _the_ permanent solution, I think it is
> understandable why nobody has bothered to.

Replace objects are better than grafts in *almost* every dimension.  The
exception is that it is dead simple to create grafts, whereas I always
have to break open the man pages to remember how to create a replace
object that does the same thing.

So I think a helpful step towards deprecating grafts would be to offer a
couple of convenience features to help people kick the "grafts" habit:

* A tool that converts grafts (i.e., the grafts read from
$GIT_DIR/info/grafts) into the equivalent replacements.

* A tool that creates a new replacement object that is the equivalent of
a graft.  I.e., it should do, using replace references, the equivalent
of the following command:

      echo SHA1 [PARENT1...] >>$GIT_DIR/info/grafts

These features could be added to "git replace" or could be built into a
new "git grafts" command.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
