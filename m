From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] kha/{safe,experimental} updated
Date: Wed, 13 Aug 2008 22:54:57 +0100
Message-ID: <b0943d9e0808131454p16cb104bs1bcf67a6c660a88a@mail.gmail.com>
References: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Samuel Tardieu" <sam@rfc1149.net>,
	"Daniel White" <daniel@whitehouse.id.au>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:56:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOK2-0005vX-2T
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbYHMVy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYHMVy7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:54:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:52348 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYHMVy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 17:54:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so94577waf.23
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IUdDwl+pPF7wsKHVTmu/sDS+W5no9zs9L7+KZE3GXQk=;
        b=PkwjbhHBi+EZmJn/GX/9cVwIBqKMZljKxR6t77q++7d4YS4Zzhr0y2Xm5sRatrQjm/
         6TNRl/CX9UuMnnCeyExzkfh+sEQO8NIGbtGGbDqkWOfSMRXXk2EraxVLgVv+gEPevonB
         FSGTkGa38doy6xhGHbzBeHWb1WT45MPpK9Auk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vP1R3b2A7URggt1sG78ADUXPiganpH/pw9YDXaXEmj+EA8hZ10r3or24Ov27PvLoM7
         enOnSUPanMP+8tQxjt8b4EhTcvjPi4BjPyCrmxbOqcxEAdI4S6DKGVSZQPohksgwaUL3
         OxB+gZg/FIv0b4FwHsdozIBG+hRpLtytTCY6I=
Received: by 10.115.16.1 with SMTP id t1mr483441wai.49.1218664497922;
        Wed, 13 Aug 2008 14:54:57 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Wed, 13 Aug 2008 14:54:57 -0700 (PDT)
In-Reply-To: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92284>

2008/8/8 Karl Hasselstr=F6m <kha@treskal.com>:
> Catalin has pulled the safe and stable branches, but I've accumulated
> some new stuff in kha/safe.

I merged it, thanks.

> The stack log stuff (and nothing else) is still in kha/experimental.
> It's unchanged since my last status mail, except for the addition of
> an optimization at the end (will post as a follow-up to this mail).

I'm on holiday until Monday and I haven't got the time to test the
performance but we can probably move the experimental stuff into
master and start preparing some release candidates. I'll repost my
patches with the new git id format as well and we need a 0.14.4 in the
meantime (hopefully over the next two weeks).

Thanks.

--=20
Catalin
