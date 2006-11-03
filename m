X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 13:16:08 +0000
Message-ID: <b0943d9e0611030516v43a25b76y4c07f82b33411a6e@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
	 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
	 <20061103095859.GC16721@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com>
	 <20061103130259.GA20611@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 13:17:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3PbpNv6qRLIXrrUMsSFA2RrKTgRYjC7DbTcuSPGLNc5bMifmY+r8SIScbShV/ZO7CEQW0gH6C8aBFh+caTTRZe32yDVwBPDlool/HzxMVZUukaDKd0Z+XB/9FuxTI9InogTayg9NM1Xxv+eEPm/maUVudYdeMKyG/vaa0Dx77o=
In-Reply-To: <20061103130259.GA20611@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30847>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfyuy-0008TH-Oy for gcvg-git@gmane.org; Fri, 03 Nov
 2006 14:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752874AbWKCNQL convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 08:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbWKCNQL
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 08:16:11 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:14722 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1752874AbWKCNQJ
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 08:16:09 -0500
Received: by nz-out-0102.google.com with SMTP id z3so357899nzf for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 05:16:08 -0800 (PST)
Received: by 10.35.60.15 with SMTP id n15mr3304239pyk.1162559768323; Fri, 03
 Nov 2006 05:16:08 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Fri, 3 Nov 2006 05:16:08 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 03/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Or try to use the git plumbing directly, if reasonable. Mail encoding
> and decoding isn't my idea of fun -- I just want it to not break. And
> I don't see much point in StGIT replicating core GIT functionality
> when there's no reason to.

As I said in my reply to Junio, I really like to keep the e-mail
templates functionality of StGIT. This is not available in
git-format-patch.

--=20
