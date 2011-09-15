From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: Fwd: vcs-svn and friends
Date: Thu, 15 Sep 2011 19:00:04 +0600
Message-ID: <CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
	<20110915100106.GB2328@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 15:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4BZC-0002pj-6h
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 15:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933738Ab1IONAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 09:00:07 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57000 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933716Ab1IONAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 09:00:05 -0400
Received: by qyk30 with SMTP id 30so5135107qyk.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HPIWU/8BzyBwfXEcj3IZwZ4uu+sqP7snAkRW4zSBI4s=;
        b=aAOeFquAn3Afg7M9JodMl1OyKBua5+rT/cwn+flwNJIbUTxMZss0UWqpytV9oimwG0
         HIvRLGu1+svNHt++CCHUv/XEuciLIfE3IL7rtgpZlWDSmXm6FxF0lS6lwV1vSa0GrydW
         2IGM2qg8Fi7NRflA1HIYTyx2BlPkOD4vq/Y4w=
Received: by 10.229.67.159 with SMTP id r31mr897086qci.92.1316091604782; Thu,
 15 Sep 2011 06:00:04 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Thu, 15 Sep 2011 06:00:04 -0700 (PDT)
In-Reply-To: <20110915100106.GB2328@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181466>

> =A0- 3bba32e9 ("fast-import: allow top directory as an argument for s=
ome
> =A0 commands"): I'm not sure what the motivation is --- is this just
> =A0 about the principle of least surprise, or did it come up in pract=
ice
> =A0 somewhere?
(to ease one's reading, commands are ls, copy and move top directory)

Haven't seen them in practice. It seemed possible with svn import: if t=
here were
no branches at start, and then someone did svn mv . trunk. But it
turns out that my
svn client doesn't allow such move. So more like a least surprise purpo=
se.
