From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] clone: support cloning full bundles
Date: Wed, 12 Dec 2007 16:21:10 +0100
Message-ID: <8aa486160712120721k26158972qf11c889da98572c6@mail.gmail.com>
References: <1197456485-22909-1-git-send-email-sbejar@gmail.com>
	 <Pine.LNX.4.64.0712121449310.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TVk-000275-OD
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbXLLP1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 10:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbXLLP1w
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:27:52 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:5696 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751900AbXLLP1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 10:27:51 -0500
Received: by rn-out-0102.google.com with SMTP id i6so22216rng.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AhrqSnyxYg7PEQ7O1spBSZOayAjP+WEXiF0JKcLLAlY=;
        b=UnYQAHDHo4WREl6FIHxqvGXfAe5u/b9w8rN9wGQP1Eih2rP/XdxTBSjK4k6gv1YuZwriNBPdtYpdFDJL99fARD7aKBlV20KmyfzaVlRWEYzv+nMmcuYlNHoRuc4eAdxZM30xCsglJ8oG+Tw1Jq+8M9oV2QpWA5x27Vb6/FbhcdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKi47VTZ2FxgZxnIQbeoxj7bH7OgWc32zBetMrvoVOCfed2q9CVs5qI4ywAwYDAbgLPRlSr5E/7gCq2vK1htlytyGYXcYuFLNiHGOttGYGDYBsgWsaVSJpLN7cyfVnUONFnW6CGm0YBRtrmHqBTRyNPNjKCOqmehFHww1huEbew=
Received: by 10.150.201.13 with SMTP id y13mr260418ybf.31.1197472870288;
        Wed, 12 Dec 2007 07:21:10 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 12 Dec 2007 07:21:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712121449310.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68050>

On Dec 12, 2007 3:50 PM, Johannes Schindelin <Johannes.Schindelin@gmx.d=
e> wrote:
> Hi,
>
> On Wed, 12 Dec 2007, Santi B=E9jar wrote:
>
> > It still fails for incremental bundles.
>
> Of course it does.  The whole point of incremental bundles is that th=
ey do
> _not_ contain all objects, but rely on some objects being present on =
the
> "fetch" side.

I know this. But then there is no bundle equivalent of the shallow
clones, as with:

git clone --depth <depth> <repo>

Santi
