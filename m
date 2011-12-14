From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/7] revert: pass around rev-list args in already-parsed form
Date: Wed, 14 Dec 2011 20:21:14 +0530
Message-ID: <CALkWK0kb8NzS+PWtvucfpAOMu+X8yZ1hbTVu+ZurhNJcdesc2w@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210125825.GD22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 15:51:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqBJ-0007D3-Rh
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab1LNOvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:51:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38013 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab1LNOvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 09:51:36 -0500
Received: by wgbdr13 with SMTP id dr13so1944465wgb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ELvtnVwu3Rrgvvts3g4yRuN4L7CxEHncsK5jul48wH4=;
        b=h8foXd6cjrbRyW+46hHvzxm6K3XyAkszMd3cQ+UUU2PnYrNTy+XpnMfCCssFm5mwQ2
         zSXaHSiELo8KpZlCL+3e9ts83mjNZX5fl5AcJfk6lv8lGm0KX0p1ww6uZBF6lixnv6/x
         H6a5VIUzsbk1e9ghBRC73fBzBKDgxqGlOa6qY=
Received: by 10.227.204.9 with SMTP id fk9mr2530920wbb.5.1323874295397; Wed,
 14 Dec 2011 06:51:35 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 06:51:14 -0800 (PST)
In-Reply-To: <20111210125825.GD22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187123>

Hey,

Jonathan Nieder wrote:
> [...]
> Original patch by Jonathan, tweaks and test from Ram.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>

I've already seen this, so let's see how it fits into the rest of the series.

-- Ram
