From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 14:07:20 +0100
Message-ID: <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 14:08:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2pa-0007e9-RG
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 14:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab1B1NIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 08:08:01 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62367 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab1B1NIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 08:08:00 -0500
Received: by gxk8 with SMTP id 8so1502575gxk.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=w1k8esfXS5N9z9sCnC0BaV+P4EiOudJglAzZH+CFdG0=;
        b=ivhfhkzUzXyZMZDQu8gj47+IG+2VQ9I32Fjryj5+jvtHfrBfQ9SEI1/kWNOHwkRJsh
         qDimkXI+KCTcZa8ZqaJgh+KcLjUWPwOz0V33qvhuzeMi55Ud1s1/1sQoXTAkj5DuRo2v
         n3VkM6DlNY3x++vtS+cHU3jRPf0g4ctS/IlPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dixxL4TIOUjRrOPIJgEEAlvr8UnE5w50uFkVvitLQ7mK3hL2pGo0u82hjTVftDprUy
         f5UTF0cBjI41O4XdSypIgagdQlR0uGO0dxNFMaUFDq76dQQcfBu/zpz+hzb0pSWNXiQH
         qY3gslNHMZi7nfqgMMw5QwqmGJypUR7c5VA8A=
Received: by 10.151.87.16 with SMTP id p16mr7140818ybl.121.1298898480075; Mon,
 28 Feb 2011 05:08:00 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 28 Feb 2011 05:07:20 -0800 (PST)
In-Reply-To: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168107>

Heya,

On Mon, Feb 28, 2011 at 10:49, Junio C Hamano <gitster@pobox.com> wrote:
> The basic idea, which comes from Shawn Pearce, is to run index-pack on a
> packfile being verified, and compare the resulting .idx file with the
> existing one, and make sure they match.

Do you have any timings, on say, the kernel repo?

-- 
Cheers,

Sverre Rabbelier
