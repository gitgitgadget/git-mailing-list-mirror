From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Multiblobs
Date: Fri, 30 Apr 2010 13:26:19 -0400
Message-ID: <k2g32541b131004301026n5e8d20b0pc74d22507d4f23d4@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com> 
	<alpine.DEB.2.00.1004291231410.16241@ds9.cixit.se> <x2v32541b131004290828ua9c2d194o1280177360dd231e@mail.gmail.com> 
	<alpine.DEB.2.00.1004300918310.24359@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Apr 30 19:28:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7u0d-0004h4-Mq
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638Ab0D3R0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 13:26:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54817 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933287Ab0D3R0k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 13:26:40 -0400
Received: by vws19 with SMTP id 19so374273vws.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=XSMEmp+zeoWMPzTN0XL33SO7TVCTFs+/Jk79VDYYqEo=;
        b=w6V6cxqOzZPwTR/rGIRdCQoe9nSq1ocaKGSuAt0sNvEg04IL0e/agu5dM5sscem1wV
         8ZJsYkrmGREIULFv01vRbEILWbOoCQdF5zoc+/yYPBUw7ZQ21n+Qcn2JSaiT2i3qEygH
         wJm+2udJ19YpYeNiedko8cQhXbtc6pavfOnoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=B9SVhV72DZeVpHFmth7A1DvrrcJQHcxL/p22XZAS/FVsOlOzDg2LZUX3QcnIkA2jxZ
         GTWj2RbSlX2xnN2Pnaf14OA0HfbRF05PLzYoFZHpQaIMjbwcNhivGur4SCKZWS+G/ci8
         48Sa6eTt8QVrFptE/9/Jqb/af9kBPP+AUrurs=
Received: by 10.220.157.134 with SMTP id b6mr8023152vcx.183.1272648399251; 
	Fri, 30 Apr 2010 10:26:39 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Fri, 30 Apr 2010 10:26:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1004300918310.24359@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146036>

On Fri, Apr 30, 2010 at 4:20 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Avery Pennarun:
>> This use case seems to be converging more and more on the "clean/smudge
>> filter like" idea, which might be ok.
>
> That's what I am using now (recompressing files), but that approach is a bit
> fragile (it suddenly broke on my Mac install, and it only works
> intermittently on Windows).

In general, if you find that existing features have bugs, the correct
solution is not to add more buggy features, but to fix the ones that
already exist :)

Avery
