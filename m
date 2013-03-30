From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug in "git rev-parse --verify"
Date: Sat, 30 Mar 2013 09:09:20 +0100
Message-ID: <51569DB0.1010102@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com> <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net> <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu> <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu> <7vboa1qtnb.fsf@alter.siamese.dyndns.org> <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 09:09:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULqrN-0002Xe-7t
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 09:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab3C3IJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 04:09:27 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:60794 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751Ab3C3IJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 04:09:25 -0400
X-AuditID: 1207440f-b7f466d0000009dc-c6-51569db3fd91
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 23.55.02524.3BD96515; Sat, 30 Mar 2013 04:09:23 -0400 (EDT)
Received: from [192.168.69.140] (p57A2472C.dip.t-dialin.net [87.162.71.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2U89LMn027948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 30 Mar 2013 04:09:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqLt5bligwd6NehZdV7qZLBp6rzBb
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDOW7l/DUjCPo+LYr9tsDYwX
	2LoYOTkkBEwkrt69wghhi0lcuLceKM7FISRwmVHi76WPUM5pJokzn6aAdfAKaEus6F3CDmKz
	CKhKNP+9A9bNJqArsainmQnEFhUIk9h7YRpUvaDEyZlPWEBsEQE1iYlth4BsDg5mAVeJzzOS
	QMLCAjoSx3s6wEqEBJYxS9y8YwticwqYSczafh9sFTNQzbu+B8wQtrzE9rdzmCcwCsxCsmEW
	krJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJXf4djF3rZQ4x
	CnAwKvHwSqwKDRRiTSwrrsw9xCjJwaQkyvt0RligEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFe
	UZAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mCN2AOUKNgUWp6akVa
	Zk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFLji4GxCpLiAdorPRtkb3FBYi5QFKL1FKMuR9ei
	z68YhVjy8vNSpcR560B2CIAUZZTmwa2AJapXjOJAHwvzxoBU8QCTHNykV0BLmICWLP8aDLKk
	JBEhJdXAyNTb+bOc09NrzseTq8VLOzhlu9/WLA8TnLD17zP/32fWzH9fF9zoevri7nWRH5V3
	7E9MnPygdklsyZOtd0Jdtvw8+UnlFyvr9Wa2jGsPhQUyHmawncxonvWuqVpz45Hp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219566>

On 03/30/2013 08:05 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> What we may want is another type peeling operator, ^{object}.
>> that makes sure it is an object, like this:
>>
>>     rev-parse --verify 572a535454612a046e7dd7404dcca94d6243c788^{object}
>>
>> It asks "I have this 40-hex; I want an object out of it", just like
>> frotz^{tree} is "I have 'frotz'; I want a tree-ish" for any value of
>> 'frotz'.
>>
>> With that, a use case that it wants to see _any_ object can safely
>> use 'rev-parse --verify "$userinput^{object}' without an annotated
>> tag getting in the way.
>>
>> How does that sound?
> 
> Perhaps something like this.  Note that the last hunk is unrelated
> thinko-fix I noticed while browsing the code.

Sounds reasonable to me.  I'm not familiar with this code, but your
change looks simple enough.  Plus documentation change in
Documentation/revisions.txt, of course.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
