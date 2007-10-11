From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 0/2] Add --dry-run option to git-push
Date: Thu, 11 Oct 2007 09:57:47 +0200
Message-ID: <8c5c35580710110057r29c1fe0w7f9e2825fa33@mail.gmail.com>
References: <2faad3050710101634s5ed39bcbn723184810bc265d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 09:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifsve-0007yI-5H
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 09:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbXJKH5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 03:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbXJKH5t
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 03:57:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:30345 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbXJKH5s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 03:57:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so426798rvb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L9lE7v4o9tJf1EyfD1slXB401lYyoVvoHuoaEd5QQKU=;
        b=rW1QLAYnwOlF3jOI7V6LZjy84uhQG+yemtKcXhmhZWlY6UpmBWSrmDt4dkcyfxxLdxvVyaqb5zQgoCX510Jwv8iOgSPCdF5N4HOQXfQ8/n8QpJ51s9C5L1TywjGhNwMWKWEE6lJIlEJrw4dQ3HR7IPEgGfGAOEWnVwIY73wu4Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JWc7pCnje1LiGoSwK9bzo8NN2dinqceSKrqqSO1rU9IqO07aHjOB8nEQ3LaMeAKqfproeXFlLg7ryOImsuP8IDl7Xbh9vAm+/ZySxdI3ib69S2FO6hOYQRTD68INYMUGkKoNjMsQ3S2ce8aA4xb2BXw9NHFzkqCEAx4k1nGYUbk=
Received: by 10.114.168.1 with SMTP id q1mr1853993wae.1192089468108;
        Thu, 11 Oct 2007 00:57:48 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 11 Oct 2007 00:57:47 -0700 (PDT)
In-Reply-To: <2faad3050710101634s5ed39bcbn723184810bc265d5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60586>

On 10/11/07, Baz <brian.ewins@gmail.com> wrote:
> there was discussion recently about the default behaviour of git-push
> having the potential to confuse, making it easy to push commits that
> are still cooking in other branches.
>
> Its also possible for newbies to make mistakes with refspecs, but
> there's no way to know if you've got the syntax right without actually
> pushing. Steffan suggested a dry-run flag, which I've always wanted
> too, so here's an attempt. Patches git-send-pack, git-push, their
> docs, and adds a test for git-push.

Maybe some of this description could be reused in the commit messages?

> first patch to the list and the mailer will
> probably mangle it (sigh)

Yeah, it did.

Would it be possible for you to resend with git-send-email after
adding proper commit messages? If git-send-email is not an option,
attaching the patches are preferable to the current mangling.

--
larsh
