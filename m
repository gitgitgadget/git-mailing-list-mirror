From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/7] Revert "reset: Make reset remove the sequencer state"
Date: Wed, 14 Dec 2011 21:36:19 +0530
Message-ID: <CALkWK0=22=3grVo57QiJ0ZJ_yF3Tzw2bUzqmQ3UbjM0NKLUO_Q@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210130348.GG22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RarLy-0002Du-Hh
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976Ab1LNQGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 11:06:42 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43129 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1LNQGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 11:06:41 -0500
Received: by wgbds13 with SMTP id ds13so1635756wgb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PbOTdBZ4o60qcSd84jtwLwgvFadIoMwHijEIgghqnXc=;
        b=r07vQkZCVS4MU7aadHrhJhydeIFO1rNwd/6YBEegL8bnHjsJ33YXeKmfbfjNNcBaJ2
         ooWUbNs6OFe4fGVbzAGW+QKTSNQWFhRN4l6DwAldcrwnJKkovZy8n+eWDQwb/xPsQ/ZW
         2BxhfxKlXE6/a/U1XdH0Pzh6ySwzTgSQwKr3Y=
Received: by 10.216.54.212 with SMTP id i62mr1499666wec.22.1323878800224; Wed,
 14 Dec 2011 08:06:40 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 08:06:19 -0800 (PST)
In-Reply-To: <20111210130348.GG22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187138>

Hi again,

Jonathan Nieder wrote:
> This reverts commit 95eb88d8ee588d89b4f06d2753ed4d16ab13b39f, which
> was a UI experiment that did not reflect how "git reset" actually get=
s
> used. =C2=A0The reversion also fixes a test, indicated in the patch.

Looks good.

Thanks.

-- Ram
