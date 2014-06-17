From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: ISO 13485
Date: Tue, 17 Jun 2014 21:03:59 +0100
Organization: OPDS
Message-ID: <0C346DC34D5E4A4F92F12D0956DBA4BB@PhilipOakley>
References: <539F09B9.3050200@omixon.com> <9738CF1519014998B579C405EB4FA22B@black> <53A05766.7060502@omixon.com> <0368137BF4DA4E798A17D74DAFE30FEF@black>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jason Pyeron" <jpyeron@pdinc.us>, <git@vger.kernel.org>
To: "'agi'" <agnes.pasztor@omixon.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 22:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwzbv-00078h-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 22:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318AbaFQUD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 16:03:59 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:26684 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932927AbaFQUD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 16:03:58 -0400
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.1 cv=Qigz/So3gzN3zQ5CgEA2p4hDzanmeghV4jzKA5NXKmc= c=1 sm=2
 a=JZniprFAKO4A:10 a=JdeMvdncyXcA:10 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=u8UiU1VEAAAA:8 a=TtD5v-tNeFYClzR9K94A:9 a=wPNLvfGTeEIA:10
 a=t6RrJt_LAUoA:10 a=AvjA5PaQrVAA:10 a=BCw6_c1F5CgA:10 a=vTWJjopydO0A:10
 a=NWVoK91CQyQA:10
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AickAIWeoFMCYJLo/2dsb2JhbABXA4MNUhSIbbsEBQECAQEMgQMXdYN+BQEBBAEIAQEuHgEBIQUGAQEDBQIBAxUBAgklFAEEGgYHFwYTCAIBAgMBA4gmDAmzIpgXF4tXgnkWEBgdgn+BFgSEYwKFIIZahVWXZ4NBPIEzJA
X-IPAS-Result: AickAIWeoFMCYJLo/2dsb2JhbABXA4MNUhSIbbsEBQECAQEMgQMXdYN+BQEBBAEIAQEuHgEBIQUGAQEDBQIBAxUBAgklFAEEGgYHFwYTCAIBAgMBA4gmDAmzIpgXF4tXgnkWEBgdgn+BFgSEYwKFIIZahVWXZ4NBPIEzJA
X-IronPort-AV: E=Sophos;i="5.01,496,1400022000"; 
   d="scan'208";a="650258700"
Received: from host-2-96-146-232.as13285.net (HELO PhilipOakley) ([2.96.146.232])
  by out1.ip01ir2.opaltelecom.net with SMTP; 17 Jun 2014 21:03:57 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251946>

Agnes,

I'd like to re-emphasise Jason's excellent comments, below:

From: "Jason Pyeron" <jpyeron@pdinc.us>
>> From: agi
>> Sent: Tuesday, June 17, 2014 10:58
>>
>> Hi Jason,
>>
>> Thanks for the speedy reply. We are in the process of trying
>> to make our
>> software product ISO13485 compatible and we are assessing all systems
>> that we use.
>> Do you have a validation document for git that could provide
>> information
>> on how to use it in order to comply with ISO legislations?
>
> That would be customized to your QA process. A generalized document 
> would be too
> vague. I am sure any process consultant could draft that up for you.
> (disclaimer: I have been paid to do things like this before)
>
> Maybe you could start by searching with things like
> https://www.google.com/search?q=using+QA+with+Git or contacting 
> Atlassian about
> their QA product suite integration with Git.
>
> Maybe you could find a process consultant to do it cheaper if you 
> release it out
> to the FOSS community?
>
> The "nice" (read as less effort) thing about ISO 13485 is it:
> *     does not have a continual improvement requirement
>           so as long as "defects" are detected and
>             remediated you are good.
That detection is part of your wider QA system.

> Please note:
> *     git does not detect defects,
> *     git does not remediate defects.

That's not the job of Git (or any version control system and it's 
repository).

> What git does is:
> *     ensure the approved artifact is unchanged in any attribute
>        to maintain the exact level of quality from first inspection
>       of that artifact for an unlimited amount of iterations.
> *    Git has built in "digital signatures" on the artifacts stored in 
> its repository.
>
These are the big points. The fact that everything is fully 'signed' by 
the sha1 and can't be altered is the guarantee that runs all the way up 
and down the git commit heirachy. If you have the same sha1 you have the 
same (identical, byte for byte) history - fsck will check all the way 
down to the very first entry.

You can also tag specific points as formal releases to simplify the 
association of a nice name to a specific sha1. The releaser can even gpg 
sign it.

You still need to ensure you take formal backups and archives in the 
usual way, though Git gives you extra security because of the implicit 
duplication among developers, readers and contributors.

As an aside, branching[1] allows developers to still tidy up their work 
(rebase etc) before it is accepted as part of the release software. That 
work still has its sha1 signatures, whether for the prior 'ugly' work or 
new sha1 signatures for the 'tidy' work that is / hopes to be 
incorporated into the release.

>> Any additional information or material you can think of is more than
>> welcome.
>>
>> Thanks in advance for your help!
>>
>>
>> Best Regards,
>> Agnes Pasztor
>>
>> Senior Test Engineer
>> Omixon Biocomputing Ltd.
>>
>>
>> On 06/16/2014 05:20 PM, Jason Pyeron wrote:
>> >> -----Original Message-----
>> >> From: agi
>> >> Sent: Monday, June 16, 2014 11:14
>> >>
>> >> Hello,
>> >>
>> >> I would like to ask a question about GIT v. 1.7
>> >>
>> >> Is it compatible with ISO 13485 (quality management system)?
>> >> Can it be
>> >> used for developing a medical diagnostic software?
>> > Yes.
>> >
>> > Now, do you have a specific question about how to use Git
>> in your QA process?
>
> --
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> -                                                               -
> - Jason Pyeron                      PD Inc. http://www.pdinc.us -
> - Principal Consultant              10 West 24th Street #100    -
> - +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
> -                                                               -
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> This message is copyright PD Inc, subject to license 20080407P00.
>
[1] Branching is part of the strength of Git's "DAG" (Directed Acyclic 
Graph) structure.

Philip. 
