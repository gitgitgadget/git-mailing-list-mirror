From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Sun, 4 Nov 2012 03:28:47 +0100
Message-ID: <CAMP44s0wJPqKBVyS-npe7uNEO3EBPH_xUVvzzWd4wCua4gxp9Q@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
	<20121102144618.GA11170@sigill.intra.peff.net>
	<CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
	<CAMP44s0DyiH+ac-xnfmJ3+JSib+y8GYZZymM83HUjKi5CuqARg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 03:29:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpyC-0006TA-WE
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab2KDC2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:28:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49365 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab2KDC2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:28:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so4731815obb.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mNUm1gluAyDuXVUujgVzwJWUqsDSoPoabXQ/kevfowI=;
        b=dJqls/ZGmNwhb4lLW4CLX2htDNYUr0gbuOxechM5Pt57XhIN0J6QKFez9R/6PfQ6z6
         24GvU9c3tlXhv6PBkPEZtTJei1BhvPd5GUgtVxfw4BSD5WrW6FUpMABkKO/QPotMoqvl
         p8858UhAtSvBT3sVj2k1vGM3O4YZm4jyKaIcJDJ0pQyTH11wxYrUlnAbgYDpgqcRdMeY
         RZeEJXUAtqyLehZ5zdP1vgqW6aCUEvntNrNH/KH8zyW8fY1bxgHYq1WJVjaeWCBUEc4S
         gRbeOcRzLR+e4kNdmJZo5ALs0WvCApUuqD0pszIf58PlLtKzrht5aM4MMpl2AF8I5E/d
         HWnA==
Received: by 10.60.12.225 with SMTP id b1mr1477241oec.96.1351996128020; Sat,
 03 Nov 2012 19:28:48 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sat, 3 Nov 2012 19:28:47 -0700 (PDT)
In-Reply-To: <CAMP44s0DyiH+ac-xnfmJ3+JSib+y8GYZZymM83HUjKi5CuqARg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209009>

On Fri, Nov 2, 2012 at 8:20 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 2, 2012 at 7:39 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> As a rule, I don't see much value in writing a framework that works
>> only for one case, that smells more like over-engineering. If we had
>> two cases (hg and bzr), then we might be able to know with a modicum
>> of certainty what such a framework should have. So I would prefer to
>> have two standalone remote-helpers, and _then_ do a framework to
>> simplify both, but not before. But that's my personal opinion.
>>
>> Now that I have free time, I might be able to spend time writing such
>> a proof-of-concept remote-bzr, and a simple framework. But I would be
>> concentrated on remote-hg.
>
> Actually, there's no point in that; there's already a git-remote-bzr:
>
> http://bazaar.launchpad.net/~bzr-git/bzr-git/trunk/view/head:/git-remote-bzr

Turns out the quality of that tools is not that great, so I decided to
write a simple one using bzr-fastimport. It works nicely, although I
wouldn't trust the quality of bzr-fastimport too much.

It's so simple I don't see the need of a framework, but if needed, one
could be done taking these git-remote-{hg,bzr} as a basis.

Cheers.

-- 
Felipe Contreras
