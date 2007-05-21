From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] Submodule merge support
Date: Mon, 21 May 2007 17:42:57 +0200
Message-ID: <81b0412b0705210842jdbe2c97i6a89ca472e84bde6@mail.gmail.com>
References: <20070520154227.GG5412@admingilde.org>
	 <20070521062005.GK3141@spearce.org>
	 <20070521073253.GU5412@admingilde.org>
	 <20070521073758.GP3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Waitz" <tali@admingilde.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 21 17:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqA2V-0007wV-44
	for gcvg-git@gmane.org; Mon, 21 May 2007 17:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbXEUPm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 11:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbXEUPm7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 11:42:59 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:7641 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbXEUPm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 11:42:58 -0400
Received: by an-out-0708.google.com with SMTP id d18so383332and
        for <git@vger.kernel.org>; Mon, 21 May 2007 08:42:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sSZsOikhaxwfm3T+QDxvmin7u8bMuLZIQ6pEQJ3mn1UY4ykELnhQUj7I+gbrRt8zWJm5NyCu/REXbBcuG5BJvfDns3253WzXi6dd2A7bTJRk3bqPZeEvKF2lg+LV7UDtXuXF+ggLFkwizR8TmRlOuF7seMqbX1VRaqRlM9VWLCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MtjVryIsj0j+/JIgtCZiIjAYnYIir4AanZ5RFSZN2l5SbR6QfBf507I15Wi3rZw6U1fdTFiCGICW7fOrwGKOI+OYwN4O+dKiItPo18BllX37WA5GZ3rDsjsKPN8JWb8McJw7Sg4QsyNU48eukeXHDd6IWnRPH8kUK8T4Gz+ZBvs=
Received: by 10.100.37.4 with SMTP id k4mr3073854ank.1179762177744;
        Mon, 21 May 2007 08:42:57 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Mon, 21 May 2007 08:42:57 -0700 (PDT)
In-Reply-To: <20070521073758.GP3141@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48023>

On 5/21/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Its a very old Sun C compiler, and it doesn't like structs to be
> initialized that way.  Yes, newer compilers are better, and gcc is
> also better, but I'm unable to get our UNIX admins to actually do
> their job and keep systems usable by the users.
>
> /me starts to wonder why he continues with this day-job thing...

Because the new job may involve windows
