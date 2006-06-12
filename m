From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs import error
Date: Mon, 12 Jun 2006 16:01:32 +1200
Message-ID: <46a038f90606112101la88168xc5d540fe1220fbf8@mail.gmail.com>
References: <20060611234842.GA12713@prophet.net-ronin.org>
	 <46a038f90606111731q34fe431fn36d751b387ab69a9@mail.gmail.com>
	 <20060612035737.GA16580@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 06:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpdcO-0007B6-9W
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 06:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWFLEBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 00:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWFLEBd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 00:01:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:353 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751297AbWFLEBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 00:01:33 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1068887wra
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 21:01:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C0oqRBctn/CClbGBUFLDk8M0r9MCAGVK5fxUarTPZiBI9h/ZpLRhMAcFAVxPFaMcP4Aek/44raxc/LOXcIkfJj4IPbWVfP1D0/3hqcgBI2/bdtK+Vl8+l/c5K2xw7qaNHQrh2EG9meoc9KyxiU4O4km0fUERuLPA3DBnQjb50qs=
Received: by 10.54.79.17 with SMTP id c17mr5190248wrb;
        Sun, 11 Jun 2006 21:01:32 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Sun, 11 Jun 2006 21:01:32 -0700 (PDT)
To: "carbonated beverage" <ramune@net-ronin.org>
In-Reply-To: <20060612035737.GA16580@prophet.net-ronin.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21686>

On 6/12/06, carbonated beverage <ramune@net-ronin.org> wrote:
> On Mon, Jun 12, 2006 at 12:31:35PM +1200, Martin Langhoff wrote:
> > After each attempt, the import leaves a .git file around. rm -fr .git
> > before retrying... or just retry in a new directory every time ;-)
> >
> > (... we should die with a more helpful message here...)
>
> This error occurs on a fresh import attempt, unfortunately.
>
> rm -rf'ing .git and doing an import again always fails at the exact same
> spot with the above message.

Unsure then. Try with the patches I've posted yesterday that ignore
bogus-looking branches.

cheers,



martin
