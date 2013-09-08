From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sun, 8 Sep 2013 09:11:43 +0100
Organization: OPDS
Message-ID: <28ED017444BF442D84F8003247E2DDDC@PhilipOakley>
References: <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com> <20130903111006.GJ29840@goldbirke> <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com> <20130903150855.GK29840@goldbirke> <20130903170419.GA29921@google.com> <xmqqli3co7ov.fsf@gitster.dls.corp.google.com> <20130904171356.GD2582@serenity.lan> <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com> <20130904183559.GA3465@sigill.intra.peff.net> <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com> <20130908040615.GA14019@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"John Keeping" <john@keeping.me.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	<git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 10:12:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIa6i-0000fd-RW
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955Ab3IHIMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:12:19 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:44405 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550Ab3IHILk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 04:11:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ag4MAHEwLFJOl3GZ/2dsb2JhbABagweEM4U+uRgEBAGBIhd0gSIBZwEBARMBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwEEAgUhAgIUAQQaBgcXBgESCAIBAgMBhTgHAYISI7YFkQCBKY5XgnA0gQADjw+aTIMhOw
X-IPAS-Result: Ag4MAHEwLFJOl3GZ/2dsb2JhbABagweEM4U+uRgEBAGBIhd0gSIBZwEBARMBBAEBBQgBARkVHgEBIQsCAwUCAQMOBwEEAgUhAgIUAQQaBgcXBgESCAIBAgMBhTgHAYISI7YFkQCBKY5XgnA0gQADjw+aTIMhOw
X-IronPort-AV: E=Sophos;i="4.90,863,1371078000"; 
   d="scan'208";a="587795513"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with SMTP; 08 Sep 2013 09:11:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234217>

From: "Jeff King" <peff@peff.net>
Sent: Sunday, September 08, 2013 5:06 AM
> Was there some objective argument made that I missed?
> 
>> Here's more; human semantics:
>> 

Isn't this one of those "pick any two from three" tasks:
     'human', 'objective', 'argument'.

Only 1/6 of the time is an 'objective' answer the result. 

Philip
"Between thee and me there's nowt so queer as fowk,
and I ain't so sure about thee." old Yorkshire saying.

 
