From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Tue, 22 Feb 2011 20:32:20 +0100
Message-ID: <AANLkTint8HXdoHJqEozASemU5g2gssPbGPefQWqd_4hu@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie> <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie> <20110222155637.GC27178@sigill.intra.peff.net> <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:33:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prxyu-0000rz-OD
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab1BVTdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:33:03 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48354 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab1BVTdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:33:01 -0500
Received: by ywj3 with SMTP id 3so1399719ywj.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6h6c2gnKCnSLb9qthG1pcMtAqhs2Ws3U/qYFkFht+V4=;
        b=IQwPZPSM9Wcu7qQ85Ck8/HRr6lC9GviomwcQaq0Fv0TQikCjG/CEL+QFdJufdUZi4m
         Kxw0g305h35SdQQ/Dlhm4LPQVOOjHHVOtRIxbd5eDECBBzsUbF1XyKpRSA8aCHCHVLXc
         giS/s6JszB6BssBbQwobpz9hXuxpzll3nxPtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pAupqsNGSqY/ari8VTnqqz2moaNlU+TY2Nq9aUji0xf4yqSSmMA+B82168mT9SFzcF
         Ak/ezo95Jxd8gDAzRfCAnTDHR+DXJj5Yn+FvgOxwjTAUbaTHfmGN/KyghWxG/ZtXjSIH
         gzIikAt533eg6LN0SNvc/BnB1FuDutKzMh49U=
Received: by 10.150.96.21 with SMTP id t21mr3856785ybb.20.1298403180112; Tue,
 22 Feb 2011 11:33:00 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Tue, 22 Feb 2011 11:32:20 -0800 (PST)
In-Reply-To: <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167580>

Heya,

On Tue, Feb 22, 2011 at 20:30, Junio C Hamano <gitster@pobox.com> wrote:
> Not that libgit.a in its current shape is very useful outside the context
> of the git.git proper, though.

Which is where libgit2 comes in right? ;)

-- 
Cheers,

Sverre Rabbelier
