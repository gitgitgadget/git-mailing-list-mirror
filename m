From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/12] print the line log
Date: Mon, 28 Jun 2010 01:49:03 +0200
Message-ID: <AANLkTinxtSq8mb229MpAbeDHr2MJuT3SBJfwnCaG6yx8@mail.gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com> 
	<1277558857-23103-9-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	trast@student.ethz.ch, jrnieder@gmail.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 01:55:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT1hJ-0004xJ-BG
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 01:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab0F0XtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 19:49:24 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59747 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0F0XtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 19:49:24 -0400
Received: by qyk38 with SMTP id 38so1061120qyk.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=I4BLKtBNhcxyCnzUD4DyTblzelD6lhnvymavEJTuSJQ=;
        b=xNSbyxGMC7p0x8GucDfYRE9nVuzkk1l4PncBHk9SDVJupV6MZMK/k1JKNz2CQ56TWE
         3tKM+MASty1K2xM9Ahlm4MTo909pMfbypF/iZaO654YGhE3J+wYJblAjtgjWW0OKrFuH
         xHw8LPV2+8Qec7v8DS3PtzSRyCd+tCU3b1xUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Huvk0SiCyPZd6nWXYzi6jj22WLU8/UZjO9DCj5Djkj+2Ckj17a4sx+Clgqwh91ds0S
         6kx9aAUlxDnL+Buqhn/DdScGmr2FfD930fWLJaYkde7Vrf8skya3KR/BimsvGZK6huWo
         GaHASVfpfweXBYp/XX3qkeU+mMX93HB79UnZM=
Received: by 10.224.126.196 with SMTP id d4mr2669050qas.27.1277682563081; Sun, 
	27 Jun 2010 16:49:23 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sun, 27 Jun 2010 16:49:03 -0700 (PDT)
In-Reply-To: <1277558857-23103-9-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149810>

Hi Bo,

Bo Yang wrote:
> 'struct line_chunk' is used to make sure each file is scaned
> only once when output. We 'borrow' two function from diff.c
> to get the similar output of normal diff.

Can you write a more descriptive commit message in the next round?
Thanks.

-- Ram
