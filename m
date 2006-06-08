From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 16:49:43 +0200
Message-ID: <81b0412b0606080749k25a306cetf44a50836998ae09@mail.gmail.com>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1149775348.23938.236.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 08 16:50:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoLpU-0006jZ-A4
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 16:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWFHOtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 10:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWFHOtp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 10:49:45 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:8223 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964842AbWFHOto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 10:49:44 -0400
Received: by py-out-1112.google.com with SMTP id x31so666082pye
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 07:49:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eDvK/osbZecF07d1aBKfXMG9US0efvwIUcmgkk1ULPsDu8IO8/LBb7FqheRQarOWjCjtv+zlWpk4tdLgw7nrV3IMnOGaPXs1mCt7HyxPsl3dLLNYDVLMcFlFRb9wB//MaeXdTWGfeeIRIMURcnzlDg7ksOEweD5x2F86TlLFSNA=
Received: by 10.35.50.9 with SMTP id c9mr1069353pyk;
        Thu, 08 Jun 2006 07:49:43 -0700 (PDT)
Received: by 10.35.74.15 with HTTP; Thu, 8 Jun 2006 07:49:43 -0700 (PDT)
To: "Jon Loeliger" <jdl@freescale.com>
In-Reply-To: <1149775348.23938.236.camel@cashmere.sps.mot.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21492>

On 6/8/06, Jon Loeliger <jdl@freescale.com> wrote:
> --repo   into $GIT_DIR/.gitconfig  <- current default, right?
> --home   into ~/.gitconfig
> --site   into /etc/gitconfig
> --share  into /usr/share/git/config

BTW, if we go that far, maybe it makes more sense to
implement a way to include files other config files?
So repo-level config can (maybe implicitely) have an
"include ~/.gitconfig" which in turn can "include /etc/gitconfig".

We could even do like C-preprocessor does: relative
pathnames can be searched in a defined set of directores.

That's all overengineered, probably. I never needed .git/config,
except for switching exec-bit (which I'd like to have on per-site
basis, to be fair).
