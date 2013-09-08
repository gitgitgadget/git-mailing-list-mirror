From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sun, 8 Sep 2013 08:49:12 +0100
Organization: OPDS
Message-ID: <B771340AAC04409CB0EF716FE6FC1C88@PhilipOakley>
References: <20130829180129.GA4880@nysa><xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com><CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com><b677f1ae-662f-4728-b625-189bc392c74d@email.android.com><CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com> <CAMP44s1j+ayX=cy7QJ7WXdiD9P1M6n7NgNk=oGuv1XC=dqMXVA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Piotr Krukowiecki" <piotr.krukowiecki@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
	"Piotr Krukowiecki" <piotr.krukowiecki.news@gmail.com>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Miles Bader" <miles@gnu.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Matthieu Moy" <matthieu.moy@grenoble-inp.fr>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Scott Chacon" <schacon@gmail.com>
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Drew Northup" <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 09:49:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZkK-0004Qr-UA
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab3IHHtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:49:11 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:2872 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637Ab3IHHtK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 03:49:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkAMAM4qLFJOl3GZ/2dsb2JhbABagweEM4U+uRgEBAGBIhd0aQEBgR8BARQBBAEBBQgBARkVHgEBGgcLAgMFAgEDFQEEAgUhAgIUAQQIEgYHFwYBEggCAQIDAYU4BwGCEg0DE7V7h3kNiHuBKYtpgm6CcDSBAAOPD4Z9jiCFL4MhOw
X-IPAS-Result: AkAMAM4qLFJOl3GZ/2dsb2JhbABagweEM4U+uRgEBAGBIhd0aQEBgR8BARQBBAEBBQgBARkVHgEBGgcLAgMFAgEDFQEEAgUhAgIUAQQIEgYHFwYBEggCAQIDAYU4BwGCEg0DE7V7h3kNiHuBKYtpgm6CcDSBAAOPD4Z9jiCFL4MhOw
X-IronPort-AV: E=Sophos;i="4.90,863,1371078000"; 
   d="scan'208";a="422196729"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 08 Sep 2013 08:49:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234213>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Sunday, September 08, 2013 2:33 AM
[snip...]
> The snapshot concept is totally orthogonal from the staging area
> concept. Git works in snapshots, which are frozen images of how the
> content tree was at a certain point in time; IOW; a commit.

(I feel that) In most peoples minds the need for a staging area, and the 
use of snapshots, are related. Part of that relationship, often not 
noticed by those folks, is that they are 'orthogonal' to *each other*. 
Thus orthogonality means both un-related, and related at the same time 
(aren't we humans peculiar!). They are cleaved to each other.

When trying to explain staging/index I tend to use the analogy of an old 
style office (I am almost that old) where one has an In tray and an Out 
tray on one's desk (and one parked WIP for lunch time desk tidy), and 
the staging area is the basket at the end marked 'For Filing'. When the 
'For Filing' basket is ready, one called the filing clerk to dictate the 
cover note and away it went, commited to some remote filing repository. 
Oh how things have changed ;-)

>
> _How_ that snapshot is created is an entirely different topic, and the
> staging area is a tool to create the desired snapshots. The user might
> decide to never use that tool (i.e. always run git commit -a), but the
> concept of snapshots remain. So, clearly, one concept has absolutely
> nothing to do with the other.
>

The point would be that we allow a particular snapshot to be selected, 
and that the git commit -a is but one (common) method. Commit -a is like 
jumping in the car for a quick trip to the shops, while the selective 
staging of content is like packing for a holiday.
