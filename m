From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 3/4] The name of the hash function is "SHA-1", not
 "SHA1"
Date: Tue, 16 Apr 2013 09:10:32 +0200
Message-ID: <516CF968.7010606@alum.mit.edu>
References: <46832203.996447.1366047902197.JavaMail.ngmail@webmail19.arcor-online.net> <1781595479.996520.1366048144788.JavaMail.ngmail@webmail19.arcor-online.net> <7vtxn7slro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 09:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US02M-0004D0-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 09:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab3DPHKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 03:10:37 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:54148 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753338Ab3DPHKg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 03:10:36 -0400
X-AuditID: 12074413-b7f226d000000902-cf-516cf96ba56e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EF.13.02306.B69FC615; Tue, 16 Apr 2013 03:10:35 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3G7AW3p013634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 03:10:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vtxn7slro.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqJv9MyfQ4M99fouuK91MFg29V5gt
	Ji7/zujA7DH5yUYmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Ycvo/c0GrUEXTlVvsDYyz
	+LoYOTkkBEwk9q/+yAZhi0lcuLceyObiEBK4zCix5/8FRpCEkMBxJol9ZzJBbF4BbYnt8z4z
	gdgsAqoS7zZuYAGx2QR0JRb1NIPFRQXCJFatX8YMUS8ocXLmE7AaEQE1iYlth4BsDg5mAVuJ
	zjZTkLCwQJBE34zbTBB7zzJK/GzoA+vlFDCTaGm4zApiMwvoSLzre8AMYctLbH87h3kCo8As
	JCtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ0BXewbjr
	pNwhRgEORiUe3gD5nEAh1sSy4srcQ4ySHExKorwbvwGF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifCqLwfK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeBN+ADUKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI1vhgYqyApHqC9O0DaeYsLEnOBohCtpxiN
	OWZtffKakWPlFSApxJKXn5cqJc5bAVIqAFKaUZoHtwiWtF4xigP9Lcx7FaSKB5jw4Oa9AlrF
	BLTqwKpskFUliQgpqQZGm1NvDvQcWjr3UNuzDi+eM7qzdtUq+tVU8cuU7dWSm7L4xf3KOzvW
	/Tl/aoXYuomq3fWCgQfeM5jGvN+898C5J/WdHjUffIvZ0nVKn0248lZiQl/qQ9+3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221370>

On 04/15/2013 08:15 PM, Junio C Hamano wrote:
> Thomas Ackermann <th.acker@arcor.de> writes:
> 
>> Use "SHA-1" instead of "SHA1" whenever we talk about the hash function.
>> When used as a programming symbol, we keep "SHA1".
>>
>> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
>> ---
> 
> Thanks.  Will queue as-is for now, but I wonder if we want to fix
> them to more official "object name", if we are going to the trouble
> of fixing all of these.  It depends on how many places already
> correctly spell SHA-1, I guess.

I like the idea of making the Git documentation (and the source code)
more algorithm-agnostic.  But personally, I think "object name" is a bad
generic term for describing object hashes.  The word "name" suggests a
moniker that was intentionally given to the object.  I suppose that this
is a big reason that the term "SHA-1" is used so frequently rather than
"object name"--because it is transparently obvious that an "SHA-1" is a
hash as opposed to, say, a filename.

In my opinion, rather than expand the use of the term "object name", we
should pick a better official term that makes it more obvious what we
are talking about, like "object hash".

While we are at it, if being more algorithm-agnostic is considered a
worthy goal, maybe it would be helpful to establish a source code naming
convention to be used in new code in favor of "sha1"; for example,

    ohash = hash of an object of unknown type
    chash = hash of a commit object
    etc.

Obviously I'm not suggesting that Git should transition away from using
SHA-1s, just that the choice of hashing algorithm need not be quite so
explicit in source code that doesn't really need to care.

On a related topic, I find it shocking how often the hard-coded
constants "20", "40", and "41" appear in git source code:

    $ git grep -e '\<20\>' -- '*.c' '*.h' '*.sh' '*.perl' | wc -l
    689
    $ git grep -e '\<4[01]\>' -- '*.c' '*.h' '*.sh' '*.perl' | wc -l
    339

The vast majority of these have to do with the length of a SHA-1 hash.
I think it would aid source-code readability if there were named
constants for the lengths of object hashes in binary and hex format.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
