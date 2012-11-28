From: David Aguilar <davvid@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 00:04:13 -0800
Message-ID: <CAJDDKr6n2KSZz5zPHeWiYHAP7Zr02Ti-e24AX1yR_XAXAKhscg@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
	<20121128075807.GA9912@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Nov 28 09:04:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdcdB-00034c-NM
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 09:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab2K1IEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 03:04:15 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57066 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab2K1IEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 03:04:14 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so9877232vcm.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 00:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FtXAiQmbzlCjSA/fNKFnnVqy/7u843l9NgBDYAjd+Tg=;
        b=RVIb9ZjcYPXZbFOilUGSmrdC+9BVaKihedc5GtJI8wY22RhtwG9SpPWzScmLMmM+JE
         DJWg9PV8qED6DgSIcJnRpc+xC8XplyZPTrCBM6NMtRvXcvUd0s91O6iaT/Ozbjq3+/CQ
         cmmuH5fAog3K43Z7J7QdcH4k7tnGCpLqw9SQ/R57F9yqcc4qIzc2yD2JtEOZqFi6sL+1
         iZEuGrJ53PnAlrToh2Zg8G/WrLPLqA2bKdxmfYD3LaKrPVYftrw4bdCwCliczrX9OU4O
         syFxIFmbJGOgqDOAppqVXgyX7iRE7aEAHZYG1UpT9Upaws99Npc3u0qrTUmdHMOgy5/t
         s+LQ==
Received: by 10.52.32.1 with SMTP id e1mr24416580vdi.68.1354089853822; Wed, 28
 Nov 2012 00:04:13 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Wed, 28 Nov 2012 00:04:13 -0800 (PST)
In-Reply-To: <20121128075807.GA9912@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210719>

On Tue, Nov 27, 2012 at 11:58 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Junio C Hamano <gitster@pobox.com>:
>> Roundtrip conversions may benefit from sub-second timestamps, but
>> personally I think negative timestamps are more interesting and of
>> practical use.
>
> You mean, as in times before the Unix epoch 1970-01-01T00:00:00Z?
>
> Interesting.  I hadn't thought of that.  I've never seen a software
> project under version control with bits that old, which is significant
> because I've probably done more digging into ancient software than
> anybody other than a specialist historian or two.

One example I've heard is someone wanting to throw the history
of a country's laws into git so they can diff them.
-- 
David
