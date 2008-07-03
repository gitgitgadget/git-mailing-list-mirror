From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] fix typoed config option 'indexversion' in man page.
Date: Thu, 3 Jul 2008 03:24:59 +0200
Message-ID: <237967ef0807021824i2d825c6ej4defcf5b56a48ae2@mail.gmail.com>
References: <alpine.LNX.1.00.0807030303580.30922@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 03:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEDaA-00083i-2b
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 03:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYGCBZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 21:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbYGCBZA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 21:25:00 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:10906 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbYGCBY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:24:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so728908rvb.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3/IovmWcfIjW8rnnQghuYw2i4aFi2QqczhTlaqyWFvw=;
        b=EjtuxsmeuWQsKRHuQMKsff3+orNnHaU7vNp7OohDy7UqgJTBxCnN8vEJiBvP5sP4G2
         uFay78UVaTveWYf7eA+gRBIRmuyq8YNUqS5Z+Il+HnjsPR0X8gcE9i0eYfsZ6rbjkFhn
         P/NAf191Zkmu0jQm32R61xNgjDpN5LHxHfJd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ka1KJ1F4bZWBzftKOe/NYvyV6IVXKot05L4FG4BbbFwLvJrTSIGodHvOHH73vA/dje
         80tuB5FXXY/jPylVacuqbLv3soRnFBoP7+V4nm3Sqi9iAht3AjqyAVC6HpdKgpktxP0h
         ch6kAADn0eR164Kgm+FYCWsbx1z0LjuCDMQEI=
Received: by 10.140.135.19 with SMTP id i19mr4780666rvd.70.1215048299604;
        Wed, 02 Jul 2008 18:24:59 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Wed, 2 Jul 2008 18:24:59 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0807030303580.30922@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87218>

Blah, ignore me of course. I broke the old rule of not sending patches
after midnight :).

2008/7/3 Mikael Magnusson <mikachu@gmail.com>:
> ---
>
> Noticed by David Parra on #git.
>
>  Documentation/config.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 52d01b8..fd56dac 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -945,7 +945,7 @@ pack.threads::
>        Specifying 0 will cause git to auto-detect the number of CPU's
>        and set the number of threads accordingly.
>
> -pack.indexVersion::
> +pack.indexversion::
>        Specify the default pack index version.  Valid values are 1 for
>        legacy pack index used by Git versions prior to 1.5.2, and 2 for
>        the new pack index with capabilities for packs larger than 4 GB
> --
> 1.5.6.GIT
>
>



-- 
Mikael Magnusson
