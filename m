From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb and submodules
Date: Sat, 28 Jul 2007 12:29:16 +0200
Message-ID: <200707281229.17351.jnareb@gmail.com>
References: <200707271322.50114.jnareb@gmail.com> <20070727123229.GB31114MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Sat Jul 28 12:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEjRb-0004mM-TH
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 12:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbXG1KWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 06:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXG1KWa
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 06:22:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:37280 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbXG1KW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 06:22:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so78048nfb
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 03:22:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=afo8z8TclT8kBQwxHc5hIEIhAuhGRIWDHsjwTeSG5SLvnIr3tvUqEwoGfIJnw61/jfSHZ8idLGU+rrPiblxr9aPYE1P+mRsGXuyh6DVMxOwVdZbnbSN3VekRCqWSyZPiUfQJV6kWiAEgcJuQAWIU4krPADwoSvSehz37unKfknU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PhVhb4L8JwIywSi2Nb4aot6BY5rbQJ96j7xPQmjKIDXuYS1S/NBApJP7hCcd5Uy/iVaWfg8FkJOIYgQce0EobI9L03T+dCL3288ElF80++VHZvXpup6qvZpOM3bxepop0lscwrznOpQONkvUjJ/O0T5rDzKQTezn1gDu2N34HrA=
Received: by 10.86.26.11 with SMTP id 11mr2531805fgz.1185618147306;
        Sat, 28 Jul 2007 03:22:27 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id j2sm3130978mue.2007.07.28.03.22.22
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2007 03:22:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070727123229.GB31114MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54021>

On Fri, 27 July 2007, Sven Verdoolaege wrote
> On Fri, Jul 27, 2007 at 01:22:49PM +0200, Jakub Narebski wrote:

> > But for that I need a question answered: how to find GIT_DIR of 
> > repository which contains submodule objects? We have to assume in 
> > gitweb that repositories are bare...
> 
> You'll have to add a configuration variable for that.
> The submodule may not even be on the same server.

What do you think about using "submodule.$name.gitdir" configuration 
variable for that? It has to be configuration variable because the 
location of repository which has submodule objects doesn't change when 
checking out (or rewinding) to different commit in supermodule.

As a special case I'd use 'no value' to note that submodule objects are 
contained in the supermodule repository.

-- 
Jakub Narebski
Poland
