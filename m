From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Mon, 16 Nov 2009 23:04:12 +0100
Message-ID: <fabb9a1e0911161404u56b1498cpfea7650f6c46845e@mail.gmail.com>
References: <cover.1258309432.git.trast@student.ethz.ch> <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch> 
	<alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de> <7vpr7ip7ji.fsf@alter.siamese.dyndns.org> 
	<alpine.DEB.1.00.0911162213590.4985@pacific.mpi-cbg.de> <7viqdannxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 23:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA9gl-0006Dl-En
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 23:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZKPWE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 17:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbZKPWE2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 17:04:28 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:50044 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbZKPWE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 17:04:27 -0500
Received: by fxm21 with SMTP id 21so3231248fxm.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 14:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=093mQZR+Y38sPwaK3NLxXjsF+Oa0uZYUIfzpEK5GJnE=;
        b=WmzbR4eyTfQGZwecnavnXeYlHbRNGRgrubm2CRIKPpwCIf/yq3DFq365eOtGKOOFhG
         4JA/yQAaF99JOl9isl9HI4DvRzQylghypDwzEWe1C8ZZrxaVTewcYILpRTIkfqwN323a
         Bc1+1OGDKilVLGwcO0Rtiriw5mAh8vxaxH0is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ldoHlPC+ELFIPwODJGe96bYv7SP/+OqrYVLSIvgeQjCEvRsLW++TxJy1qc00bhdAEh
         xx2D2q7nAofrylYj64oH2Ood5KKBlXzaEYEt4/2CGGOgtKy12iok/K+Ue+D6RNQJi6tg
         eU1y8khS16BEs6LEZvhMaJItUbafcWL8HKi1c=
Received: by 10.216.85.17 with SMTP id t17mr643186wee.178.1258409072181; Mon, 
	16 Nov 2009 14:04:32 -0800 (PST)
In-Reply-To: <7viqdannxo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133029>

Heya,

On Mon, Nov 16, 2009 at 22:45, Junio C Hamano <gitster@pobox.com> wrote:
> I can _guess_ what you are _not_ talking about but I cannot tell what you
> _are_ talking about; sorry.

I would hazard a way for the merge strategy to indicate whether it is
fit to be used as rebase strategy?

-- 
Cheers,

Sverre Rabbelier
