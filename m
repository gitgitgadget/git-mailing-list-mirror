From: Santi <sbejar@gmail.com>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 01:18:10 +0200
Message-ID: <8aa486160609241618w32501999rc7dcec1d16db440e@mail.gmail.com>
References: <20060924212142.GB20017@pasky.or.cz> <ef6tt8$2un$1@sea.gmane.org>
	 <Pine.LNX.4.63.0609242347090.25371@wbgn013.biozentrum.uni-wuerzburg.de>
	 <ef730t$dk9$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 25 01:18:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRdEs-0001Gs-4b
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWIXXSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWIXXSM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:18:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:33914 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751350AbWIXXSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 19:18:11 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1628384wxc
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 16:18:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d6Yeqo0cPUI2ArYKcGx37eGDN0xjpJRFPTUTW1+PXRDnOskUxl2CrFpHR2K2JkEtx6Hng6xqJodhGEcnS6aLayuC5UikPnbYriUbqyTeTrEPefpeucxH9vw/REv9qP2USXlX9dX70fHM2YRSf1wiCTbxzugnXIYN+U3e97mIK5U=
Received: by 10.70.129.6 with SMTP id b6mr5893450wxd;
        Sun, 24 Sep 2006 16:18:10 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Sun, 24 Sep 2006 16:18:10 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <ef730t$dk9$3@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27715>

2006/9/25, Jakub Narebski <jnareb@gmail.com>:
> Johannes Schindelin wrote:
>
> > On Sun, 24 Sep 2006, Jakub Narebski wrote:
> >
> >> If I remember correctly currently only some functionality provided by
> >> remotes file can be provided by [remote] and [branch] sections of git
> >> config.
> >
> > ... and what might the lacking functionality be?
>
> What about
>         Pull: +refs/heads/pu:refs/heads/pu
> functionality, i.e. allowing force-update (non fast-forward) fetches?

[remote "git"]
url = git://.../git.git
fetch = +refs/heads/pu:refs/heads/pu

>
> > .git/remotes/<name>    config
> >
> > URL:                   remote.<name>.url
> > Pull:                  remote.<name>.fetch
> > Push:                  remote.<name>.push
> >
> > You can even have multiple entries in the config, and it behaves as if you
> > had multiple lines in .git/remotes/<name>.
>
> And first pull line is default branch to merge, all the rest is marked
> as not-for-merge?

The same way as with .git/remotes/.

the .git/remotes/ files and the [remote] sections are equivalent, modulo bugs.

   Santi
