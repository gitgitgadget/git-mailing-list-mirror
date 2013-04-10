From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 10 Apr 2013 08:23:46 +0100
Organization: OPDS
Message-ID: <2B3B803A74A34749B8174B7C901A076A@PhilipOakley>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>   <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com> <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com> <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com> <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com> <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com> <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com> <7v1ual12pj.fsf@alter.siamese.dyndns.org> <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com> <7va9p8yjuf.fsf@alter.siamese.dyndns.org> <CALkWK0m4o=F=bh_mt9NGDfXKExgVtLhaZ7uxA_XFhpF5AN5-Fg@mail.gmail.com> <7vk3ocx0qq.fsf@al
 ter.siamese.dyndns.org> <CALkWK0npHgsf_TyjrMRJdcT-twg_jRXOHtoNpmX+2XNeLq=ZAQ@mail.gmail.com> <7v8v4swysv.fsf@alter.siamese.dyndns.org> <CALkWK0mG6FFd_K1Ei-r--58i0j94or5240k1hEVbed8kJ+ZURw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Duy Nguyen" <pclouds@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	"John Keeping" <john@keeping.me.uk>,
	"Git List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 09:23:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPpNo-0005yb-1B
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 09:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936379Ab3DJHXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 03:23:47 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59717 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934080Ab3DJHXq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 03:23:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar0NAE8SZVFZ8Yth/2dsb2JhbABRgwY2gyuFP7g1BAEDAYEXF3SCGgUBAQUIAQEZFRENAQEhCwIDBQIBAw4HAQQCBSECAhQBBAgSBgcXBgESCAIBAgMBh3EDEwirfIhsDYldgSOLHoFpaoI1MmEDjjqGXY1VhRyDDDs
X-IronPort-AV: E=Sophos;i="4.87,444,1363132800"; 
   d="scan'208";a="425240542"
Received: from host-89-241-139-97.as13285.net (HELO PhilipOakley) ([89.241.139.97])
  by out1.ip01ir2.opaltelecom.net with SMTP; 10 Apr 2013 08:23:43 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220671>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Monday, April 08, 2013 10:03 PM
> This is going nowhere.  You're stuck at making the current submodule
> system work, not answering my questions, diverting conversation,
> repeatedly asking the same stupid questions, labelling everything that
> I say "subjective", and refusing to look at the objective counterpart
> (aka, the code).  It's clear to me that no matter how many more emails
> I write, you're not going to concede.
>
> I'm not interested in wasting any more of my time with this nonsense.
>
> I give up.
> --
Please don't "give up". It is a bit of a 'wicked' problem [1].

Yes to taking a rest, stepping back and trying to summarise/review what 
was discussed.

I couldn't keep up with all the discussion, and I doubt many others kept 
up, especially those who have been frustrated in their (mis-) use of 
submodules. Do remember that Junio has multiple roles which belie the 
softness of the word 'maintainer'. It includes "Defender of the 
Heritage" in the same way that keepers of ancient monuments will want 
visitors to enjoy the site, but rail against a garish new stainless 
steel and glass entrance to the Colosseum (choose you local heritage 
site) (see [1] again).

I get confused (about sub-modules) with msysgit where git.git is a 
sub-module, and is the fastest moving (an inversion of control issue), 
and when hacking at (just) the msys level when the git sub-module isn't 
in sync.

In many ways sub-module tracking is like file renames and empty 
directories (both of which come up a lot). The submodule meta 
information issue has great similarity to the empty directories issue. 
It's about meta information, not about content (which is certified 
verified by sha1), and about how users know what is going on and get a 
(natural) feeling of control (without upsetting other users/controllers) 
.

regards

Philip
[now to schedule some time to do the catch up reading. $dayjob beckons]

[1] www.poppendieck.com/wicked.htm 
