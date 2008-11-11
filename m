From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Tue, 11 Nov 2008 18:31:13 +0100
Message-ID: <bd6139dc0811110931g6a04335dp925dd09f2afaee03@mail.gmail.com>
References: <200811101522.13558.fg@one2team.net>
	 <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
	 <1226398000.7541.11.camel@minastirith.xtradesoft.lan>
	 <20081111171816.GK2932@spearce.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Raimund Bauer" <ray007@gmx.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Francis Galiegue" <fg@one2team.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:32:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzx6N-0004cH-Qr
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYKKRbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYKKRbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:31:16 -0500
Received: from el-out-1112.google.com ([209.85.162.177]:24100 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbYKKRbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:31:15 -0500
Received: by el-out-1112.google.com with SMTP id z25so1474164ele.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 09:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=seru1s/MoJ7s8TNPTX/MA8EHf8JTC138iKX6h4BDg1o=;
        b=ZYS6zDr7C2vRhUfGCO7sWL+DNOwKOdw8HpYQUxqvh2f0eMTxELHnbwx5cMSohT0thc
         HE1aLaxAOV4outpYP0SSOJXeVcykb0W+hJtDwZ4XpL8mu+DOtF4EGP16UfxFppxcsKR2
         nLI0x7VyRW8IPdvqdf79WmFdMd/cK0Zn4GEns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=vM6PuTx+zo1bjPt8/yaDx90hkRcw4WMfj4sL+P/0UjTZrx5fRt3WWliRv3oIkncLvS
         UBNhQ01eiH4fYn+e899uRG1Yb0slogCXbIAkP82+30A12sQD0cdfy4/BFa5NnJTdOBwf
         Ky9mp3RdnJ6EvRppo3jQZleqUIYN5UuSDHWPs=
Received: by 10.151.148.2 with SMTP id a2mr12317760ybo.212.1226424674060;
        Tue, 11 Nov 2008 09:31:14 -0800 (PST)
Received: by 10.150.97.16 with HTTP; Tue, 11 Nov 2008 09:31:13 -0800 (PST)
In-Reply-To: <20081111171816.GK2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100659>

On Tue, Nov 11, 2008 at 18:18, Shawn O. Pearce <spearce@spearce.org> wrote:
> I don't know how the Eclipse foundation feels about distributing
> LGPL in the IDE.  One of our major reasons for going with a BSD
> license on JGit was so the Eclipse Git team provider plugin could be
> distributed alongside the CVS team provider, as part of the basic IDE
> team provider package.  We're clearly not ready for that wide of a
> distribution, but it was a goal Robin and I set out for the project.

Why not keep that as a goall? For now, you can stick with one of the
existing LGPL implementations, later, when you want to have JGit
distributed with Eclipse, you (or Johanness Schindelin when he has the
time) write up your own Java version of it and license it BSD

-- 
Cheers,

Sverre Rabbelier
