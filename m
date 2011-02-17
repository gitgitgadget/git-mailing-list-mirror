From: =?UTF-8?Q?Jo=C3=A3o_P=2E_Sampaio?= <jpmelos@jpmelos.com>
Subject: Re: [PATCH 3/4] Dont use the same variable for different things
Date: Thu, 17 Feb 2011 00:36:41 -0200
Message-ID: <AANLkTim3t3JTFh668YK+GtS+iRDZLjnhS7bMUGW1fim+@mail.gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
 <1297550311-17723-4-git-send-email-vvavrychuk@gmail.com> <7v62sjfna2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Vasyl' Vavrychuk" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 03:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PptkP-0005GV-W7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 03:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab1BQCh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 21:37:27 -0500
Received: from oproxy2-pub.bluehost.com ([67.222.39.60]:44833 "HELO
	oproxy2-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755829Ab1BQChZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 21:37:25 -0500
Received: (qmail 1977 invoked by uid 0); 17 Feb 2011 02:37:25 -0000
Received: from unknown (HELO box598.bluehost.com) (66.147.242.198)
  by oproxy2.bluehost.com with SMTP; 17 Feb 2011 02:37:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=jpmelos.com;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-Identified-User;
	b=n0pD33Op+Ot6Zf4cCt/mGcfwxmAcVuyzUfLJCJHuzuPkywAArchA3EFIasdz01nxgIhMZjYjod4mcMurnDnbFMjR3MFgAT2LizjZ7uztR50L1+UmgBYuxzGnBO+inOSa;
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by box598.bluehost.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <jpmelos@jpmelos.com>)
	id 1PptkC-0002fR-SH
	for git@vger.kernel.org; Wed, 16 Feb 2011 19:37:25 -0700
Received: by bwz15 with SMTP id 15so1273084bwz.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 18:37:22 -0800 (PST)
Received: by 10.204.119.17 with SMTP id x17mr1145939bkq.86.1297910242785; Wed,
 16 Feb 2011 18:37:22 -0800 (PST)
Received: by 10.204.4.133 with HTTP; Wed, 16 Feb 2011 18:36:41 -0800 (PST)
In-Reply-To: <7v62sjfna2.fsf@alter.siamese.dyndns.org>
X-Identified-User: {2310:box598.bluehost.com:jpmelosc:jpmelos.com} {sentby:smtp auth 209.85.214.46 authed with jpmelos@jpmelos.com}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167029>

On Wed, Feb 16, 2011 at 23:44, Junio C Hamano <gitster@pobox.com> wrote=
:
> But more important question is why?
>
> What benefit are we getting by almost doubling the stack footprint of=
 this
> function? =C2=A0What problem are you fixing?

Well, in matters of code readability and maintainability, it's best to
use different variables for different matters...

Nowadays, memory isn't really an issue anymore, is it? I think it's
valid to make code more readable, if memory cost isn't absurd.

--=20
Jo=C3=A3o Paulo Melo de Sampaio
Computer Engineering Student @ UFSCar
Website: http://www.jpmelos.com
Twitter: http://twitter.com/jpmelos (@jpmelos)
