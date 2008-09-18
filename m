From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC/PATCH] extend meaning of "--root" option to index comparisons
Date: Thu, 18 Sep 2008 18:51:17 +0200
Message-ID: <bd6139dc0809180951p2380be79mbc43c53052966b1b@mail.gmail.com>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
	 <48CECA42.1050209@drmicha.warpmail.net>
	 <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
	 <20080915223442.GD20677@sigill.intra.peff.net>
	 <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
	 <20080916062105.GA12708@coredump.intra.peff.net>
	 <20080918092152.GA18732@coredump.intra.peff.net>
	 <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Anatol Pomozov" <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMjz-0000Ge-Bs
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbYIRQvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbYIRQvT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:51:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:42136 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbYIRQvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:51:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so273208fgg.17
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9QJWfaJ+ct5v5NMOOYwkkyM8RQ9eYS4PqVk6V4Oemuw=;
        b=kZv/66igXRMb/vOZALm/x/hqp2ebibilylRezxjgxuuYq3wHz7bNUsEQWVAd0zQvZn
         VR2IhNCrSXa484fH4GT/F6DC4Ezd3WaZzvUECmCwpLnBv5DBXcj6blmyVRcAY/UGUdsk
         FPolhLghyqMvZzPwyx/i9YwA/Yqj3D0+tEyYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ESbJ+9je4sdDVKfdQ/Ikx7g3N38dlDaFh1KU/ekPW2iE1GlI3n/M3c8+SOvgOAm58T
         1Vt84S31d6AcKZ/GDckId6M71FhpguTFR3Q1N/uVnaxXXhn6kT1rVamOR1Jhya3iDzUw
         MDHgjtM4VxiP1UpVH26and2VuFWikRPiepjTw=
Received: by 10.187.250.1 with SMTP id c1mr531191fas.65.1221756677178;
        Thu, 18 Sep 2008 09:51:17 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Thu, 18 Sep 2008 09:51:17 -0700 (PDT)
In-Reply-To: <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96218>

[Please cull the parts of the mail you are not responding to, it is
hard to find your reply when you don't.]

On Thu, Sep 18, 2008 at 18:31, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> git log??
>
> git log --root for empty repo should not print anything (instead of
> error message that we have now).

I do not agree here, what is the use in having a command that does nothing?

> Should documentation (man-pages) reflect your changes as well?

Yes, they should be updated.

-- 
Cheers,

Sverre Rabbelier
