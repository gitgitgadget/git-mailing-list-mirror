From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git hang with corrupted .pack
Date: Mon, 26 Oct 2009 08:07:33 +0100
Message-ID: <81b0412b0910260007i1a9d2a9cr23a80397478fbbf1@mail.gmail.com>
References: <20091014042249.GA5250@hexapodia.org>
	 <20091014142351.GI9261@spearce.org>
	 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
	 <20091014161259.GK9261@spearce.org>
	 <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
	 <20091014180302.GL9261@spearce.org>
	 <alpine.LFD.2.00.0910141435040.20122@xanadu.home>
	 <7vbpk985t1.fsf@alter.siamese.dyndns.org>
	 <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
	 <7vr5sqq3vm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 08:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Jg4-0007Li-V9
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 08:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbZJZHHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 03:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbZJZHHa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 03:07:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53725 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbZJZHH3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 03:07:29 -0400
Received: by fxm18 with SMTP id 18so11811360fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bZGBW79uKkBB357bngEtqEa4qqlGJDNPhvud+c3SkYY=;
        b=HAJArkSwVn1M6SBa4VJ+aXfMsnN7D3qBX/l7oFOECsaKtEcD3DcZDBX9UsEP7XdwAC
         xnM9ZSLvfIoSvgh0TVqrwicrsq4k2sGhTQkL5KGRb5GvIV7sjK4Nh/sgpurjTpeOWD58
         TlaqjGyk2iQNPrJ8GEYpMAECMRWm7HPzCnZiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZALrVZfxBeNjjWAJzJW+kSq+vKDfUsnrshzpkN+EgXB/3McJKIb/EFNTlr3K3+a8Gg
         DaPKe3LE1qKbc3DI0Cw17XZFFIwZbLVVtQhfCkNwv156gmxwYc8cmFmVGF3fs8tdqvCD
         G8hIWHIozKBvv9B1OElsQwu1OfBVfXSIXo58A=
Received: by 10.204.5.138 with SMTP id 10mr5532957bkv.110.1256540853583; Mon, 
	26 Oct 2009 00:07:33 -0700 (PDT)
In-Reply-To: <7vr5sqq3vm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131242>

On Mon, Oct 26, 2009 at 03:35, Junio C Hamano <gitster@pobox.com> wrote=
:
>
> Could you test the patch in
>
> =C2=A0 =C2=A0http://mid.gmane.org/7vd44gm089.fsf@alter.siamese.dyndns=
=2Eorg
>
> without your workaround?
>
> -- >8 --
> Subject: Fix incorrect error check while reading deflated pack data
>

I did. It works as intended since about 3 days. It also helped my home
server (a 32bit Linux system), which also experienced the problem.

Thanks!
