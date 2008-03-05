From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Thu, 6 Mar 2008 00:39:29 +0100
Message-ID: <8aa486160803051539v6813bf98kc0cd0408bb0c65a@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
	 <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
	 <7vwsogkckx.fsf@gitster.siamese.dyndns.org>
	 <8aa486160803051523t51a8294fwc55d9e41e61cc733@mail.gmail.com>
	 <7v7iggkavd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3DX-0006Gs-Nq
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbYCEXjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 18:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbYCEXjd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:39:33 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:8485 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbYCEXjc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 18:39:32 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2243825tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 15:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8mDloZMMFYyGz6ihXxpQCOEzmea2p59zoXxGz5IZYdY=;
        b=We14R0kA16Gaj2JdKwOu6iDYBBC8XiIMcub7nsQ+SzYZa/xYT0+bjr4l9cst32kLS5mdaWgLxbqD1/s6WVwNvbso1Ojgwb4FoKaPd2tTQczKBZUu5HdRqMkkWwi95K+Vu5jHOcZIFk3b93WWyUDjiBQ6BRMWohmOlTTkRi37Iuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wl9DbgkRYX7AsZ3A6mLot9wy3TAX6PYmHa4mvNLGrwKLz1BVp+WhEIHLVz9C/1EqANfifGovJp5cuEMZQeJHuQbE5ozw72FggZvxNkrAaOSyZYqINiDRfaecUXj+wQjj21e3+iaJZ862FaadTm7GZxlNjgVHgpH7j0qFhMAjkHI=
Received: by 10.151.108.19 with SMTP id k19mr1536203ybm.191.1204760369718;
        Wed, 05 Mar 2008 15:39:29 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 15:39:29 -0800 (PST)
In-Reply-To: <7v7iggkavd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76291>

On Thu, Mar 6, 2008 at 12:29 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>
> >>  > I would still need something to prevent doing a commit without =
a
>  >>  > locally specified name/email.
>  >>
>  >>  Yes, but that something could simply be "echo '[user] name'
>  >>  >.git/config" in that hook, for example.
>  >
>  > But I want a different locally specified name in each repository,
>  > because I use different emails for different projects
>  > (private/work/...).
>
>  You changed your mind then?  You said you wanted to have something t=
hat
>  prevents a commit from being made immediately after git-init before
>  per-repo user.name is properly configured.  Doesn't that echo achiev=
e that
>  goal?

But that was in the context of the initial patch where I said that I
wanted different name/emails in each repository.

To summarize, the problem is that I work in different projects
(private/work/git/...) using the same account, but I want different
identifies (name/email) in each. So I set user.name and user.email in
each repository, but when I forget to set them git uses the default
ones (userid@hostname.(none)).

Hope I have explained it well.

Santi
