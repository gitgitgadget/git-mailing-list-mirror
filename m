From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Sat, 6 Apr 2013 15:09:10 +0100
Organization: OPDS
Message-ID: <CDBF6E3BB68D4385B19C53A447186556@PhilipOakley>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com><20130402200948.GF2222@serenity.lan><2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de><CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com><EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de><CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com><BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de> <CAMP44s10HGpfz=r1m8QRFY4V+rAOkiRaerW1T=vHz2YpbBH6Zg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "John Keeping" <john@keeping.me.uk>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	<gitifyhg@googlegroups.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Max Horn" <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWVi-0001D7-46
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974Ab3DFOJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 10:09:13 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:54984 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422972Ab3DFOJL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Apr 2013 10:09:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlgOAEgpYFFOl3a6/2dsb2JhbABRgwaDYIU/uC8EAQMBgQAXdIIaBQEBBAEIAQEZFR4BASEFBgIDBQIBAxUBAgICBSECAhQBBAgSBgcXBgESCAIBAgMBh3EDCQqsR4hMDYldgSOLJoFoaoI0MmEDjjWGWY1ShRuDDDs
X-IronPort-AV: E=Sophos;i="4.87,420,1363132800"; 
   d="scan'208";a="424864681"
Received: from host-78-151-118-186.as13285.net (HELO PhilipOakley) ([78.151.118.186])
  by out1.ip01ir2.opaltelecom.net with SMTP; 06 Apr 2013 15:09:09 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220220>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Saturday, April 06, 2013 1:45 AM
> On Fri, Apr 5, 2013 at 4:30 PM, Max Horn <max@quendi.de> wrote:
>
>> On 04.04.2013, at 08:42, Felipe Contreras wrote:
>
>> Please consider [...]

> Ultimately this is not about people, this is about the code.

In the case of helper functions this is not the case.

The question would be better framed:
"Does this, or that, helper function make users (people) feel helped, or 
frustrated (or somewhere in limbo)?".

I've called IT help desks and often felt frustrated, and some times I've 
got one of the good girls/guys who worked with me to improve my 
situation (often despite official policies). I get back to those folks 
(even if they 'failed').

It's not a binary black/white issue when real users need help. It's no 
good keeping with the faith (e.g. the Git ideal, the coders ideal, ..) 
when the users (a mixed group) environmental doctine differs.

>    A sensible person that is not emotionally attached to any code,
  [I'm thinking users here, they are emotionally attached to their 
original problem, and sense doesn't come into it]

>  would simply look at the code,
Unfortunately, even for reasonable coders, looking at the code isn't 
usually the case because of lack of time, unfamiliarity with the code, 
extent of the code, availablity of the code (they may be simply running 
a packaged/compiled 'app'), this is not that likely to happen. We should 
be thankful when folk do look.

It's hard enough to get "good" bug reports from fellow coders (they are 
only human / no more human than us) that tell us what _we_ want to know 
(rather than what _they_ remember, or was important to them). ;-)


I don't use Hg, but as I read the discussion, there are 
incomaptibilities between Git, and Hg. Thus neither helper can ever be 
perfect. The winners will be those who solve a user need with enough 
documentation and error capture to make them (their user group) feel 
happy. At the moment it looks like the discussion is stratifying into 
various "it worked for me" camps, each with their own problem children 
repos that won't respond to parental advice, even with a --force from 
social services.

Philip
[As they say back home: Between thee and me, ther's nowt so queer as 
fowk, and I ain't so sure about thee] 
