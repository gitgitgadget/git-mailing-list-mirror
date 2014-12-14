From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/4] strbuf.h: format asciidoc code blocks as 4-space
 indent
Date: Sun, 14 Dec 2014 18:42:26 +0100
Message-ID: <548DCC02.60100@alum.mit.edu>
References: <20141212212726.GA26284@peff.net> <20141212213055.GC27451@peff.net> <20141212223903.GE29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 14 18:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0DBo-0002Sk-I7
	for gcvg-git-2@plane.gmane.org; Sun, 14 Dec 2014 18:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaLNRmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2014 12:42:36 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50639 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751297AbaLNRmf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Dec 2014 12:42:35 -0500
X-AuditID: 12074413-f79f26d0000030e7-89-548dcc059d76
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.3F.12519.50CCD845; Sun, 14 Dec 2014 12:42:29 -0500 (EST)
Received: from [192.168.69.130] (p5DDB23FD.dip0.t-ipconnect.de [93.219.35.253])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBEHgRfZ024863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 14 Dec 2014 12:42:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141212223903.GE29365@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqMt6pjfE4M5yfYuuK91MFg29V5gt
	3t5cwmjxo6WH2WLz5nYWB1aPnbPusnss2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ5w9eIStYLZgxaOeyewNjNt5uxg5OSQETCQObl7HBmGLSVy4tx7MFhK4zCix/BhjFyMX
	kH2eSeL/uk+sIAleAU2JHw9OsIPYLAKqEl8nzWYBsdkEdCUW9TQzgdiiAkESJ/dcZ4eoF5Q4
	OfMJWI2IgLPE98Z3LCBDmQUaGCU+HNgMtk0YqOHokcOsEJuLJdp2zgVr4BQwkJg+ZTWYzSyg
	J7Hj+i9WCFteonnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
	zfVyM0v0UlNKNzFCQlx4B+Ouk3KHGAU4GJV4eD9E9YYIsSaWFVfmHmKU5GBSEuWdtwkoxJeU
	n1KZkVicEV9UmpNafIhRgoNZSYT3wWagHG9KYmVValE+TEqag0VJnFdtibqfkEB6Yklqdmpq
	QWoRTFaGg0NJgvfQKaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCsxhcDoxUk
	xQO09zxIO29xQWIuUBSi9RSjopQ4bz9IQgAkkVGaBzcWlrheMYoDfSnM+xqkigeY9OC6XwEN
	ZgIafJmxB2RwSSJCSqqBccMHid0XS3SmnZ9793TcG/Xk/7e/8l/i7Csoip+hkHPzHL8Ln2bi
	62W/w1wCeaquK0tnZPM6OCu7impu3f/19WWvjKta0eHsNzYvLIjh1//ofp/nqcPx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261400>

On 12/12/2014 11:39 PM, Jonathan Nieder wrote:
> Jeff King wrote:
> 
>> This is much easier to read when the whole thing is stuffed
>> inside a comment block. And there is precedent for this
>> convention in markdown (and just in general ascii text).
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
>> As a side note, I actually find markdown much more pleasant to read and
>> write than asciidoc.
> 
> I do, too.  Quoting in asciidoc is a nightmare.

Peff, thanks for working on this. I think it is a definite improvement.

I suggest that we accept the use of asciidoc/markdown's convention of
using backwards quotes to mark code snippets (especially identifier
names) within comments *anywhere* in our code base. For example, this
appears in refs.c:

    /*
     * Create a struct ref_entry object for the specified dirname.
     * dirname is the name of the directory with a trailing slash
     * (e.g., "refs/heads/") or "" for the top-level directory.
     */

I claim that it is more readable with a tiny bit of markup:

    /*
     * Create a `struct ref_entry` object for the specified `dirname`.
     * `dirname` is the name of the directory with a trailing slash
     * (e.g., "refs/heads/") or "" for the top-level directory.
     */

Marking up `struct ref_entry` helps make it clear that the two words
belong together, and marking up `dirname` makes it clear that we are
talking about a specific identifier (in this case, a function parameter).

Currently, comments use a mix of unadorned text, single-quoted text, and
double-quoted text when talking about code. I think the
asciidoc/markdown convention is clearer [1].

I think we shouldn't be pedantic about this. When a comment is readable
with no markup, there's no need to add markup. And "incorrect" markup
shouldn't by itself be reason to reject a patch. But in many examples, a
little bit of markup makes the text less ambiguous and easier to read.

Michael

[1] Yes, I see the irony in trying to improve a mixture of three
    conventions by adding a fourth one.

-- 
Michael Haggerty
mhagger@alum.mit.edu
