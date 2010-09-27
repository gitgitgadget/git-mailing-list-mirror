From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: svn-fe status
Date: Mon, 27 Sep 2010 11:15:41 +0200
Message-ID: <AANLkTinv51AjZ4c7cgqhCzJgWDZOCOXHPsraEPXvLUgR@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino> <20100924065900.GA4666@burratino>
 <20100925051926.GA19804@burratino> <AANLkTi=sij9TeY+Cv85n61xt3R6nPbkpOyKdoDMzbtaD@mail.gmail.com>
 <20100927025458.GA8921@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 11:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P09oi-00075e-4t
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 11:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759025Ab0I0JQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 05:16:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47333 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759011Ab0I0JQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 05:16:03 -0400
Received: by yxp4 with SMTP id 4so1462229yxp.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=T6cOEjV9k96kl3vTj0lSyBeTwKiewhtwIKi9T9gE3S8=;
        b=BPzSxXV2Nie2RG2XVuMRB607eXwRLGHHo+nNCUd1QOKp6JU2ggeYJR+uBADLo05bEw
         kUxA1X5a8kF64MWiP0/LzIn+xSL3qqSaiMRMsYMi6U7xPoN6cgcBBRmcf1VF8jRdYODh
         lHN2kYMniqxIujdGNsWRt8AaprM0TUmij57AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Q2G84nTMqgsfSuhWz/xH+djd3iTVO3LLUnZrsR2azFt5eyXl657GfSktVoFQof2mDb
         4iPpGZE6f150ARtpGVkkm/3Let6ZX1kkxAXPN1iMd2ydUX4k5zCEVp3MayZXujjHi2uH
         C43JaZCeSLxBFoywTmEL+ypQRPs52t9o1jpWY=
Received: by 10.150.12.20 with SMTP id 20mr8630384ybl.65.1285578962772; Mon,
 27 Sep 2010 02:16:02 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Mon, 27 Sep 2010 02:15:41 -0700 (PDT)
In-Reply-To: <20100927025458.GA8921@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157321>

Heya,

On Mon, Sep 27, 2010 at 04:54, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> We can peek ahead to make sure
>
> =C2=A0C :72 branches/topic/README
>
> still copies a file named ":72".

Yes, I guess so, we have the entire line available when parsing, so
that shouldn't be a problem.

> For completeness it probably does make sense to allow
>
> =C2=A0cat <dataref> <path>
>
> too, with <dataref> pointing to a tree (as before) or to a tag or
> commit. =C2=A0I just suspect svn-fe would not use it.

I'd prefer to have one way to do it, then again, I don't use perl ;).

--=20
Cheers,

Sverre Rabbelier
