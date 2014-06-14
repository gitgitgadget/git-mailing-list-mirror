From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Sat, 14 Jun 2014 11:24:33 +0100
Organization: OPDS
Message-ID: <01A8C25BF47246C7AB925EFA1C07D26C@PhilipOakley>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>		<xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>	 <xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>	 <53969FDF.3050506@viscovery.net> <1402622313.5629.45.camel@stross> <539A79F6.9020905@web.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>, <mhagger@alum.mit.edu>
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"David Turner" <dturner@twopensource.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 12:43:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvlQX-0000FB-ML
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 12:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaFNKmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2014 06:42:16 -0400
Received: from b219.a.smtp2go.com ([216.22.18.219]:48590 "EHLO
	b219.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaFNKmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2014 06:42:15 -0400
X-Greylist: delayed 1055 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jun 2014 06:42:15 EDT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251657>

=46rom: "Torsten B=C3=B6gershausen" <tboegi@web.de>
> On 2014-06-13 03.18, David Turner wrote:
> []
>>
>> It is too old for my patch because it doesn't support ifunc (and I
>> suspect that no version of GCC for Windows supports ifunc).  But tha=
t
>> does not seem to be what is going on in your error message.  Instead=
,
>> when we #include <cpuid.h>, we get compat/cpuid.h rather than the
>> system's cpuid.h. When I rename compat/cpuid.h to something else
> compat/git_cpuid.h ?
>
>> I'm testing on a Windows 8 VM from modern.ie with msysgit's
>> "netinstaller" -- is that a reasonable test environment?
>
> Many people are using Windows 7,
> and we shouldn't break for things for Windows XP.
>
I'd like that.
--
Philip
sent from my XP netbook;-)
