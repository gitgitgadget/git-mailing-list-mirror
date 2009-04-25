From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 15:36:24 -0400
Message-ID: <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 21:38:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxnhI-0001RB-QT
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 21:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZDYTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 15:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZDYTg1
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 15:36:27 -0400
Received: from boost-consulting.com ([206.71.190.141]:64377 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbZDYTg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 15:36:27 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id A2CC81CC1F;
	Sat, 25 Apr 2009 12:33:53 -0700 (PDT)
In-Reply-To: <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117575>


On Apr 25, 2009, at 3:24 PM, Felipe Contreras wrote:

> On Sat, Apr 25, 2009 at 10:16 PM, Michael Witten  
> <mfwitten@gmail.com> wrote:
>> On Sat, Apr 25, 2009 at 13:55, Daniel Barkalow  
>> <barkalow@iabervon.org> wrote:
>>> On Fri, 24 Apr 2009, Michael Witten wrote:
>>>
>>>>> And the term is already in use for this particular case,
>>>>> and it doesn't mean anything else at all (since, of course, the  
>>>>> crypto
>>>>> thing is "SHA-1", not "sha1"), and it's short (which is  
>>>>> important for
>>>>> making it easy to look at usage help).
>>>>
>>>> What happens when SHA-1 is shown to be broken or there is a better
>>>> alternative? Then we'll see "sha1 for historical reasons"... bleh!
>>>
>>> Why do you think SHA-1 has anything to do with it?
>>
>> Well, it's named sha1.
>>
>>> Git's sha1s could just
>>> as easily be 160 bits of a SHA-256 hash and there wouldn't be any
>>> user-visible difference. The term doesn't imply any particular  
>>> significant
>>> connection to a particular algorithm.
>>
>> Then give it a generic name like 'hash'.
>
> For most purposes in the documentation sha1's are used as ids, so why
> don't use "id" instead? Like 'commit id'. The fact that the id is also
> a hash sum is hardly relevant for the user.


Where it's relevant when the user notices that two distinct files have  
the same id (because they happen to have the same contents) and  
wonders what's up.

It's not a foregone conclusion that objects with the same value have  
identical ids, but it's immediately apparent if the id is known to be  
a hash.

--
David Abrahams
BoostPro Computing
http://boostpro.com
