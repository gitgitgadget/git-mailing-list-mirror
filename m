From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Thu, 10 Jan 2008 12:13:04 +0100
Message-ID: <4d8e3fd30801100313n32465ef3p4946c1f7f57e144c@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
	 <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
	 <fm44ck$299$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Douglas Stockwell" <doug@11011.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:14:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCvMI-0000WJ-TJ
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 12:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbYAJLNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 06:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbYAJLNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 06:13:09 -0500
Received: from hs-out-0708.google.com ([64.233.178.247]:32145 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757168AbYAJLNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 06:13:07 -0500
Received: by hs-out-2122.google.com with SMTP id 54so579672hsz.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 03:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=b2QzGdtjxeZKuO9pK/TI1HY/dVRh+Y85pMSvZna5xgg=;
        b=SI1txLozhZIr5A6zVIvl7U1mxst5WgvauA3ev3qkxTgUUhjcVdSvCJzdE7sVv2KCqlmZp5C8uITkd2OfWHpmnG0z4CjOt+9Ua2cIUsqO/RccyqxBuNmzZZJmNRomenkmMN/hswdWUoN2OeQBQcQ9ZzhcgHB/j+uVUIdD9G5FuT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KIXl8e7WkJM7cfMSY26Bc4irNYijK9PaOyD22gpyd5jOOWcFuEF7ujLPlfeP4tKoETE7ZLgCrIx8SQbr56an4QyPkIhAk4rtBg/QrjmLHnxMKY1gkD4IjN43j1ltfKQRl7t0tLwJ1UC5KOt1Qqt0l6uu+9t/QKEu/ecKnZX4uxI=
Received: by 10.142.212.19 with SMTP id k19mr808206wfg.200.1199963584664;
        Thu, 10 Jan 2008 03:13:04 -0800 (PST)
Received: by 10.143.195.1 with HTTP; Thu, 10 Jan 2008 03:13:04 -0800 (PST)
In-Reply-To: <fm44ck$299$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70058>

On Jan 10, 2008 4:45 AM, Douglas Stockwell <doug@11011.net> wrote:
> Paolo Ciarrocchi wrote:
>
> > Well, it would be nice to add this information to the wiki, it's still
> > mentioning
> > that you require an external program for supporting the TLS connection.
> > I'll do that when I'll get my box working with the configuration you suggested,
> >
> > What I'm getting at the moment is:
> > paolo@paolo-desktop:~/git$ git-send-email -compose -to
> > paolo.ciarrocchi@gmail.com /home/paolo/Desktop/patch/
> > snip
> > snip
> > Can't locate Net/SMTP/SSL.pm in @INC (@INC contains:
>
> As indicated, the module you need is Net::SMTP::SSL, if there is no
> package for ubuntu, you can install it using CPAN:
>
> perl -MCPAN -e 'install Net::SMTP::SSL'

Thank you. I'll try that and update the wiki with the information you provided
as soon as I have git-send-email working properly :-)

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
