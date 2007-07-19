From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 11:48:44 +0100
Message-ID: <200707191148.46228.andyparkins@gmail.com>
References: <11848281302504-git-send-email-aroben@apple.com> <200707190848.54655.andyparkins@gmail.com> <Pine.LNX.4.64.0707191058090.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 12:49:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTZA-0001Vt-9t
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbXGSKsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbXGSKsz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:48:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:57808 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXGSKsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:48:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so381386ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 03:48:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YDQ1bZTpDE7UR/7NQtTCgD1bhlvcG1b333V/0P0iKPmhx/p4xMKE4/p/9vgH8Qn+d5pZDEtG4xfyv6clz1uZpesQfo+NvRjPVLhLxL7xNys2v8ruSAJMI71+PNfqT9/VwMpKxcKtBSBYkU8KH4Or9a3yGP3CMkyizR8r47dTdg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VpPlKMMqOLr/gPfjfkyOhnNxpQR5FiZxs8IquZe/m+s+Q5CaQISY6NDROXUJGOK3IwbKGDXgKKHY0xQf7Wvn75bsAahMYnITxgw40K8ZPOCnnz4wbJzrEm3uTpOGM/Elcmgc4s8d5X1TGaGw8emIDvOkwPuXUVZp3ETO7jZrMhg=
Received: by 10.66.224.19 with SMTP id w19mr1093061ugg.1184842131797;
        Thu, 19 Jul 2007 03:48:51 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z40sm3520527ikz.2007.07.19.03.48.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 03:48:49 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707191058090.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52964>

On Thursday 2007 July 19, Johannes Schindelin wrote:
> Hi,
>
> On Thu, 19 Jul 2007, Andy Parkins wrote:
> > On Thursday 2007 July 19, Adam Roben wrote:
> > >    Well, it turns out we already do launch an editor in other places,
> > > namely "git am -i" and "git send-email --compose". So, this patch takes
> > > care of those cases as well.
> >
> > Perhaps I'm being overly pedantic, but it seems odd to put options that
> > are relevant only to porcelain under the "core" section.
> >
> > core.pager is in the same category - but that's already in.
> >
> > Would porcelain.editor be a better name for this variable?
>
> From my point of view you can put into "myWonderfulGit.editor".  It does
> not matter.

By that argument, why do we bother with subsections at all.  In fact why not 
call the variable "xhxhxjjjll.yqlaoospsp"?

They are meant to help the human remembering it.

> So why not just leave it in "core", also because -- strictly speaking --

That's what I said for pager - since it's already there.  However, since the 
editor isn't already in, it's not a question of _leaving_ it anywhere.  
Better that it goes in the right place when it is first introduced.

> those commands in git.git are not really your regular porcelain. They are
> tested with almost every commit, and therefore have a much better chance

So is every other porcelain command - almost by definition, porcelain commands 
are the ones we use.

> not to be broken inadvertently by changes to the core.

I don't understand the point you're making here.  Are you saying that we can 
rely on porcelain not to change or the core not to change?  I'm also 
wondering about these "inadvertent" changes that are getting made to git 
core - I've not noticed them before :-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
