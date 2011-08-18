From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Thu, 18 Aug 2011 15:54:05 +0700
Message-ID: <CACsJy8Dr5q=h-9MhNV0gKtVEn13+DxWwcNn2Prem6-+DyrDmHA@mail.gmail.com>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com>
 <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com> <7vhb5fd4zy.fsf@alter.siamese.dyndns.org>
 <CACsJy8CX7X3u4i_kXChVHkFK=Q--pRBrxmdvjxrF7wr5_SyakA@mail.gmail.com> <4E4CBC29.7080703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Conrad Irwin <conrad.irwin@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 10:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtyNB-0000Zr-QP
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 10:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab1HRIyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 04:54:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62474 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1HRIyg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 04:54:36 -0400
Received: by bke11 with SMTP id 11so1294983bke.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oDLjilVMBoDYhE+R85h9IJIisQ7BZHJcYCS2bofQjzE=;
        b=WZ1HNHDsLkC37ykBHBGEs2SBK2jgaGQhY6l4vljfPkuLCVWDA5kuLCHOYc0UhvzZSs
         /2IiFFxFOuHZ+nuZfqu9+Ee1wjRHZUhgfTdFZEpFI/jhaUJE/hNY4DRQBPr8TPyz0wQW
         qZiKDiwFuyMpFT0kpUFzE45FjnDtYUoJlBXsk=
Received: by 10.204.231.143 with SMTP id jq15mr211125bkb.227.1313657675215;
 Thu, 18 Aug 2011 01:54:35 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Thu, 18 Aug 2011 01:54:05 -0700 (PDT)
In-Reply-To: <4E4CBC29.7080703@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179582>

On Thu, Aug 18, 2011 at 2:15 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> For a german keyboard layout, you get @{u} from
>
> hold AltGr (Meta)
> press q
> press 7
> release AltGr
> press u
> hold AltGr
> press 0
>
> For me, an improvement would be to have the alias
>
> @{=E2=86=93}

While it's convenient to type, the output now looks strange. If you do
a screencast, or someone is watching you, they may not understand what
that syntax is.

Also..

> As a simpler case, a user could tailor to her keyboard layout with
>
> git config revalias.=E2=86=93 u

We may also have encoding issue here. What if config file is in utf-8,
but the console is not?

So I don't we should go this way. There may be a better way to deal
with different keyboard layouts.

> Well, this patch is actually specific to a particular keyboard layout=
!
> It improves things only for a layout where you get @ and { using a sh=
ift
> key.

=46ully agreed. While it does not help non en-US keyboards, it does not
cause any harm (jealousy is not classified as harm to me, rather
motivation ;).
--=20
Duy
