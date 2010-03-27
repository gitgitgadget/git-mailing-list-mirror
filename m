From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Sat, 27 Mar 2010 21:29:34 +0100
Message-ID: <m2iq8hh5jl.fsf@gmail.com>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
	<20100326124650.GA12215@coredump.intra.peff.net>
	<7vwrwykhee.fsf@alter.siamese.dyndns.org> <m239zmdcz5.fsf@gmail.com>
	<7v39zm7epf.fsf@alter.siamese.dyndns.org> <m2r5n5vlld.fsf@gmail.com>
	<7vbpe9u19g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 21:29:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvcde-0007pp-Fw
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 21:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab0C0U3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 16:29:41 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:40533 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0C0U3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 16:29:40 -0400
Received: by bwz1 with SMTP id 1so2639283bwz.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=sfCBM4J1iTTFs5emhPcpbyvij/NxM93YCv+dIMsxdfI=;
        b=Ap6XKZ6qPvKNisi7iDv2CUVa/R4NXz+o6PBNrT/P0eqzSWKU9+nWcTXeN2wVNYAup6
         k+Txjf+mF0imiE/snoBVDkOONKKLjFwuVx2hAmVwv/WEYSQXNV0ypqMKP8RbXLckwdg0
         stuchtcRc8lXAzKSBka5usfBUpwrdTsN8U+yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=YcQ7lrkw2OCCi8fiNkxRCYOF2r0Bk1ndh8vWChwvs3GyIKgVwh+NTtAa7y4SNZwhoY
         u4v9FxLeB85H0c6Q6XtlDiVpAfdR2unXBHy9137adWsyAaRLIpMl6l5Gh1CeGA2e03dB
         2qctHf75PljpcWW4B/6XwU+XFsRzdorKzLZQ8=
Received: by 10.204.81.134 with SMTP id x6mr4050833bkk.32.1269721778856;
        Sat, 27 Mar 2010 13:29:38 -0700 (PDT)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id s17sm20853589bkd.10.2010.03.27.13.29.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 13:29:37 -0700 (PDT)
In-Reply-To: <7vbpe9u19g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 27 Mar 2010 10:23:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143357>

Junio C Hamano <gitster@pobox.com> writes:

> Francis Moreau <francis.moro@gmail.com> writes:
>
>> Do you have any tricks for this case ?
>
> I use PAGER=cat only inside Emacs, so I don't see how "log" can be a
> problem.

what do you mean by this ? Do you mean that you run git-log outside
emacs ?

> Of course you have to limit the extent of "log" in "M-x compile" mode,
> but that goes without saying.

Yes but in this case (log inside emacs) I was actually wondering if you
were using any tricks to avoid limiting _manually_ the extent of
git-log. With PAGER=less for example, the extent is _automatically_
limited by the pipe, which I found convenient.

-- 
Francis
