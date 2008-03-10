From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: "git checkout" branch switching safety broken in 'next'
Date: Mon, 10 Mar 2008 09:56:40 -0400
Message-ID: <76718490803100656k6607e00ar1cce14aedffb3b27@mail.gmail.com>
References: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>
	 <fr2v0s$cdb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 14:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYiVE-0004O0-Ne
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 14:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbYCJN4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 09:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbYCJN4l
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 09:56:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:3987 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYCJN4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 09:56:41 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2286428wah.23
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kd7ilZOVoCZDPLO1ps6WDu4b12Z3vj1iorD/F4Pn/uk=;
        b=Fg3T1vnTJ10qoMopIaKSAC8qD91NuF1d8EXmp4GK88IUPDjjLjXOt6xtxE0flnfBQ4Mdu8/UjHE7ghP0wHw3+2y9dKvNiADeNlyTAw02530IV6gpBlMRkxxe571ZWlSvgKEn/MBxPaXDcRIuL3LBq7sAI+mcuDhOKrC+4S1bBNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XJcSJzx6FDN9XGsnkdSD2j3SssIDO+4ZjHrJbuOqmBRbQOb+zSIIkELwD/kRMr4EsE2udbJnrgSLd6sCytTDAy544YkdUf449w/gy6Dxl5y4zfJZlbIYugongKAKzHhkJEg1EJgvhqEPGgMb1hMEawDn3Ph0uKnPa3FsEjkPDdM=
Received: by 10.114.150.1 with SMTP id x1mr3365383wad.109.1205157400371;
        Mon, 10 Mar 2008 06:56:40 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Mon, 10 Mar 2008 06:56:40 -0700 (PDT)
In-Reply-To: <fr2v0s$cdb$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76727>

2008/3/10 Jakub Narebski <jnareb@gmail.com>:
> Junio C Hamano wrote:
> >     error: Entry 'foo' not uptodate. Cannot merge.
>
>  By the way, could this error message be made less cryptic? It is there
>  since the very beginning, and was not changed during making error
>  messages more user friendly...

+1. Most concise is probably:

 * "error: 'foo' has uncommitted changes."

More helpful messages that I can think of are probably too verbose. e.g.:

 * "error: 'foo' differs in target branch but has uncommitted changes."

 * "error: 'foo' has uncommitted changes. Commit, use -f to lose
    changes, or -m to merge changes in target branch."

j.
