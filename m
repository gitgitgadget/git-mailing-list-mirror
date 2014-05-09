From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1 23/25] contrib: remove 'hooks/multimail'
Date: Fri, 09 May 2014 17:28:07 +0200
Message-ID: <536CF407.9050802@alum.mit.edu>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>	<1399597116-1851-24-git-send-email-felipe.contreras@gmail.com>	<536CED9B.3080706@alum.mit.edu> <87y4ybxabn.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 09 17:28:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wimip-0006ty-ET
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbaEIP2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:28:14 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:57189 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756877AbaEIP2L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 11:28:11 -0400
X-AuditID: 12074414-f79d96d000002d2b-93-536cf40ae3bd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 11.59.11563.A04FC635; Fri,  9 May 2014 11:28:10 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2E4D.dip0.t-ipconnect.de [93.219.46.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s49FS7oV028242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 9 May 2014 11:28:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <87y4ybxabn.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqMv1JSfY4NFNVYvZN7axWRx8nGfR
	daWbyaKh9wqzA4vHzll32T3appl5XLyk7PF5k1wASxS3TVJiSVlwZnqevl0Cd8aqRcuZCnr4
	Kv7cXsvcwLiBu4uRk0NCwETie98dZghbTOLCvfVsXYxcHEIClxkltm/pYYFwzjJJXFx+nQ2k
	ildAW+LspzVANgcHi4CqxLpdLCBhNgFdiUU9zUwgYVGBIIk/ZxUhqgUlTs58AlYiIiAvsXzW
	W3aQEmaBYonrvy1BwsIC9hK/bsxhgth0mlHi74slYJs4BfQlepZMA9skISAu0dMYBBJmFtCR
	eNf3gBnClpfY/nYO8wRGwVlIts1CUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboW
	ermZJXqpKaWbGCHhLbKD8chJuUOMAhyMSjy8BW9zgoVYE8uKK3MPMUpyMCmJ8opuAQrxJeWn
	VGYkFmfEF5XmpBYfYpTgYFYS4d0BUs6bklhZlVqUD5OS5mBREuf9tljdT0ggPbEkNTs1tSC1
	CCYrw8GhJMG77RNQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoeuOLgfELkuIB
	2jsXpJ23uCAxFygK0XqKUZfjQsOKFiYhlrz8vFQpcd5pH4GKBECKMkrz4FbAktkrRnGgj4V5
	14KM4gEmQrhJr4CWMAEt8dXPBllSkoiQkmpgdOQ52C3h7J3HcfioJ+dVK1t3vgnKpi8fHBK7
	K7rCYOpiZzvOW+5Pn1nsKPn5iOHN6idsKiL8kyV51zz8pzCDSdU0JifFed2PRUc8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248573>

On 05/09/2014 05:04 PM, David Kastrup wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 05/09/2014 02:58 AM, Felipe Contreras wrote:
>>> No tests. No chance of ever graduating.
>>>
>>> Already out-of-tree.
>>>
>>> Cc: Michael Haggerty <mhagger@alum.mit.edu>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> Thank you for your input.
>>
>> git-multimail is maintained outside of the Git project and is only
>> distributed along with Git as a convenience to Git users.  It does in
>> fact have a test suite, along with some other bits and bobs that are not
>> needed to use it, in the upstream repository at
>>
>>     https://github.com/mhagger/git-multimail
>>
>> What's more, it has a maintainer who doesn't routinely insult other
>> people on the mailing list, conduct endless and pointless flame wars,
>> think that he is superior to everybody in sight, and throw temper
>> tantrums when his rudeness, argumentativeness, and arrogance for some
>> reason don't win the hearts and minds of other contributors.
> 
> Oh come on.  Junio is not _that_ bad.

lol

I would explicitly like to thank Junio for being so patient,
imperturbable, and helpful (not to mention hard-working!).  His prompt
and always thoughtful feedback was one of the big reasons that I got
involved in Git development in the first place.

In particular, I would like to say that I am in 100% disagreement with
the criticism of Junio that some people have deFeCated onto the list
recently [1].  Junio, please don't for a minute think that the trolls'
opinions are shared by others [2].

Michael

[1] Actually, it was only one person.
[2] Actually, it is only one troll.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
