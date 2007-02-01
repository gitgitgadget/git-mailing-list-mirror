From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 1 Feb 2007 10:53:08 +0100
Message-ID: <81b0412b0702010153m301a3603idc182df8abbf89a@mail.gmail.com>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	 <20070131231942.GB31145@coredump.intra.peff.net>
	 <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	 <20070201030030.GA1979@coredump.intra.peff.net>
	 <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	 <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 10:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCYd2-0000bq-FO
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 10:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbXBAJxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 04:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbXBAJxM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 04:53:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:21228 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422724AbXBAJxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 04:53:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so418289uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 01:53:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OIbm0eNjVzp+sESCE81ODauUYH81NnRjg/ZTMZd2F6h/R5qVIMvz7Uk1ReFJLWLwDUUnMDllNQUYrQyShoaofmoBG00dSS5xOO3PGuVIQ+ve9EzuiCc7DNNsSABO6nGIwQuqfwfgmdIJhE/Qx1zqsXxhTdsrm/E9wvG3NWwSW8U=
Received: by 10.78.138.14 with SMTP id l14mr452750hud.1170323588579;
        Thu, 01 Feb 2007 01:53:08 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Thu, 1 Feb 2007 01:53:08 -0800 (PST)
In-Reply-To: <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38337>

On 2/1/07, Junio C Hamano <junkio@cox.net> wrote:
>     [git.git (master)]$ git checkout master^
>     M       git-checkout.sh
>     Note: you are not on any branch and are at commit "master^"
>     If you want to create a new branch from this checkout, you may do so
>     (now or later) by using -b with the checkout command again. Example:
>       git checkout -b <new_branch_name>

How do you detach HEAD _without_ changing working tree at all?
IOW, is there a "git checkout --detach"?
