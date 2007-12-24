From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: die on cvsps errors
Date: Mon, 24 Dec 2007 16:21:14 +1300
Message-ID: <46a038f90712231921m396479c8k9ecb4ed4c01659f7@mail.gmail.com>
References: <20071222171801.GE15286@genesis.frugalware.org>
	 <20071224030551.GA12495@sigill.intra.peff.net>
	 <20071224030819.GA15485@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	"Stefan Sperling" <stsp@stsp.name>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 24 04:21:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6dst-0007Me-GM
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 04:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbXLXDVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 22:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXLXDVQ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 22:21:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:39271 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbXLXDVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 22:21:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1047214ugc.16
        for <git@vger.kernel.org>; Sun, 23 Dec 2007 19:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ktu3O5BaGsF11q99Lm9vWAcQr7TMjSfM48CYswk0UsA=;
        b=LakIrHaP6r/WUFKtrrkG5tM4ylrq06v38/G530IdoqHkcrTS/8aZLeVlbNuui+fmkpC4E6CLZjj8OvcsE2C0Lg0DmobtT3Z1IGKRQwHzmXwn70pPjFhptV2w99Efwh+fARItp/n5K/FasrwdsSv2oKrK9xExZaPIviRdatTmvJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DYQEq5Vvjmwq+CrtDsl8Yd2Q6YNGNxPMLXCLK0Wqk9x68APVbgj6Bbfvnlnfwrof/l0hiryyfKpE7jUe65qyAg7dEba4V41SmTyFPRm1dEyvfAfo8ZGkReg6QzL72//ORKQ78El2eXasDnH4b58NANgTLInAD3yCY+3dPAv9KW4=
Received: by 10.67.29.20 with SMTP id g20mr1990929ugj.54.1198466474488;
        Sun, 23 Dec 2007 19:21:14 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 23 Dec 2007 19:21:14 -0800 (PST)
In-Reply-To: <20071224030819.GA15485@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69203>

> We were not previously checking the exit status of cvsps
> at all.

Acked. We should have done this ages ago. Thanks!

m
