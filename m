From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sat, 30 Apr 2011 01:23:55 +0200
Message-ID: <BANLkTi=7_-TF63Y9MRHZ_XirSUD6RAC9kw@mail.gmail.com>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
 <20110429223433.GA3434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFx3B-0000Kl-CE
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 01:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138Ab1D2XYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 19:24:36 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50727 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325Ab1D2XYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 19:24:35 -0400
Received: by qyk7 with SMTP id 7so508612qyk.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=m1pV2i8aHNbIGcTT/HN+JoDL0WaEW6E1NDagLTHuT2g=;
        b=yCnvQr5o9ee7MqGkuK+k71tJNaN9IE9GYsGVduKTdNmnOwv43MF9RCrq0OSBbK6TYg
         HhKAodlv1QOTK5NYivfOl4zSe6GpJDlbxEnAMTR/zUP+66Q5Gnak1r8Ack/ASp0dT/9k
         3kIECF98AWfQ/di7dqUSpiVSGoqK+9hskD46Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=S2SxLMQqxoqAEjzgTXiM0922oVSFITDnv3tYr3clbwfMRZ9SJGtrdTKVm+2O+uHmJA
         atqxJdXNmmBDm4v6qBKQjd7w/W43Z15HCsp8ajbA7hRCzm5solX9wibEHMFlKkWpsm7N
         AKYmHVjJ4HVABL0/9W58uEh7BlcqtyUWayfMs=
Received: by 10.229.101.168 with SMTP id c40mr4354630qco.98.1304119475068;
 Fri, 29 Apr 2011 16:24:35 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Fri, 29 Apr 2011 16:23:55 -0700 (PDT)
In-Reply-To: <20110429223433.GA3434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172511>

Heya,

On Sat, Apr 30, 2011 at 00:34, Jeff King <peff@peff.net> wrote:
> So there really isn't a lot of consistency, I guess. =C2=A0It also co=
nflicts
> a little with the shell's "~user" syntax, though presumably you don't
> have users named "1" and "2".

=46WIW, I like the patch, mainly because I dislike typing HEAD~n (I
usually mispel it as HEA~n) and agree with peff's analysis, we're such
a long way from being any form of consistent that I don't see this
breaking any user expectations.

--=20
Cheers,

Sverre Rabbelier
