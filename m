From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 18:20:54 +0700
Message-ID: <CACsJy8A7pP=Hj2=-6iCqK9qXrC0pe2-A-YE4qoSRxhTX7=OvWQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz> <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
 <7vd2ryueuu.fsf@alter.siamese.dyndns.org> <CAMP44s2f2RBGd0VwJaSB1FkHBXRGhrTs_sA80kcinmpzJX8UDg@mail.gmail.com>
 <7vsj0tsnjw.fsf@alter.siamese.dyndns.org> <CAMP44s2FaoL5T+eG9mKua1U5PN9SURtXOE_YE8WO8cUusf=mBw@mail.gmail.com>
 <CACsJy8BngfgTfXDXvzjmu0t__86LAivP+_VhGUSXmG5hTnM9SA@mail.gmail.com> <CAMP44s1JdakrtcaXbO0rxob7+NPCo-Bp4uGO6-6-o3ACriOwhg@mail.gmail.com>
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
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 13:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHDF-0007OT-2d
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 13:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab3FHLV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 07:21:26 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52908 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab3FHLVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 07:21:25 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so7785885obc.27
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/m+dMzgpfX9te84sZd4IvHQsJZ9uvfbIQO+bCBi3P7g=;
        b=ZrqAlV870h+/ztAwOvsROcTBW+ovlYB72nfcdb8erHj/T0os0r33CDfpuInHJLX7LM
         IWr31o9J/cyrVMJXzcVicpYeST6M2F0cscYZokZ+1nrLPFzGqIRXRkAP5kHRVD57rFhw
         AFjtr5fMv3jyYPhcmAYLRIvs71/9VHmifnLVkiVUHFES8VlJembhfj5/bPuum60LkcQJ
         DWKs8LeZGvAZTpdDLqSCdaPvH+LwEgXk6K4zSg4+a1sp5tuFTbJF1Wo1U1rAE+QtL9+x
         2PJsvLzVjc5AVSKw6U9bjJ6VxesRiLKpH9WgrE4ydToxEMF0y3qXTV9f6ELmc4dzjGdr
         F6hA==
X-Received: by 10.60.50.202 with SMTP id e10mr1925218oeo.42.1370690485383;
 Sat, 08 Jun 2013 04:21:25 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 04:20:54 -0700 (PDT)
In-Reply-To: <CAMP44s1JdakrtcaXbO0rxob7+NPCo-Bp4uGO6-6-o3ACriOwhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226800>

On Sat, Jun 8, 2013 at 5:08 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Jun 7, 2013 at 9:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jun 8, 2013 at 3:24 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>>> The reviewer pool for code written in a new language _must_ be
>>>> seeded by some from the current set of reviewers whose judgement
>>>> I/we can trust.
>>>
>>> By that standard nothing will ever change. Ever.
>>>
>>> Even twenty years from now, you will still only trust people that are
>>> familiar with shell, Perl, and C. Because the only way to gain your
>>> trust, is by being proficient in shell, Perl, and C.
>>
>> I don't see why a trusted person cannot learn a new language and
>> convince the community to give it a try (well given that enough
>> reviewers support the new language, which was Junio's point).
>
> I do. Raise your hand if you are interested in giving a try to Ruby
> for Git's core given that somebody gives convincing reasons?

Personally, no additional runtime dependency > Ruby > Python. I don't
think Ruby is available on SunOS and I prefer not to build and install
Python nor Ruby myself to be able to use Git. So no hands from me.

> How many hands do you expect?

If not many hands show up, the Git community clearly is not ready to
adopt Ruby. Maybe ask again next year when Ruby is getting more
popular?
--
Duy
