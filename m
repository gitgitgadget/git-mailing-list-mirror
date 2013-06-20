From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Thu, 20 Jun 2013 21:49:57 +0100
Organization: OPDS
Message-ID: <E1FE663A82E6499AA9B598B4F60A5CE6@PhilipOakley>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com><1371640304-26019-4-git-send-email-artagnon@gmail.com><7v38sdzx8o.fsf@alter.siamese.dyndns.org><7vk3lpwkt6.fsf@alter.siamese.dyndns.org><CALkWK0=v25wC1r8ScUkKDhFjctZCDLJtpDx2g2avyYgJVmZCWg@mail.gmail.com> <7vd2rgtwl3.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uplni-0008If-P8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935392Ab3FTUtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:49:47 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:54117 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935359Ab3FTUtq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 16:49:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArsNAFZqw1FZ8YFK/2dsb2JhbABbgwmJO7ZsBAEDAX0XdIIeBQEBBAEIAQEuHgEBIQsCAwUCAQMVAQIJJRQBBAgSBgcXBgESCAIBAgMBh2sDCQqzYw2IUoxkgXtqgwdhA4hphgeGbI4HhSSDEDs
X-IronPort-AV: E=Sophos;i="4.87,907,1363132800"; 
   d="scan'208";a="422592351"
Received: from host-89-241-129-74.as13285.net (HELO PhilipOakley) ([89.241.129.74])
  by out1.ip05ir2.opaltelecom.net with SMTP; 20 Jun 2013 21:49:42 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228537>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, June 20, 2013 8:23 PM
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>>> Decouple `simple` from `upstream` completely, and change it to mean
>>>> `current` with a safety feature: a `push` and `pull` should not be
>>>> asymmetrical in the special case of central workflows.
>>>
>>> Double negation confused my parser.  'push' and 'pull' should be
>>> kept symmetrical in central workflows?
>>
>> They're not the same thing.  It is very much intentional and 
>> intended:
>> the safety net is not to "ensure that the push and pull are
>> symmetrical" (i.e. among other things, error out if
>> branch.$branch.merge is unset), but rather "ensure that the push and
>> pull are never asymmetrical".
>
> Hmmmm....
>
>    not to "ensure that the push and pull are symmetrical"
>    rather "ensure that the push and pull are never asymmetrical".
>
> They still talk the same thing to me.  What am I missing?
>
> Am I being clueless, or is there something else going on?

I think it is a case of the user having explicitly set push=Africa and 
pull=Europe which can't be a setting for simple symmetry.
But then again I haven't been following the fine details. (that is there 
are some defaults that allow stuff to be half set)

>
> Your "among other things", after reading it three times,
> unfortunately did not help clarify anything to me, so perhaps
> somebody other than me (or you for that matter) who is more clueful
> can help find a different way to explain the difference you are
> trying to express to me.
>
> Help, anybody?
>

Philip

[...] 
