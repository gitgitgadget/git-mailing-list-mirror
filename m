From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Re: git reflog delete / manpage confusion
Date: Thu, 1 Jul 2010 16:28:46 +0530
Message-ID: <AANLkTilaKwB1BYTNIJ49M0CZAJGrsPetQDOxZj_RHRv3@mail.gmail.com>
References: <AANLkTik3bApuScgjXtr-VjhmY4NIuakoX_RZaYLqqpwL@mail.gmail.com>
	<20100701101613.GA1961@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUHTq-0006lx-0z
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005Ab0GAK6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 06:58:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34077 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab0GAK6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 06:58:47 -0400
Received: by gwb15 with SMTP id 15so918493gwb.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FZlsNVfQh3XUs7GlxgzioBlTysI2WfQoV6AoSInedQA=;
        b=WYchxuN5PGBeddqcZW5FV6pcZvTDdaBDpxK+mJqlsaEJl/VIj2OIcfOrG0Nk1Tp8jC
         DRJsh+l8TG+CeAAy8aLqhu/dVFMdBulNQ6KNBIGH8oCJZGd4XgCeFQQTkO0in1sKxjef
         TV87Nt+us2Ol5XQbQ6JS4w4/p2K5H7N1AnbeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HoHoXPaqnUX6ycN42VPCEgJ0CRb+/l7bouD8ylIFuN++cjRFOdRHSEn844HUjXmWFq
         EyiYyKGdy9JHNdSCeARwgxgjaqFsceYi63bUmEhg8tVK+W4yQ1xPaXUa1SZfOf9SjfY+
         YdNG8ebgLHYtf8/FcaqdXX6iymWx4/Ykm31yY=
Received: by 10.91.34.8 with SMTP id m8mr8574231agj.152.1277981926803; Thu, 01 
	Jul 2010 03:58:46 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Thu, 1 Jul 2010 03:58:46 -0700 (PDT)
In-Reply-To: <20100701101613.GA1961@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150029>

Hi I am confused again as it indeed removed HEAD{4}

 -2993260 HEAD@{4}: commit (initial)

> =A0mkdir repo && cd repo && git init
> =A0for i in 1 2 3 4 5; do
> =A0 =A0echo $i >file && git add file && git commit -m file
> =A0done
> =A0git reflog -g --oneline >old
> =A0git reflog delete HEAD@{3}
> =A0git reflog -g --oneline >new
> =A0diff -u old new
>
> I get:
>
> =A0--- old 2010-07-01 05:54:48.000000000 -0400
> =A0+++ new 2010-07-01 05:54:48.000000000 -0400
> =A0@@ -1,5 +1,4 @@
> =A0 01bb1c7 HEAD@{0}: commit: file
> =A0 c8020a8 HEAD@{1}: commit: file
> =A0 d82df6b HEAD@{2}: commit: file
> =A0-364bcc0 HEAD@{3}: commit: file
> =A0-2993260 HEAD@{4}: commit (initial): file
> =A0+364bcc0 HEAD@{3}: commit (initial): file
