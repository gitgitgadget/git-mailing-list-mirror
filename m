From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Tue, 27 Nov 2007 21:59:00 -0500
Message-ID: <9e4733910711271859w7b7dc141q93e3c9f67693a54@mail.gmail.com>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
	 <7vr6ibb3x7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKx4-0004k9-38
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:19:34 +0100
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxDDo-0002DW-Ja
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:04:20 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxDDg-0006oH-6q
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760111AbXK1C7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 21:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760092AbXK1C7B
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 21:59:01 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:48998 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760081AbXK1C7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 21:59:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1080838rvb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 18:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NzQLE9NQgx4jEy5DN4Hfp1LmkwR9W9ftprDxaDq9IXE=;
        b=XOgbbLxYCGsBmDz1/Px2oLdPwOQwZ+bxKEGY6AjNGuFwUDOOXq7L/IJOYErd0b2/I+3p5pUV9+GWrr6FcCmdpQUgyJ4GAOkE6kQhMh1Ua+uAmM6oDmDjf9NCQ+gFgTL8geLe7kjofGfM3DkyHLSoSh+B/45DvEJpfRSAlZ0a1Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ua/dVxVIIJgSGCc227WT3xixwbvELQWQWGxaalq4gNEITWDhH7rOhY+1M7ZEw5Bo74DMT5g0AltTeoZZIygt+1kVm/Mco2HdEs3VBYmV3jFIAsRgeUJgrBBMdFKDBGV2Y3EpR67BH3llLdyRoqa5EifgwVQibtCOppfaAIwuGag=
Received: by 10.114.154.1 with SMTP id b1mr176019wae.1196218740367;
        Tue, 27 Nov 2007 18:59:00 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 18:59:00 -0800 (PST)
In-Reply-To: <7vr6ibb3x7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.2, required=5.0, autolearn=disabled, AWL=1.773,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 1919BE48F39303CF7E04AAA956DBCFFD9F53B618
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -51 maxlevel 200 minaction 2 bait 0 mail/h: 4 total 723731 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66292>

On 11/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Can we add a check in "git rebase" so that it will refuse to run if
> > stg is active?
>
> The pre-rebase hook has been there since early Feb 2006.

Karl, Catalin, can stgit install a pre-rebase hook and disable 'git
rebase' when stg is active on the branch? This would keep me from
destroying my patch stack when my fingers get ahead of me. Might be
good to disable anything else that can cause damage too.

-- 
Jon Smirl
jonsmirl@gmail.com
