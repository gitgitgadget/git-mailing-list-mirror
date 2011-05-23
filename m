From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Gate between git and mediawiki : remote-helpers
Date: Mon, 23 May 2011 08:54:13 -0700
Message-ID: <BANLkTikax2T3BFs_wac-W8tWeiZ=YHsxvg@mail.gmail.com>
References: <BANLkTikTpfpBYddfWcBfzGTuHqLyQ0sE5A@mail.gmail.com>
 <BANLkTim+2Mv7bnfsNVAsn80MUx8-fjYZow@mail.gmail.com> <7vfwo6y1kg.fsf@alter.siamese.dyndns.org>
 <BANLkTinvnm7NvUs4BuGpBYsYKR0D1eP+cQ@mail.gmail.com> <vpqk4dhzsvh.fsf@bauges.imag.fr>
 <7vd3j9wll0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arnaud Lacurie <arnaud.lacurie@gmail.com>, git@vger.kernel.org,
	Claire Fousse <claire.fousse@gmail.com>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 17:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOXTA-0008K7-3h
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 17:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab1EWPyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 11:54:55 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60724 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab1EWPyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 11:54:54 -0400
Received: by qyk7 with SMTP id 7so923039qyk.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=smvcRYQZ+BTmObaW0kY6qLzjbKe4BhBCxF1cYYsqEE0=;
        b=NXi7FSACHOEmKYowInP6RRF5BUs+8rhyGaAtz48lFy2xzxbMOHZcHi/i6OkvVC8ahO
         QKaZsHUBtPVzXg7qkko7tQVgsiuJvouD8x1ySB5c1/Uygx7G89e27pNzUbgsXvHooD8q
         oJWZ3UhA1lyAJvjjLceAw8MyuSlaqxzTm77Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ut2bIsxNVjTVe4vKkMgUeeGET1nDgQiqIxM0tAoVpMiowXEz53S89ey0oT6hFLFJpA
         L6qr2iYew8GLnujLAHPa2ZmFkYlFd16cfFYkRw+eVmr/HOBesL5tjHmbnnmXb14DY0Fr
         CMTkWx5jlLcFwBceKFvxbf8frAsRQgECx3PnI=
Received: by 10.229.90.90 with SMTP id h26mr1921336qcm.103.1306166094136; Mon,
 23 May 2011 08:54:54 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Mon, 23 May 2011 08:54:13 -0700 (PDT)
In-Reply-To: <7vd3j9wll0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174248>

Heya,

On Mon, May 23, 2011 at 07:14, Junio C Hamano <gitster@pobox.com> wrote:
> I know it doesn't ;-)
>
> As "clone" is a moral equivalent of "init" possibly followed by some
> auto-configuration followed by "fetch" and "checkout", it is a natural
> consequence of already supporting the "remove.<name>.vcs" configuration
> variable, and if we want to avoid the insane svn+http:// syntax, it is a
> logical thing to add such support.

We currently support either:

git clone mediawiki::http://some.where.xz/wiki

Or say:

git clone svn://example.com/some/svn/repo

-- 
Cheers,

Sverre Rabbelier
