From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT experimental branches updated
Date: Mon, 3 Sep 2007 09:29:18 +0100
Message-ID: <b0943d9e0709030129y2ced4f61jaf42c07a7798f47a@mail.gmail.com>
References: <20070903002029.GA31957@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7JQ-0002Rc-BX
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXICI3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 04:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbXICI3U
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:29:20 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:65446 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXICI3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 04:29:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so906354rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 01:29:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=akdO07Bzu2PoKFHvE4PScng0Gpvvh9VJRKF4cCmyUfiP37H0ngTz5bUOl3cikiNvuTDA+orGSo+x9sReyrS+ZAj1y2uD6d3FqJ+s5cogiiRohYKFcBUrHUrLuBpLsZJQ931p6KftFf8pa90xX10xuuU7XoDu4llfrA77qUm3Iog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GOrHuwqoDxNrEciipt6ngubnFp0/0WVmHPXJcMts/t4BsERMWD7B0wcFaTm8u/dWE7V2281sAM4Xa+saQ0SGBVwqplg7yD2C536WS+cylcoGMBjLwevS8v+xr1MkjcSpjPBPg+oLqGwbUs6KhWMwQbpSU5tcTTmk/gQMdZA38u0=
Received: by 10.140.250.14 with SMTP id x14mr1867503rvh.1188808158685;
        Mon, 03 Sep 2007 01:29:18 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 3 Sep 2007 01:29:18 -0700 (PDT)
In-Reply-To: <20070903002029.GA31957@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57444>

On 03/09/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I've added the three patches I just sent out. That's all, since no on=
e
> else seems to be working. :-)

It's Monday (and morning) :-). Thanks, I merged the 'safe' branch

> Plus, I've renamed the branches to "safe" and "experimental", since
> that's what they're all about.

It makes more sense.

BTW, would an extension to 'stg import' to import patches from mailing
lists (NNTP or maybe just mbox) directly be useful? There is support
for mbox importing anyway and it would need a procmail filter to
generate the mbox and just a regex filtering in 'import' to apply the
StGIT patches only.

--=20
Catalin
