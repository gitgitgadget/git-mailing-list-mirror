From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 09 Jul 2013 21:57:43 +0200
Message-ID: <51DC6B37.9030108@alum.mit.edu>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com> <7vk3l26695.fsf@alter.siamese.dyndns.org> <CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com> <7v38rnwuvb.fsf@alter.siamese.dyndns.org> <87ehb7d3za.fsf@hexa.v.cablecom.net> <CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com> <7vy59fv9zr.fsf@alter.siamese.dyndns.org> <87a9lvcztv.fsf@hexa.v.cablecom.net> <7vppurv8bl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwe2p-0001Na-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab3GIT5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:57:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61741 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485Ab3GIT5r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 15:57:47 -0400
X-AuditID: 12074413-b7f136d000006de1-aa-51dc6b3a4789
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 73.AA.28129.A3B6CD15; Tue,  9 Jul 2013 15:57:46 -0400 (EDT)
Received: from [192.168.69.140] (p57A24C98.dip0.t-ipconnect.de [87.162.76.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r69JvhpU003006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Jul 2013 15:57:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vppurv8bl.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqGuVfSfQ4OJFSYuuK91MFg29V5gt
	zrxpZLS4e3kVuwOLx+3X85k9Ll5S9lj8wMvj8ya5AJYobpukxJKy4Mz0PH27BO6MWWumMxW8
	5a14+eEwSwPjM64uRk4OCQETiT+vGpggbDGJC/fWs3UxcnEICVxmlGibv5kJwjnHJDFpz15W
	kCpeAW2JE59/MYLYLAKqEk07e5hBbDYBXYlFPc1ADRwcogJhEld+q0KUC0qcnPmEBcQWEVCT
	mNh2CMxmFiiV6Gg/CzZGWMBSouvuW2aIXYeZJTYcPckGkuAUMJPYc+IeE0SDjsS7vgfMELa8
	xPa3c5gnMArMQrJjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p
	3cQICWfhHYy7TsodYhTgYFTi4T2gcCdQiDWxrLgy9xCjJAeTkijvj2SgEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRHeJD6gHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJ
	glcmC6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDtFQNp5y0u
	SMwFikK0nmLU5TjwY8t7RiGWvPy8VClx3leZQEUCIEUZpXlwK2DJ6xWjONDHwrwqIKN4gIkP
	btIroCVMQEv2pIAtKUlESEk1MBp8u1ljI9g4x4RR1SV+8TLpmO0n8hY6poXsPvuE801kgsqt
	q0904m8/+z1doEGq2p8xn3dtslvN6fmG0vLulftLVvg9PVcX6+Piuey99LfGAxsO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229995>

On 07/09/2013 09:31 PM, Junio C Hamano wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
> 
>> If you define it that way, the output of
>>
>>   git blame -L 4,6; git blame -L /A/,+20
>>
>> is significantly different from
>>
>>   git blame -L 4,6 -L /A/,+20
>>
>> Not just in the presentation or any possible coalescing, but in the
>> meaning of the ranges.
>>
>> Do you really want to make it that way?
> 
> Absolutely.  The primary reason I want to be able to specify two
> ranges at the same time is to follow two functions in a file that
> appear in separate places, and /A/ might not be unique.  When I want
> to say "I want to see from here to there, and then from here to
> there, and then from here to there", it would be very frustrating if
> "and then" resets what I mean by "here" every time and make these
> three evaluated independently.

It would be more general to support "follow the second match to /A/"
*independent* of whether the first match is also followed.  I think your
proposal only allows the second to be followed if the first is also
followed.  Therefore it seems to me that your wish is to add a
side-effect to one feature so that you can use it to obtain a simulacrum
of a second feature, instead of building the second feature directly.

Perhaps allow <start> and <end> to be a sequence of forms like

/A//A/,+20

    Start at the second occurrence of /A/ an continue for 20 lines

/A/+20,/B/

    Start 20 lines after the first match of /A/ until the subsequent
match of /B/

E.g., the body of function "foo" would be '/^int foo//^{/+1,/^}/-1'.
That should provide hours of amusement to baffled users ;-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
