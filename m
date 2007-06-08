From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH v2] Remove useless uses of cat, and replace with filename arguments or redirection
Date: Fri, 8 Jun 2007 22:42:44 +1200
Message-ID: <46a038f90706080342j3a5bb7abv58c78d7b532e29de@mail.gmail.com>
References: <466639D0.1040306@freedesktop.org>
	 <7vsl94sego.fsf@assigned-by-dhcp.cox.net>
	 <46676C35.60406@freedesktop.org>
	 <Pine.LNX.4.64.0706070506230.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Josh Triplett" <josh@freedesktop.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwbvg-0002ui-T1
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936012AbXFHKmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937143AbXFHKmr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:42:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:28668 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936012AbXFHKmq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 06:42:46 -0400
Received: by wx-out-0506.google.com with SMTP id t15so688262wxc
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 03:42:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+YxbY2iUzSnOITenkRNYfKuCC/Mm8U7UeA3C3aeGIDQk3Qlhlpvh4gApztfzt5/13d40oWZ0WEZeI9yJ0phkI5jldW9YMwwBLc8Lxmw/k1m9lh+r+q/kEKDLvEZGIQ963TI76Fa89VU79yZcyj0nPzLnQeg3dnj8H0k0+NBhB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S86MXOWBIltUvoadgMC8FfiUFqV9sGmwb0s7FC4R3BZ4g5SIjkvt6mNVKlWRh93kRs9hPSgI5/ICjesiNWd76gyck086b3YxYwcyFlNOv2CXr7M56a6xKWVyJxmN50hL9rKuUWYf0snT6Draxsn+hsT+H4KfxO2TgZTVw4VOVDU=
Received: by 10.90.56.5 with SMTP id e5mr2711934aga.1181299364771;
        Fri, 08 Jun 2007 03:42:44 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Fri, 8 Jun 2007 03:42:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706070506230.4046@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49459>

On 6/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Things like that are known to happen, and that's why "wc -l < file" is a
> better fix than "wc -l file | tr -dc 0-9". In this case, it might not
> matter for a long time, but why not stop being sloppy here and now?

Not sure if I'd call is sloppy, but I also prefer wc -l < file -- it's
definitely safer.

cheers,


m
