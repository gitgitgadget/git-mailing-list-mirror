From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:03:07 -0500
Message-ID: <CAMP44s1kjqgcfLkOdOYA4xAUMGsvJXQvd01j=y9ybs_LyCEdYA@mail.gmail.com>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<87wqq39nmr.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:03:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljxS-0003M9-Dt
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab3FISDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:03:10 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33775 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3FISDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:03:08 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so3560843lab.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Q8j//c/N8ofG5z4CgoXZkuCakVQLzUE17tz5RXh/LSM=;
        b=IWxpfsqn1rMifR97KKTzXkcjY2UXmUxZhUiQfiWvP2layZuHFGSZXiI5sfKyxR2laQ
         2Ee/lUi5hZej53kRJDcGbiFqasMgxrlVTaX/++TuIaLxU7KalYe3CaFvHSr15mFrJtJb
         5kxKnjuPkqWM3jAlMB4hUmDM7swIUp0Iy/YVMDiejPt2q3eFIBAcP87X1QFAOKnFJgrg
         7bRyjUi+XYdk5566j3dxPrV+rpyqjffMdLXQF8d1Qblb10R27PRIQ7wfEQLvXGBDNHkc
         eJjG204o5eh/K+WTvkYQDG/PIdOTIVkx9OGTsTlLaAllBH3Cau34qLA98gZIlDbqWEIY
         o0Gw==
X-Received: by 10.152.22.130 with SMTP id d2mr2841832laf.33.1370800987385;
 Sun, 09 Jun 2013 11:03:07 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:03:07 -0700 (PDT)
In-Reply-To: <87wqq39nmr.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227074>

On Sun, Jun 9, 2013 at 12:53 PM, Thomas Rast <trast@inf.ethz.ch> wrote:

> You have a tendency, when facing arguments by someone who does not agree
> with you, of picking out one (usually minor) point of their statement
> and attacking just *that* on grounds that are usually much harder to
> argue, without regard for the bigger issue.  In effect you are
> attempting to shift a significant burden of proof back to the other
> party.

He who makes a claim has the burden of proof.

That which can be asserted without evidence, can be dismissed without evidence.

-- 
Felipe Contreras
