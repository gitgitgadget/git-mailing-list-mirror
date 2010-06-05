From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sat, 5 Jun 2010 15:58:11 +0200
Message-ID: <20100605135811.GA14862@localhost>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 15:59:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKtu9-0002OV-7Y
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 15:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933366Ab0FEN7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 09:59:12 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:63977 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933280Ab0FEN7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 09:59:11 -0400
Received: by ewy23 with SMTP id 23so28731ewy.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=kpdLQIesud4mvXKzFbkJhMaNCs0QOYJxOVs2trpI6y8=;
        b=pMPnVbFW1G+IngQ/HEZzK7BG4m9aYj7hWXUMYa/2uXQshYbe2GeRZCeHsNkMx2TS6z
         27Znzp2wwPvpp4kwOW77647l6GL2KlkDKnDJO9DCTI9bCrqsa33CZIlRYRWboXCN+Vqc
         dzCUIH1WYhqtzmv2cV1XcUlLIf1ks5sSSOfv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=PpDroFwg6NNuRRCbKUrVQ8o94gnY5MWnnA7BEJpfHvIII1JcJIdaO26BF+cecsPUFS
         sWy5N1GbMIQfT308jc28ggXTAXOGWpBo6ihIDHDunubbryRax7VQPl/Huv4mzLjJ3wsf
         EM6W9gakH4SuTqbKXjxd5roHtdCbL6t39MXis=
Received: by 10.213.112.144 with SMTP id w16mr9444514ebp.1.1275746349824;
        Sat, 05 Jun 2010 06:59:09 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 13sm1362933ewy.1.2010.06.05.06.59.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 06:59:09 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKtt5-00040P-Sw; Sat, 05 Jun 2010 15:58:11 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148471>

On Sat, Jun 05, 2010 at 03:29:48PM +0200, Sverre Rabbelier wrote:
>
> On Sat, Jun 5, 2010 at 13:09, Clemens Buchacher <drizzd@aon.at> wrote:
> > I think git checkout -t <remote>/<branch> is short enough for
> > creating a new tracking branch. For something even shorter, we can
> > create an alias. But I'd prefer to keep the already complex
> > checkout command a little simpler.
> 
> You're a little late to the party ;). Did you read the original thread
> discussing this?

Well, I just noticed this by accident, it is not documented
anywhere, and you cannot expected me to know everything that is
going on on the list. Should I not offer my opinion because of
that?

I could not make much sense of the thread that came with the patch.
The discussion first seems to conclude that it is a bad idea, only
to implement it anyway.

Well, I also think it is a bad idea, and I am not surprised to find
users confused by it.
