From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Thu, 6 Mar 2008 00:23:27 +0100
Message-ID: <8aa486160803051523t51a8294fwc55d9e41e61cc733@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
	 <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
	 <7vwsogkckx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2yb-0001Rd-2E
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763811AbYCEXXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 18:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762563AbYCEXXe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:23:34 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:7767 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763254AbYCEXXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 18:23:31 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2236113tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pTBTlz5gsnqhhJt6XDOq2v+aGELN7iM6tjcikxm5+Gc=;
        b=Dg9vLifDstjlc6qIHOVUpDNNBcYlqB3KEro2mnRy/H6ovLIgW67GaGEWfzGpq/dWkrFmj4Kx302v7IlYLknrpm7EuOTw/ITbEQtUtAcJEXz55YyujZVtP1Y6dQWBuSMFXbKfeOL66Tafx9Y5BYLwxaFeetv0N/vNkw08H2NtrYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U7AdREo7aIYQLiaq8R6gxpgy4JH6pjeCfh9ypIzH2/ZgumTYx6ovpOVh0cCzGDb8BNLoJ9nYtaYPRbpsnZP5zuXVJUhkoNCSoSzrIZu8MDvRMyZ1EwbYCw3ZJd/zxf/6qszqR2kN712kQEM3R5Hd/Nk4gsCMAJAeIHIpRo8KigU=
Received: by 10.150.201.13 with SMTP id y13mr1561639ybf.53.1204759407334;
        Wed, 05 Mar 2008 15:23:27 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 15:23:27 -0800 (PST)
In-Reply-To: <7vwsogkckx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76289>

On Wed, Mar 5, 2008 at 11:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>  > On Wed, Mar 5, 2008 at 10:29 PM, Junio C Hamano <gitster@pobox.com=
> wrote:
>  >
>
> >>  Perhaps you can make git-init run a post-init hook script by
>  >>  default, and have ~/.gitconfig specify the location of it, and
>  >>  have it do whatever custom settings to the per-repository
>  >>  configuration file?
>  >
>  > I would still need something to prevent doing a commit without a
>  > locally specified name/email.
>
>  Yes, but that something could simply be "echo '[user] name'
>  >.git/config" in that hook, for example.

But I want a different locally specified name in each repository,
because I use different emails for different projects
(private/work/...).

Santi
