From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: GPL v2 authoritative answer on stored code as a derived work
Date: Wed, 27 Jan 2016 23:58:03 -0000
Organization: OPDS
Message-ID: <C0429EC95C2F44528E2A1336FB7A2D98@PhilipOakley>
References: <6D15DFBB73355B4E9EFB1AD5EF9FCA3184242757@NZ-EXCHANGE1.fphcare.com> <xmqqzivtfphe.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Smith" <Jonathan.Smith@fphcare.co.nz>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:58:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOZyY-0000Yn-BG
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 00:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934950AbcA0X6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 18:58:10 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27145 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933397AbcA0X6J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 18:58:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CCKgBFWalWPHwTFlxeGQEBAQELAQIBAQEBAYMKUm2HTIELsBGDFiSFYQEBAgEDAQGBSU0BAQEBAQEHAQEBAUEkG0EBBA0Bg2gFAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAQEBAgMBA4d/DAq1Y4khhguENoddgQ8FjVyJEgGBOYQNlnaOPYRMPC4BAQGDNINJgUQBAQE
X-IPAS-Result: A2CCKgBFWalWPHwTFlxeGQEBAQELAQIBAQEBAYMKUm2HTIELsBGDFiSFYQEBAgEDAQGBSU0BAQEBAQEHAQEBAUEkG0EBBA0Bg2gFAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAQEBAgMBA4d/DAq1Y4khhguENoddgQ8FjVyJEgGBOYQNlnaOPYRMPC4BAQGDNINJgUQBAQE
X-IronPort-AV: E=Sophos;i="5.22,356,1449532800"; 
   d="scan'208";a="610356876"
Received: from host-92-22-19-124.as13285.net (HELO PhilipOakley) ([92.22.19.124])
  by out1.ip03ir2.opaltelecom.net with SMTP; 28 Jan 2016 00:37:58 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284949>

From: "Junio C Hamano" <gitster@pobox.com>
> Jonathan Smith <Jonathan.Smith@fphcare.co.nz> writes:
>
>> It's pretty clear that code stored in a Git repository isn't
>> considered a derived work of Git, regardless of whether it is used
>> in a commercial context or otherwise.

I'm guessing here, but I suspect that while its 'pretty clear' to Jonathan, 
that he has met others who aren't so clear or trusting, and it's that 
distrustful community that would need convincing.

>>
>> However, I'm unable to find this stated in any authoritative and
>> unambiguous manner.

The GPL2 FAQ's (search for 'data')
http://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.html#TOCGPLOutput 
(should link to "Is there some way that I can GPL the output people get from 
use of my program? For example, if my program is used to develop hardware 
designs, can I require that these designs must be free?") and 
http://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.html#IfInterpreterIsGPL 
both cover the fact that the repo (data) is not a derived work, and thus not 
subject to GPL2.

>
> Is it reasonable to ask for such a statement?  I doubt it,
> especially if "It's pretty clear".

(Rhet) If there were to be such a statement, where should it be placed, and 
who could issue it? It couldn't be part of the COPYING licence file (because 
it's not supposed to be modified).

It could be in the User Manual, but that wouldn't carry much weight with the 
already worried, or perhaps the git(1) man page [E.g. 'discusssion' section 
maybe], or even in the git-scm.com 'book', but really it would need Jonathan 
(and others with similar FUD issues) to suggest what they'd need.

>
> Without such a statement, I think we have already seen that the
> commercial adoption is already appealing.
>

Hopefully the links can help Jonathan if he is having any local 
difficulties.

--
Philip 
