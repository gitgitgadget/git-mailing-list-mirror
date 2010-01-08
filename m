From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Fri, 8 Jan 2010 15:22:29 -0500
Message-ID: <fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> 
	<20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> 
	<7vocl7yxef.fsf@alter.siamese.dyndns.org> <20100107200509.6117@nanako3.lavabit.com> 
	<7vtyux3bx1.fsf@alter.siamese.dyndns.org> <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:22:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLMF-0006f7-C8
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab0AHUWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 15:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408Ab0AHUWu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:22:50 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:48648 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0AHUWt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 15:22:49 -0500
Received: by pxi4 with SMTP id 4so2310078pxi.33
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g/YG+HsF6/+8drnJZRbnflMLPGzBZnC+t+xg3CYuDEQ=;
        b=nhZnuNipDgGQ8Ls1skI9H/DugHxlV/+fdNMXiRvIZZJabt5AC+qiZgGFnjDdG1yYp2
         aEt0ShvfrQz3kHraNpSENt0t6/VZbM0do22YLOAV+9djGm9fTcrkMj6HiCw3D4abJ0bB
         iasSeZ0t9GdsxT5GdqEX1gJ0MxH5FMryUCc5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iFRxwnIx3FEmSGTvJmygO6EzxH2xo3D3aza3zGNE5jR7u4aAV/yXbVHkoustJsK2DV
         9Cq343WVHecVM1xdteI4w+bAFXqtoFLJJA7jq/UnmEmS11dEbjoh2psiZv/vjPJBKYE6
         CeuKMCA1ApbKZByMRV3cahEA8CfJ0ER0sp2xk=
Received: by 10.142.122.5 with SMTP id u5mr120281wfc.171.1262982169077; Fri, 
	08 Jan 2010 12:22:49 -0800 (PST)
In-Reply-To: <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136469>

Heya,

On Fri, Jan 8, 2010 at 15:16, Avery Pennarun <apenwarr@gmail.com> wrote=
:
> This would resolve any other inconsistencies between the two as well,
> notably that non-interactive rebase sometimes refuses to do the rebas=
e
> I requested because "Current branch master is up to date," while
> interactive rebase is willing to do it. =A0(Personally I prefer the
> latter behaviour, since I don't like tools that think they're smarter
> than me :))

I taught rebase the -f|--force-rebase flag a little while back, you
could use that :).

--=20
Cheers,

Sverre Rabbelier
