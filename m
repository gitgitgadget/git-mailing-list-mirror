From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Thu, 10 Jan 2008 23:49:11 +0100
Message-ID: <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
	 <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
	 <fm44ck$299$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Douglas Stockwell" <doug@11011.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:49:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD6DX-0003i3-6r
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYAJWtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbYAJWtP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:49:15 -0500
Received: from hs-out-0708.google.com ([64.233.178.247]:59201 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753674AbYAJWtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 17:49:14 -0500
Received: by hs-out-2122.google.com with SMTP id 54so788638hsz.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8hK+cJYaPitcc7n+2BIfhzLn/Ehar9OWdM1Zrid7TIc=;
        b=jhlxMkkfz6QcmA8AdOB7X6Yj2UUCWuS3DJVZQVWJvtsC0txlxRJSoO1eSRDJVZDGkR9P+Rpzj4ljJes4kfY2opmhSQ3aiHu2PBCzHgrQ/ALanzwycae2fNo7AmjRrGhorsszaZ8LXrPD6UyODurQKJM3pRat0ewZDJC4Djt4TmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wMhPZMlMP9x+5w7zRM6tkoiRwPi3O811/F7Cvc4PeRYh7LJxeM4cChpAZljG2ItuE5khPbpMhb4JdTcpMfLsJVQcqCjRjZflklcsu6QipxCdmMiodrbINv7avB8mSGI8kSnWxYwZV4qzvxDlsb8uL0/uHxL9kG/QqwDMmC7Usk4=
Received: by 10.142.229.4 with SMTP id b4mr1412916wfh.158.1200005351406;
        Thu, 10 Jan 2008 14:49:11 -0800 (PST)
Received: by 10.143.195.1 with HTTP; Thu, 10 Jan 2008 14:49:11 -0800 (PST)
In-Reply-To: <fm44ck$299$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70107>

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

I'm now getting:
Unable to initialize SMTP properly.  Is there something wrong with
your config? at /home/paolo/bin/git-send-email line 638.

I tried to get help on #git but I failed, it looks like other people
are getting the same error.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
