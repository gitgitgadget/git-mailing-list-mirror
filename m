From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: GPL v2 authoritative answer on stored code as a derived work
Date: Sun, 31 Jan 2016 20:51:50 -0000
Organization: OPDS
Message-ID: <048D782021FA455EBF38AD0C1E3C39BC@PhilipOakley>
References: <6D15DFBB73355B4E9EFB1AD5EF9FCA3184242757@NZ-EXCHANGE1.fphcare.com> <xmqqzivtfphe.fsf@gitster.mtv.corp.google.com> <C0429EC95C2F44528E2A1336FB7A2D98@PhilipOakley> <alpine.DEB.2.20.1601280913450.2964@virtualbox>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Smith" <Jonathan.Smith@fphcare.co.nz>,
	<git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 21:52:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPyz0-0002qa-5C
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 21:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466AbcAaUvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 15:51:51 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:61158 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963AbcAaUvu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2016 15:51:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DUHwATc65WPAYjFlxdGQEBAQELAQIBAQECgwpSbYdNgQuwE4MMDBgKhWMBAQIBAwEBgSQ9EAEBAQEBAQEGAQEBAUEkG0EBBAkBg2wFAQEBAQIBCAEBLhYIAQEhCwIDBQIBAxUBAgklFAEEGAIGBwMUBggLCAIBAgMBAwkEh2UDCgwKtHWIGAwehg+EN4I3hSaBDwWNXYkSAYE5hA2JX0qDeIhTimyDUjeCLRmBUTwuAYNYgi6CdgEBAQ
X-IPAS-Result: A2DUHwATc65WPAYjFlxdGQEBAQELAQIBAQECgwpSbYdNgQuwE4MMDBgKhWMBAQIBAwEBgSQ9EAEBAQEBAQEGAQEBAUEkG0EBBAkBg2wFAQEBAQIBCAEBLhYIAQEhCwIDBQIBAxUBAgklFAEEGAIGBwMUBggLCAIBAgMBAwkEh2UDCgwKtHWIGAwehg+EN4I3hSaBDwWNXYkSAYE5hA2JX0qDeIhTimyDUjeCLRmBUTwuAYNYgi6CdgEBAQ
X-IronPort-AV: E=Sophos;i="5.22,377,1449532800"; 
   d="scan'208";a="115889486"
Received: from host-92-22-35-6.as13285.net (HELO PhilipOakley) ([92.22.35.6])
  by out1.ip02ir2.opaltelecom.net with SMTP; 31 Jan 2016 21:46:24 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285171>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sent: Thursday, January 28, 2016 8:16 AM
> Hi Philip,
>
> On Wed, 27 Jan 2016, Philip Oakley wrote:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>> > Jonathan Smith <Jonathan.Smith@fphcare.co.nz> writes:
>> >
>> > > It's pretty clear that code stored in a Git repository isn't
>> > > considered a derived work of Git, regardless of whether it is used
>> > > in a commercial context or otherwise.
>>
>> I'm guessing here, but I suspect that while its 'pretty clear' to 
>> Jonathan,
>> that he has met others who aren't so clear or trusting, and it's that
>> distrustful community that would need convincing.
>
> It is not so much distrust as something you could take to court, I guess,
> because an *authoritative* answer was asked for. Now, the question is a
> legal one, so it is pretty clear (;-)) to me that only a lawyer could give
> that answer.
>
> Having said that, I know of plenty of companies storing their proprietary
> code in Git repositories, and I would guess that they cleared that with
> their lawyers first.

I've had a look though the various FAQs and other discussions about the
GPL and the FUD associated with it.

I've put together an outline of a patch to the git(1) man page, with commit
message to explain the issues (the lawyers need pointing in the right 
direction
so they can think clearly, rather than give the usual 'No' answer ;-)

Having it in $gmane at least captures the rationale, even if the patch goes
nowhere.

>
> Jonathan, please do not take that as any indication that I try to give
> this answer: if you want an authoritative answer to your question, you
> really need to consider asking a lawyer.
>
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
