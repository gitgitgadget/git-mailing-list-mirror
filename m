From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Make use of the get_patch() utility function
Date: Wed, 22 Aug 2007 22:54:16 +0100
Message-ID: <b0943d9e0708221454s44bfa754t9e0d857015d4ca93@mail.gmail.com>
References: <20070821203757.9118.30049.stgit@yoghurt>
	 <20070821215658.GB20965@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INy9f-00060I-AR
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330AbXHVVyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933276AbXHVVyT
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:54:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:29505 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099AbXHVVyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 17:54:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so232018nfb
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 14:54:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iDIlLKuOylJ46u+O4ENJEdQZzY4HY8qu2X4xxSrIGLqJxBtJ5Ed5DOBrBTnHa8LI3BwPMHegV0eQC7iPqTtjzpeKssf3OyfRrPLyp/bzwMg5z3B3WDnBGhl4XkFYi1ehA4eSo6QHF4BuzwsPSSsspDq2azUPh5u+IsOTNn0+mW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pwaIJng49SVJ44nd0KAUDZ/ay6B6tOv60imChr/5EE+/xBKGAGyOXdyVMkgfbjmAq5oQmcnO9fXoMy5tel7RYRKHSpUmPmKpeAuTEGY50TnRKb59CnImcd209dRkJGMPwCjJbORbPuNaJOIUPFTpNWd+Ww14Snohe9sAYSfD0iM=
Received: by 10.78.190.10 with SMTP id n10mr754638huf.1187819656081;
        Wed, 22 Aug 2007 14:54:16 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Wed, 22 Aug 2007 14:54:16 -0700 (PDT)
In-Reply-To: <20070821215658.GB20965@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56426>

On 21/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-08-21 22:39:11 +0200, Karl Hasselstr=F6m wrote:
>
> > Catalin, would you consider taking this cleanup? It was hidden at t=
he
> > beginning of my DAG series, so you probably didn't notice it.
>
> If you like, you can pull this one, plus a fix from Yann and a fix
> from David that you seem to have missed, from the fixes branch at
> git://repo.or.cz/stgit/kha.git.

Much easier :-), thanks.

--=20
Catalin
