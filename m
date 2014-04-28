From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Mon, 28 Apr 2014 20:50:46 +0100
Organization: OPDS
Message-ID: <180E73BE75C845DFAE259E73AB6DC905@PhilipOakley>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-11-git-send-email-marat@slonopotamus.org> <535e923776b87_45651483310bf@nysa.notmuch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <marat@slonopotamus.org>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Marat Radchenko" <marat@slonopotamus.org>,
	"GIT Mailing-list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:50:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerZm-0004WJ-MN
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbaD1Tuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:50:50 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:7605 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752561AbaD1Tut (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 15:50:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkEXADWwXlNOl3Y1/2dsb2JhbABZgwaEC4U9vD4FAQIBAYEaF3SCIAUBAQUIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYgcAxWkcoVZlyQNhngXgSmLGIIYgnY1gRUEj2eHNYxjghaFVYMyPA
X-IPAS-Result: AkEXADWwXlNOl3Y1/2dsb2JhbABZgwaEC4U9vD4FAQIBAYEaF3SCIAUBAQUIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHFwYBEggCAQIDAYgcAxWkcoVZlyQNhngXgSmLGIIYgnY1gRUEj2eHNYxjghaFVYMyPA
X-IronPort-AV: E=Sophos;i="4.97,945,1389744000"; 
   d="scan'208";a="454153695"
Received: from host-78-151-118-53.as13285.net (HELO PhilipOakley) ([78.151.118.53])
  by out1.ip05ir2.opaltelecom.net with SMTP; 28 Apr 2014 20:50:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247423>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Marat Radchenko wrote:
>> nedalloc was initially added in f0ed82 to fix slowness of standard 
>> WinXP
>> memory allocator. Since WinXP is EOLed, this point is no longer 
>> valid.
>
> The fact that WinXP is EOLed doesn't mean people are not using it any 
> more =/
>
> I think it should be supported by Git at least for a while.
>
> -- 
> Felipe Contreras
> --
My family and I have a number of XP machines [chooses frying pan vs 
fire..]

I'd expect a lot of basic users who are more difficult to support to 
still be on XP for a while.
At least until the next big zero day weakness openss up ;-)

Philip 
