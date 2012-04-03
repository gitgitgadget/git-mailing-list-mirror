From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Mon, 02 Apr 2012 23:55:02 -0600
Message-ID: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org> <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com> <201204021049.04901.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com> <20120402203728.GB26503@sigill.intra.peff.net> <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Shawn Pearce <spearce@spearce.org>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 07:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEwku-0003Lv-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 07:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab2DCF6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 01:58:07 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11683 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2DCF6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 01:58:06 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6668"; a="176026326"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 02 Apr 2012 22:58:04 -0700
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 1F46110004AA;
	Mon,  2 Apr 2012 22:58:04 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194594>



Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> we could even store the data in a separate file to
>> retain indexv2 compatibility).
>>
>> So it's sort-of a cache, in that it's redundant with the actual data.
>> But staleness and writing issues are a lot simpler, since it only
>gets
>> updated when we index the pack (and the pack index in general is a
>> similar concept; we are "caching" the location of the object in the
>> packfile, rather than doing a linear search to look it up each time).
>
>I think I have something like that, (generate a machine-friendly
>commit cache per pack, staying in $GIT_DIR/objects/pack/ too). It's
>separate cache staying in $GIT_DIR/objects/pack, just like pack-.idx
>files. It does improve rev-list time, but I'd rather wait for packv4,
>or at least be sure that packv4 will not come anytime soon, before
>pushing the cache route.

I would love to try those patches out if you have them?

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
