From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 23:52:19 +0100
Organization: OPDS
Message-ID: <500FC504AB174A98B31CD8BEFCDDCFAC@PhilipOakley>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com> <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com> <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com> <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com> <CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com> <xmqqio822atc.fsf@gitster.dls.corp.google.com> <CA+P7+xoV=NZvcUyqbdOpjcD1ykrpU7zrWB4JDVMSdBVC7EHEgw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	"Stefan Beller" <sbeller@google.com>,
	"Graeme Geldenhuys" <graemeg@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jacob Keller" <jacob.keller@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 00:51:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUjXh-0008Hb-4A
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 00:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132AbbHZWvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 18:51:37 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:26425 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756895AbbHZWvg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2015 18:51:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DwEgC2Qd5VPDWzBlxdGQEBAYJ/gT2DI4Mubb4uBAQCgTdNAQEBAQEBBwEBAQFBJBtBBINZBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBwMUBgESCAIBAgMBCod+Axa0H4ZYiHINhVyBIoo5gk+CO4JwL4EUBZU5AYETiS1EgzcVhzuGeYMQhzuCNRyBVT0zgk0BAQE
X-IPAS-Result: A2DwEgC2Qd5VPDWzBlxdGQEBAYJ/gT2DI4Mubb4uBAQCgTdNAQEBAQEBBwEBAQFBJBtBBINZBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBwMUBgESCAIBAgMBCod+Axa0H4ZYiHINhVyBIoo5gk+CO4JwL4EUBZU5AYETiS1EgzcVhzuGeYMQhzuCNRyBVT0zgk0BAQE
X-IronPort-AV: E=Sophos;i="5.17,419,1437433200"; 
   d="scan'208";a="616844564"
Received: from host-92-6-179-53.as43234.net (HELO PhilipOakley) ([92.6.179.53])
  by out1.ip05ir2.opaltelecom.net with SMTP; 26 Aug 2015 23:51:34 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276647>

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Wed, Aug 26, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>> But notice that I said "if you really want to".  I personally think
>> it is a road to madness.
>
> Agreed. I don't believe in command line API here. I think we'd need a
> better solution.
>
> My gut says: Live with the warts on old commands and try to make
> people use command words for new commands.
> --
Agreed. However Graeme's original question also said "I can supply a 
more extensive list if needed", and "I still have to reference the help 
to remind me of what parameter to use in certain situation", which 
suggests that one option is to capture that list within some part of the 
documentation, especially if Graeme already has an easy to read layout.

If it could be part of the documenation, where should it go - gitcli or 
perhaps it's own guide (`git help -g` and friends)?

--

Philip
