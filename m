From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 2 Mar 2009 12:35:17 +0200
Message-ID: <94a0d4530903020235n28baf0c8m5a9fdf01edfc85ec@mail.gmail.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
	 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
	 <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
	 <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
	 <20090302172401.6117@nanako3.lavabit.com>
	 <7v7i385meo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 11:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le5Vz-0003uE-2o
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 11:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbZCBKfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 05:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757624AbZCBKfW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 05:35:22 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:51253 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483AbZCBKfU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 05:35:20 -0500
Received: by fxm24 with SMTP id 24so1906402fxm.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 02:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H1BXoB6mKnWqs0pLE5E58/U4nodTxThJ4NCBNf17DQo=;
        b=b5iOVSyQAqchp423xmTUTUd1ABXTGZ80xY+ZxlaOdBFIArPW1Ktko8+loG0Kgo1ENV
         JpqIS9BsYmsZaJQovRq2pyPNUhNIM3SXmEGk6qQo/qiFxzb/WACe7s/8gHC86C8VhgZa
         Lv7M0293/Ean+Jnvh0oev42XWOmTxkgNrcSl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CKNcgRIq8scvk8ep7KXIjjJKZsGPfOoZHRaTSTI20zylPXd+vwXlq37JzF9Yr8K3OV
         48lXpN3vgfNHWSjpcNmAIRGUUTdSx8GeiCDvcEatoKZCx41by+4HVGRqXFx2Di8jlKPG
         8qw3Ug256A9ZF49FL9vK3/X4dDw2D421AXZyU=
Received: by 10.86.95.8 with SMTP id s8mr393026fgb.28.1235990117446; Mon, 02 
	Mar 2009 02:35:17 -0800 (PST)
In-Reply-To: <7v7i385meo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111927>

On Mon, Mar 2, 2009 at 11:01 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> We are taking that route for 1.7.0 to warn very loudly about pushing =
into
> the currently checked-out branch in 1.6.2 and onwards. =C2=A0We may n=
ow find
> out that people hate a loud deprecation period. =C2=A0Then what?

The problem is not the 'loud deprecation period' it's the deprecation
itself. You cannot avoid deprecation, so you cannot avoid users
complaining, but you can avoid surprises, and that's what the 'loud
deprecation period' is for.

The 'loud deprecation period' allows users to find out *earlier* so
that they can comment on the issue. If a huge amount of users
complain, maybe the deprecation should not proceed, or maybe someone
comes up with a plan B. Sill, some people would not be happy, but at
least their voice would have been heard.

Sure, it doesn't matter how it's handled, some people will still not be=
 happy...

--=20
=46elipe Contreras
