From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 21:19:36 +0100
Message-ID: <fabb9a1e0911251219t3ad0dacen67d8615ef6eefa02@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com> 
	<7vr5rmwgbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOLJ-0000LT-IO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935019AbZKYUTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935016AbZKYUTv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:19:51 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:59005 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934984AbZKYUTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:19:50 -0500
Received: by vws30 with SMTP id 30so17591vws.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=z6Urjs4k3bgLMFm8pQgRrxyDaL4P2xg5FK0ObbeDewE=;
        b=bDFgwCxcxbxI5xHQHGDKAN7kPpGgcVs3dixrhmvGbv0cnUu5oxOFBuaatXhpw8WTqt
         7wvYymaB8ATXWYl0Nm0OSa++rCeF5VX+Ki2ECs1bsBLFpv5AxplIS2KwlG0D3VPc3NzF
         kE09CSRdRJXjHr1Vw4MCA888cx7TQkYrGJpgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nbjxggKrUbWTs/StnQHdVPjSWvPiSKnGADClsf7ETo3up5L9PN0azQSfYEkHtgStyZ
         5pYcGEn4C4U0i6/nSrwCZ78Ij32bYj0ksRfdENGLc9ga+92L9JhWScD0DjmLblsauvvo
         /F6Vav5ho48cE+vg0+rxbQj/af6VgWcQYUSbU=
Received: by 10.220.125.106 with SMTP id x42mr9854170vcr.44.1259180396267; 
	Wed, 25 Nov 2009 12:19:56 -0800 (PST)
In-Reply-To: <7vr5rmwgbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133666>

Heya,

On Wed, Nov 25, 2009 at 20:32, Junio C Hamano <gitster@pobox.com> wrote:
> The standard answer given by others has been "you can always say '.' at
> the end; having to remember/count number of ../ necessary is much much
> more inconvenient".

A commandline flag to keep the old behavior then perhaps? "git config
alias.gr 'grep --no-full-tree'" is not that hard to write either.

-- 
Cheers,

Sverre Rabbelier
