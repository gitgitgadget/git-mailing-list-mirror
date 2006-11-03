X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 14:37:29 +0000
Message-ID: <b0943d9e0611030637x6162ede8sc9efb3297474885e@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
	 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
	 <20061103095859.GC16721@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com>
	 <20061103130259.GA20611@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030525t5da2cce7nf7b41323411e8d2d@mail.gmail.com>
	 <20061103133329.GB21202@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030556v4c49868ct5e553240a5f1d63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 14:40:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tFtNE0Ak3eQOz5U7sgccHt/+vwF6hPf1B1uZlnyAh6w4YOhdixujbe4SAfkdhk/Cyp+F/qdzL2zoL9GWTp88f1zuLTRRJTkTOIzQPzn+S/22+b36+oDIt+48hFGs/XSuYX5pts93tfqY2V4QY1SnlKSlXtg0OL6FOFucrv4dGMw=
In-Reply-To: <b0943d9e0611030556v4c49868ct5e553240a5f1d63@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30857>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg0Ao-0005B5-Rz for gcvg-git@gmane.org; Fri, 03 Nov
 2006 15:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753251AbWKCOhb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 09:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbWKCOhb
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 09:37:31 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:54556 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1753251AbWKCOhb
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 09:37:31 -0500
Received: by nz-out-0102.google.com with SMTP id z3so376853nzf for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 06:37:30 -0800 (PST)
Received: by 10.35.51.13 with SMTP id d13mr3435891pyk.1162564650207; Fri, 03
 Nov 2006 06:37:30 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Fri, 3 Nov 2006 06:37:29 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 03/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 03/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > On 2006-11-03 13:25:36 +0000, Catalin Marinas wrote:
> > > I understand this and I think we should get this fixed. In the
> > > meantime, you can always run git-format-patch/git-send-email on t=
he
> > > StGIT patches (the id would be "patches/<branch>/<patch>").
> >
> > Does that mean that "stg mail" with my QP patch generates output th=
at
> > even git-am can't read? I had guessed from what you said earlier th=
at
> > git-am _could_ read them.
>
> Yes, git-am was able to apply them but after using Gnus to write them
> to an mbox file.

I changed your patch slightly to add "Content-Disposition: inline" and
QUOTED-PRINTABLE instead of quoted-printable. It seems that Gnus can
show it properly now (but import still fails, of course).

--=20
