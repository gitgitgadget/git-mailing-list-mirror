From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Make a non-bare repo bare.
Date: Fri, 17 Jul 2009 06:50:34 +0530
Message-ID: <2e24e5b90907161820o5ee24491j8744a8652e7dec26@mail.gmail.com>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
	 <7vbpnlbbln.fsf@alter.siamese.dyndns.org>
	 <2e24e5b90907160439i29171e9fka3baf6bf871a6011@mail.gmail.com>
	 <7v8wio8i73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 03:20:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRc7x-0003SD-5c
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 03:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933921AbZGQBUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 21:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933917AbZGQBUg
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 21:20:36 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:47290 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933916AbZGQBUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 21:20:35 -0400
Received: by gxk9 with SMTP id 9so957070gxk.13
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kPtbtZ6NdmtHYQpn3DFKivAZTycfNYRPiaVYkcEmue4=;
        b=x7Kq35iupIz6/qnHIGW31epnq12W836V5lRatuNYBKhseFBKPIGtZ8aqveuK6r7Yg7
         dFSfLHDwqkcXoyHTaFR81qK/GeYSGNglpx9rnbgCJjVN5IidSkyV3XeGzyy1YcbDXCdl
         xOTJyV2M4vGWB0UCnPaZry2FZd4pNAu+LqlLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hRJetN2dCBDToop441pXJhm+H6NwASI5SLwe1oQT8x5rQ59jM7rraEG66fgqCUHQ92
         dCfYjCDsQw/SkcYRvPX7OZD28XaC3paJA09OiPh/cSDwjawGns3TtGbsEN4UiYtdfsVw
         5152nu+/bZ9//PVkiAMUwLozZ8b1YzPMWcqU0=
Received: by 10.90.88.16 with SMTP id l16mr329534agb.91.1247793634494; Thu, 16 
	Jul 2009 18:20:34 -0700 (PDT)
In-Reply-To: <7v8wio8i73.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123438>

On Fri, Jul 17, 2009 at 2:21 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Sitaram Chamarty <sitaramc@gmail.com> writes:

>> The linked procedure uses git clone --bare. =A0It is my belief (and
>> please correct me if I'm wrong) that only a git clone --mirror
>> actually does what you want here -- a mere "bare" clone would lose
>> your remotes and their tracking branches would it not?
>
> Depends on "what you want here".
>
> I assumed that the request was to set up the most typical use of a ba=
re
> repository, that is to prepare a distribution point, separate from yo=
ur
> primary working repository with a work tree, from which you push your
> updates into this new bare repository.
>
> And in such a distribution point, you do not need nor want remotes. =A0=
The
> point of remote tracking branches is to let you peek what others are =
doing
> and merge with them, and that is done while you advance your history =
in
> your primary working area with the work tree. =A0It does not happen i=
n your
> distribution point.

I agree, bares dont have remotes, normally.

I was speaking purely from a technical point of view.  Contrast, if
you will, with the other method seen in the thread and elsewhere (the
mv repo/.git repo.git, rm -rf repo, git config core.bare in repo.git
stuff), which does preserve all this.

Anyway, you confirmed my _understanding_ of clone bare versus clone
mirror, which is what I was looking for.  Thanks!

Sitaram
