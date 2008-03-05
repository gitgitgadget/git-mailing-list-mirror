From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Wed, 5 Mar 2008 21:36:51 +0100
Message-ID: <8aa486160803051236x2e184915hf5d2448a832f4c63@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <47CEFA62.4070209@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 21:37:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0Mo-0006OW-GF
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 21:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbYCEUg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 15:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbYCEUg4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 15:36:56 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:24629 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbYCEUgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 15:36:55 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2140851tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WarAOly77zU73K0qBvioWSNIu1ozNeLeIG0qS/gkGP4=;
        b=MHQT9H1kPZpUfxloMADUellqjBgHpk5K/9uNZxZ9x6ns+KAprVxDpGrkyipCB1cFQN0aU4tFzOc90EiZm01Db+oQzSpvFeL1bnoRCnnHtwdSqp7bKqFQwCflwN2R0YdEEqHc5Y22Bz7wM//SfouQ9K1I4IAAnOVh8bPclFRJVQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U2GA/WoU18Vdf546QvO+gG6ZBXMCn90E5cmsXWV0oZMHA2gbAS1ws39WHKTJQwKW0QmJ9CsQp5yqJt9hK/F6MqeigJ1rCksl5XoShqGSq/r8rztBXXsPBnbFDg6TJyQGawNhbvb1HvTkXeqMxhgsc6lq983KawUSi2pZcX4Q0QI=
Received: by 10.150.57.5 with SMTP id f5mr1447141yba.71.1204749411521;
        Wed, 05 Mar 2008 12:36:51 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 12:36:51 -0800 (PST)
In-Reply-To: <47CEFA62.4070209@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76259>

On Wed, Mar 5, 2008 at 8:54 PM, Jon Loeliger <jdl@freescale.com> wrote:
> Santi B=E9jar wrote:
>  > Useful when you want a different email/name for each repository
>  >
>  > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>  > ---
>  >  Documentation/config.txt |    5 +++++
>  >  cache.h                  |    1 +
>  >  config.c                 |    5 +++++
>  >  environment.c            |    1 +
>  >  ident.c                  |    6 +++---
>  >  5 files changed, 15 insertions(+), 3 deletions(-)
>  >
>  > diff --git a/Documentation/config.txt b/Documentation/config.txt
>  > index 4027726..d7e5b6d 100644
>  > --- a/Documentation/config.txt
>  > +++ b/Documentation/config.txt
>  > @@ -914,6 +914,11 @@ url.<base>.insteadOf::
>  >       never-before-seen repository on the site.  When more than on=
e
>  >       insteadOf strings match a given URL, the longest match is us=
ed.
>  >
>  > +user.default::
>  > +     If false the defaults values for user.email and user.name ar=
e not
>
>  s/defaults/default
>

Thanks

>
>  > +     used. Useful when you want a different email/name for each
>  > +     repository, normally set in the global config file.
>  > +
>
>  You already _can_ have a different email/name for each
>  repository, right?  Isn't the issue that you want to _force_
>  each repository to explicitly have these values set?
>

Maybe:
Useful when you want a different email/name for each
repository, so you can set this in the global config file and then you
are force to set the user.email and user.name in each repository.

(sorry for my non-native english)

Thanks

Santi
