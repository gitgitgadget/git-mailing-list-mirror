From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 18:09:09 +0100
Message-ID: <20140124170909.GD396@x4>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Fri Jan 24 18:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6kFs-0000Hn-K4
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 18:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbaAXRJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 12:09:14 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:39054 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaAXRJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 12:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=4KfyhfVfg/GtVQGzaeCg71ME4f
	Ph4+YdvnWmCnHD3+E=; b=GAQ2ixCKC/Rkb9qoHO6nKCF+OKZsxzNY5GwpInV7f1
	0PzSdpdvrv6lDdxApRNQNjZopcARWLdANhRzyRKsZjPH1AalrvWW8gaO5rALtAzr
	iz3SbPK9rVJW/TQR85buh2w3S+Q8FV6in+x0ydR1yZxEAnZRCgqExRDbsrbKTbE1
	k=
Received: (qmail 24858 invoked from network); 24 Jan 2014 18:09:09 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 24 Jan 2014 18:09:09 +0100
Content-Disposition: inline
In-Reply-To: <20140124170739.GC396@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241017>

On 2014.01.24 at 18:07 +0100, Markus Trippelsdorf wrote:
> On 2014.01.24 at 16:37 +0000, Jim Garrison wrote:
> > > -----Original Message-----
> > > Behalf Of Markus Trippelsdorf
> > > Sent: Friday, January 24, 2014 1:01 AM
> > > Subject: Globbing for ignored branches?
> > > 
> > > I would like to ignore branches that match a certain pattern, e.g.:
> > [snip]
> > > 
> > > Is it possible to ignore all branches that match "hjl"?
> >  
> > 
> > If you mean ignore them when you do "git branch -a", then
> > 
> > git branch -a |grep -v hjl
> > 
> > If you mean "ignore" in some other scenario you need to be more
> > specific about what you want.
> 
> I want to them when I run "git pull".
           ignore
-- 
Markus
