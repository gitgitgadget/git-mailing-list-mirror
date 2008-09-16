From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Wed, 17 Sep 2008 00:02:25 +0200
Message-ID: <bd6139dc0809161502t121c5aa5la53784bb8ff273a2@mail.gmail.com>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com>
	 <20080916052425.GA14644@spearce.org>
	 <7v3ak08v5l.fsf@gitster.siamese.dyndns.org>
	 <20080916080908.GA14272@atjola.homenet>
	 <48CFB44F.8060609@drmicha.warpmail.net>
	 <20080916135022.GA19466@atjola.homenet>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:03:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfie2-0006X1-Hg
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 00:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYIPWC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYIPWC2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 18:02:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1823 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYIPWC1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 18:02:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1593047nfc.21
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ihX6sY1HCsSDBfNmhK2++4HDqVsqrMKa2yidgLDosg8=;
        b=BtjKy5cX3w9u8DrDzeMN/v+sXFCW+d+z57FyyWBomT3FSIzUG/38enbOCyD3Gac2wb
         SYUHw72QG2l1tAgEJ5gNdX1N/w5HNh+2Cl0r+g+k/z6NeWYvPZc9SFBWWDyLYwww5ViM
         4B0f23DnFiTlSKdgCZbpPsvxfw+/UbB5CpGZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Doy7NdVR6RKyzFR9OEz1tBHgkU8hBrU/VH6TewZN7gNDJZXNH1Jpcz/16yLFqmdKsc
         HnMtmc1+uWbnTacp+BumJqpOD3ZOOoYxWD+89uD1hO1TZPrHjPFOoc2KGnpFe3C+w7Rg
         790a13UmwKj15iEdmJEquDLfX7A0B3XG7bwJs=
Received: by 10.187.246.9 with SMTP id y9mr271001far.20.1221602545739;
        Tue, 16 Sep 2008 15:02:25 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Tue, 16 Sep 2008 15:02:25 -0700 (PDT)
In-Reply-To: <20080916135022.GA19466@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96036>

On Tue, Sep 16, 2008 at 15:50, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>=
 wrote:
> Maybe instead of providing "pre-shallowed" repos to clone from, that
> should have been an RFE to support shallow clones starting at a given
> commit in the DAG? I have no idea whether that's feasible though.

Would it be like grafts, only the graft is set up by the fetcher,
instead of the host? (E.g., the graft is created on clone, instead of
-before- the clone, by means of the --depth parameter?) Which means
the mentioned security risk is not there (what with the fetcher
setting it up himself).

--=20
Cheers,

Sverre Rabbelier
