From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 13:48:02 +0100
Message-ID: <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
	 <474C0105.3010908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 13:48:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwzrX-0008Uq-2j
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 13:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbXK0MsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 07:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbXK0MsG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 07:48:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbXK0MsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 07:48:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1225698ugc
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 04:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QhFxi4MBBDsc0LWlBookt3J2yjHdPWIAxBlC3ppzxZA=;
        b=CgPoHCKikWOhoEfwQ1W7SMMwkWhliEKFvGt7VkZxApXpVrgx4r6Mihc5UBxZZOFq9PdXoWbNOxN+bE61HcDJGe9vDigIp6WwtpLUNypqTM8uqFlYi1zc8BkRSR5hDudTwt0Ii84m5A9tIm1QoIqFRqb7EFvCEx6CKlllBw6J2E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=POtGcw5lZvgKw4inFRO7IpzfgMaQk8gOzJS97osfM4U0obonw5G4yTvJW1P9RByOk7kjYPwUALA7NimF4Umt7ZCMzP85oMO+Qt2wP/PXLbRAGGvuWiPFakW0hibxbqyErbQQQwSjuS+UKGFzLiUl3zpMllOvbWwvOwG2saruxKQ=
Received: by 10.78.123.4 with SMTP id v4mr4152329huc.1196167682273;
        Tue, 27 Nov 2007 04:48:02 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 04:48:02 -0800 (PST)
In-Reply-To: <474C0105.3010908@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66201>

On 27/11/2007, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Alex Riesen schrieb:
> > The option is to enable operation exclusively on the index, without touching
> > working tree. Besides speeding up commit process on performance-challenged
> > platforms it also has to ensure that the index is commited exactly how
> > user sees it.
>
> Huh?
>
> Doesn't git-commit operate only on the index, unless you pass it extra
> arguments?

It doesn't

> What am I missing?

run_status and check for changed files
