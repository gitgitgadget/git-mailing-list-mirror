From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sun, 3 May 2009 11:18:24 -0700
Message-ID: <20090503181824.GA50640@gmail.com>
References: <1241313481-17923-1-git-send-email-davvid@gmail.com> <alpine.DEB.1.00.0905031629290.18521@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, snowcoder@gmail.com, spearce@spearce.org,
	markus.heidelberg@web.de, git@vger.kernel.org,
	charles@hashpling.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 03 20:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0gGx-0002Gy-GZ
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 20:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbZECSSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbZECSSb
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 14:18:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:7187 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbZECSSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 14:18:30 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1854156wah.21
        for <git@vger.kernel.org>; Sun, 03 May 2009 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VIYUTznj9o3JTNIY2IREoZ/UkwgiVB6olWzaCsoIS5E=;
        b=SmthiggoiVMBw2uPkWR8rTkYkq8lyhgcLvmAqsIoOA45v56YGXa4/7AxHflUVAHT5t
         nNjfdFcTLTNwf3uf8JUJeBHGSmkZGZMAkC3jUyVRGVwJlbJvXfv5jEIQLc3thtRwh11+
         gM98mprTADTNJhBBsYHno1lmokZQfy/f3EJaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gi2jC+rTTJXDVXNxGAYaI+1cLmj0X88W5+NgWYinbvogv//Pjz9R2xchUQUZbITutj
         tAWkmbEKeErdmr3B8JkzXnR4HMGkwnvlDjycePNlYvXgekJ2ioi5QUIuvcLoKVrkV2Lw
         3Q13hJhqvQx+bOZ/bKMfkbiobM5A9tCVf6j+w=
Received: by 10.114.53.18 with SMTP id b18mr3563091waa.6.1241374710709;
        Sun, 03 May 2009 11:18:30 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j34sm8540848waf.48.2009.05.03.11.18.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 11:18:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905031629290.18521@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118180>

On  0, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sat, 2 May 2009, David Aguilar wrote:
> 
> > Araxis merge is now a built-in diff/merge tool.
> > This adds araxis to git-completion and updates
> > the documentation as well.
> > 
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > 
> > This patch is a result of the discussion on the msysgit list:
> > 
> > http://groups.google.com/group/msysgit/browse_thread/thread/fa353fa2240594d7
> > 
> > 'compare' is the command-line utility that is provided
> > on MacOS.  Users on other platforms may have to manually
> > set their mergetool.araxis.path.
> 
> The only reason I did not merge that patch sent to msysgit@googlegroups 
> was that I did not have _any_ confirmation that it works.
> 
> Do you have any?  As Araxis is not free software, I refuse to touch it.
> 
> Ciao,
> Dscho

I tested it (but not on windows).  It works.
I have the same reservations about non-free software,
but at least they mention git on their homepage
(even if it's only in their documentation).


-- 
		David
