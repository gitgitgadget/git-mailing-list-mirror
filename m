From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Q: "git diff" using tag names
Date: Thu, 3 Nov 2011 00:08:13 +0400
Message-ID: <20111103000813.66dd2685@zappedws>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
	<20111028165943.2cc8253d@ashu.dyn.rarus.ru>
	<4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
	<20111102132945.582707aa@ashu.dyn.rarus.ru>
	<CAH6sp9OdjNZ6_j-eSFMpecUcxW_y6fpkDZ0cRds62wOrc12x-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLh7J-000676-0J
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab1KBUIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 16:08:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43722 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab1KBUIp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 16:08:45 -0400
Received: by bke11 with SMTP id 11so476422bke.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ClTOyDMl/hv+05Eaq6S/zCBVQSEcNy0cXer/2Aq0/hU=;
        b=UPt116VNpWATgExx74LumvXQxZ1oaO49vq4dNeTPvgOiKziuDFdGi7aUPOBcypEQqv
         AtLfY5QWlyLek+PrS5VTotrtzW9sGwbvNBQzFPmSp4M13DeNNiqBx9fOa7vzRnAjuwZT
         hWxIUpcPqcfZsnZMipQSbycHwgAileWZ5Poag=
Received: by 10.204.142.80 with SMTP id p16mr5164791bku.10.1320264524027;
        Wed, 02 Nov 2011 13:08:44 -0700 (PDT)
Received: from zappedws (ppp91-77-25-108.pppoe.mtu-net.ru. [91.77.25.108])
        by mx.google.com with ESMTPS id j9sm3379861bkd.2.2011.11.02.13.08.39
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 13:08:43 -0700 (PDT)
In-Reply-To: <CAH6sp9OdjNZ6_j-eSFMpecUcxW_y6fpkDZ0cRds62wOrc12x-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184661>

thanks )

> On Wed, Nov 2, 2011 at 10:29 AM, Alexey Shumkin
> <alex.crezoff@gmail.com> wrote:
>=20
> >> Also it seems that both syntaxes work:
> >> git diff v0.4..v0.5
> >> git diff v0.4 v0.5
> > honestly, I do not know the difference (at the moment :))
> > may be gurus or manual will help to discover it
>=20
> As per the git-diff documentation, these two versions behave equally
> -- i.e. no differences.
>=20
> Comparing branches
> $ git diff topic master    <1>
> $ git diff topic..master   <2>
> $ git diff topic...master  <3>
> =E2=80=AA1.=E2=80=AC Changes between the tips of the topic and the ma=
ster branches.
> =E2=80=AA2.=E2=80=AC Same as above.
> =E2=80=AA3.=E2=80=AC Changes that occurred on the master branch since=
 when the topic
> branch was started off it.
>=20
> Cheers,
> Frans
