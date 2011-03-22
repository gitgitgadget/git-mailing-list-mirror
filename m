From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 13:59:54 +0100
Message-ID: <AANLkTi=E3p8ue=-4LLiu4xFEXmC4gpa9moq=T2fQGJwR@mail.gmail.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
	<20110321215310.GA2122@sigill.intra.peff.net>
	<7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
	<7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
	<AANLkTimH+eVUh6D5qK-PbNJGg46XJwaCii5zMg7xyZ_6@mail.gmail.com>
	<20110322112832.GB32446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 14:00:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q21Bx-000505-OS
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 14:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab1CVNAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 09:00:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34627 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab1CVNAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 09:00:02 -0400
Received: by bwz15 with SMTP id 15so5804870bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z9ZfHoQfvP6ORojQub3ZnlTio7elVCHsrL7iOFM1ckU=;
        b=GmN29nNfhJYJx/ywocRESfqyCTNxi2CokwPQd3SFujUeZi4h9RKMUUTzF+1VzjWwM8
         VNKlzU+ZGHO18jUA2rTiVFK8TGHcegJWi+oQilL33I7mgq0E2/JMyEEq1cb4r6nZXuKi
         Po+IO4xldJtM4EG4EQ6gvCFcU+fEhOR4CzquU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KlIaeHgLmdy22D5lm43VvY1zd7yMt7DcaT3NYL8VxmEKGvmSJzB7kXIGT7BrjPx11t
         AAOUjNF/pUW+OnufGSD08UvectJcwOKu+nMGXCf7bhQz5sarF7T7AKA7rsJ6gmMfHyDQ
         3YcvNJaS5L0LDpCO5PeEcpCbVyr58y7ygKsoI=
Received: by 10.204.151.202 with SMTP id d10mr4807603bkw.168.1300798794802;
 Tue, 22 Mar 2011 05:59:54 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Tue, 22 Mar 2011 05:59:54 -0700 (PDT)
In-Reply-To: <20110322112832.GB32446@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169732>

On 22 March 2011 12:28, Jeff King <peff@peff.net> wrote:
> =A0$ grep -B1 silly .git/config
> =A0[alias]
> =A0 =A0 =A0 =A0 =A0silly =3D "!foo() { echo hello $1; echo $# args, b=
ye!\n}\nfoo"
>
> which unsurprisingly looks like exactly the same solution one would u=
se
> in the shell to avoid the fact that shell aliases suck for handling
> positional parameters.

Atually, I think that's probably the most elegant way of dealing with
the issue... An example like this would be very useful in the alias
documentation along with an explanation on how positional parameters
are handled...

--=20
/Lasse
