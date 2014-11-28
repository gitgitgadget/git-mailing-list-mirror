From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/1] change contract between system_path and it's callers
Date: Fri, 28 Nov 2014 13:09:55 -0000
Organization: OPDS
Message-ID: <7FDD11B6900A41269F60C9E60A11D84C@PhilipOakley>
References: <CANCZXo4=D=RPnGeAfcvD0O1hX0B43z1b11gyzjbJYGXzusfFYg@mail.gmail.com><1416939854-29930-1-git-send-email-kuleshovmail@gmail.com><xmqqfvd7rnkb.fsf@gitster.dls.corp.google.com> <CANCZXo63q2YmTcYr9Vf99fAAnENNj7vE1nC18QJDYve=-OcXyQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Git List" <git@vger.kernel.org>
To: "Alexander Kuleshov" <kuleshovmail@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 14:09:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuLIt-0002Im-Bl
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 14:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbaK1NJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 08:09:38 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:37846 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbaK1NJh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 08:09:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq0fAAZzeFRZ8Y9EPGdsb2JhbABbgwZRh33AHIZHAQMBAYEOFwEBAQEBAQUBAQEBOCAbg30FAQEBAQMIAQEEFRUeAQENFAsCAwUCAQMVAQQCBSECAhQBBAgSBgcDFAYBEggCAQIDAYgaAxYJvBSGdYhQDYY7AQEIAQEBAR6BLo0VgjiCfzaBHwWSZW2DeoJUgk2PPYJ1ino/MIJKAQEB
X-IPAS-Result: Aq0fAAZzeFRZ8Y9EPGdsb2JhbABbgwZRh33AHIZHAQMBAYEOFwEBAQEBAQUBAQEBOCAbg30FAQEBAQMIAQEEFRUeAQENFAsCAwUCAQMVAQQCBSECAhQBBAgSBgcDFAYBEggCAQIDAYgaAxYJvBSGdYhQDYY7AQEIAQEBAR6BLo0VgjiCfzaBHwWSZW2DeoJUgk2PPYJ1ino/MIJKAQEB
X-IronPort-AV: E=Sophos;i="5.07,476,1413241200"; 
   d="scan'208";a="478058603"
Received: from host-89-241-143-68.as13285.net (HELO PhilipOakley) ([89.241.143.68])
  by out1.ip04ir2.opaltelecom.net with SMTP; 28 Nov 2014 13:09:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260362>

From: "Alexander Kuleshov" <kuleshovmail@gmail.com>
Sent: Wednesday, November 26, 2014 3:53 AM
>>
>> None of these warrant the code churn, I would say.
>
> Sorry, english is not my first language, what did you mean when
> saying:
> "code churn"? Code duplication or something else?
> --
Hi Alexander,

The term 'churn' is originally from British butter making.

Churn:
verb
  1.shake (milk or cream) in a machine in order to produce butter.
  "the cream is ripened before it is churned"
        synonyms: stir, agitate;

   2.(with reference to liquid) move or cause to move about vigorously.
  "the seas churned".


For Code (used in a somewhat negative sense), it means that lots of bits 
are moved around a great deal for
little apparent benefit.

In the sense Junio used it, I believe it's suggesting that the balance 
between the amount of change and usefulness of the change had gone 
further than hoped. (Though Junio is usually open to receiving a well 
argued case)

Philip
see also http://en.wikipedia.org/wiki/Churn_rate
