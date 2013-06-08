From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 05:08:28 -0500
Message-ID: <CAMP44s1JdakrtcaXbO0rxob7+NPCo-Bp4uGO6-6-o3ACriOwhg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
	<CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
	<alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
	<CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
	<7vd2ryueuu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
	<7vsj0tsnjw.fsf@alter.siamese.dyndns.org>
	<CAMP44s2FaoL5T+eG9mKua1U5PN9SURtXOE_YE8WO8cUusf=mBw@mail.gmail.com>
	<CACsJy8BngfgTfXDXvzjmu0t__86LAivP+_VhGUSXmG5hTnM9SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Lang <david@lang.hm>, Greg Troxel <gdt@ir.bbn.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 12:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlG4Y-0006hm-L8
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 12:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab3FHKIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 06:08:31 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:34851 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3FHKIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 06:08:30 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so4454968lab.18
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MQi+NmrSRKToKTy+WsnlivMtdp/JL8n+D3IjZD/rn0I=;
        b=JfPazE29FEblai72GYtbtI8woY+x7WORt2ULxP5m3HthPJ3NdWFNoBJnto7ORpNuHV
         Ir+tn1oYIuQyDmU86ZdaC5EKAMcOOLPc05f4PTGSSAN47+MafI73mvMsrdJHuChw9uM3
         6ejf9R2a7n2BDSeG40pCmJsJeHg+V2Y5LnR1QkLktTaE77dJJZF1rEVEfHphHxcn7C8M
         +wW4hM2LwfEVEnlnaxYHmQChsTh4twY/oFSZFEoJuqHJ7egS6jEIoezJ16cZzxMZyDBd
         JSwii7K2LL3M0OeAeh7zvdafskfIYX8O8gdX9cbM1d5D5uPOzGos2U1csKM/zsTMAZbZ
         LjWA==
X-Received: by 10.112.52.97 with SMTP id s1mr2887315lbo.8.1370686108562; Sat,
 08 Jun 2013 03:08:28 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 03:08:28 -0700 (PDT)
In-Reply-To: <CACsJy8BngfgTfXDXvzjmu0t__86LAivP+_VhGUSXmG5hTnM9SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226795>

On Fri, Jun 7, 2013 at 9:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 3:24 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>> The reviewer pool for code written in a new language _must_ be
>>> seeded by some from the current set of reviewers whose judgement
>>> I/we can trust.
>>
>> By that standard nothing will ever change. Ever.
>>
>> Even twenty years from now, you will still only trust people that are
>> familiar with shell, Perl, and C. Because the only way to gain your
>> trust, is by being proficient in shell, Perl, and C.
>
> I don't see why a trusted person cannot learn a new language and
> convince the community to give it a try (well given that enough
> reviewers support the new language, which was Junio's point).

I do. Raise your hand if you are interested in giving a try to Ruby
for Git's core given that somebody gives convincing reasons?

How many hands do you expect?

-- 
Felipe Contreras
