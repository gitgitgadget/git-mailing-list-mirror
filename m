From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: gitweb calls the project ".git"
Date: Wed, 07 Oct 2009 22:01:38 +0200
Message-ID: <1254945698.7415.1.camel@localhost>
References: <E66B0797-4EF0-49FC-AA01-8FD4C884A7E9@sics.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Rasmusson <Lars.Rasmusson@sics.se>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvcpI-0005vB-Gm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 22:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759879AbZJGUCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 16:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757042AbZJGUCP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 16:02:15 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:46512 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbZJGUCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 16:02:14 -0400
Received: by fxm27 with SMTP id 27so4969314fxm.17
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=MjVAhyOu1rDv1yZw9DO+dt3divCffrc35S+szV9sBnI=;
        b=O5dAyoZRqXBR4T9ufNOHsLfIkJfphooBMZC+2qEBVjn/W+btVBYLrknf4+8nHjJ32u
         x3iDcseOB5A8Uo92XmYsgne1vk43bOKlSCY6Cson9z2BweeLCvz2HgjZGvAyhE9jGMAh
         MySlud21P/mN9tRlljmcrbfyCH7YmNwMZeUwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=A3/XkHT8il/t4soRJZWgEBlXMiucCkQ+Y3GiMvMykRHzWcdqdHkZwRgchO4ngmupMh
         fJyEtcP6CbTogWWgdGVP5YlFwFNs4SfLivQ0+aP3XKR0PytsI4IX5t8BvTRsOBvy5ysU
         gYxDcBgHL1flXjxggdaLPFst+aq9sqdH4fANs=
Received: by 10.86.163.5 with SMTP id l5mr341951fge.3.1254945697882;
        Wed, 07 Oct 2009 13:01:37 -0700 (PDT)
Received: from ?192.168.1.2? (host33-1-dynamic.50-82-r.retail.telecomitalia.it [82.50.1.33])
        by mx.google.com with ESMTPS id l12sm352831fgb.26.2009.10.07.13.01.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 13:01:36 -0700 (PDT)
In-Reply-To: <E66B0797-4EF0-49FC-AA01-8FD4C884A7E9@sics.se>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129657>

Il giorno mer, 07/10/2009 alle 18.31 +0200, Lars Rasmusson ha scritto:
> Hi, I am serving a repository with "git instaweb".
> 
> In the web browser, the name in the Project column is only ".git", and  
> not the "myrepo.git"
> which I would like to have, and as it is on http://repo.or.cz/ (which  
> is a site that also uses gitweb).
> 
> How do I configure it to serve the project directory (or even better,  
> all the repos in a directory), and name them appropriately?
> 
> (Is it possible to do with instaweb, or can it only be done with a  
> more heavy approach like using apache?)

as for I know by default you should create a simbolic link to your .git
directory in /var/cache/git/

the name of the project depends of the name of the symbolic link

example: /var/cache/git/yourproject.git --> /your/project/path/.git/

Bye,
Daniele
