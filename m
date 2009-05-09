From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: can we allow -t abbreviation for --track in 'git branch'
Date: Sat, 9 May 2009 11:17:34 +0200
Message-ID: <20090509091734.GA12926@vidovic>
References: <slrnh0agtv.4rv.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 09 11:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2igl-0004pl-4I
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 11:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbZEIJRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 05:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZEIJRi
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 05:17:38 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:55811 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZEIJRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 05:17:38 -0400
Received: by ewy24 with SMTP id 24so2333779ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qHY1xUsvp7vO47WlOYk96cRiEWiHN9GVtXD5dbelVL8=;
        b=Uvy4fgJ84DXolDne2ku6/N3JOq57G/VM4Tj6TaGAhVP6vpx7ekd+r7as9lsnGQ5xQE
         E0ax3dZLy7NHG6gFaNqnawU1s4XwNrFUG8qhOqDnDWI2sdmIZdpSJ1xghmzUFxfcHs/h
         a33NqPSREblReDD+PcdHBd512Xd0W3kNvi9TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nn4j4rNfloYL3MOk77bhtj7pGrd5WkFowUgT43hMVpccENFKO/hgN0H1zo8cHJKl7L
         FBRvYEaDlc+4gYVHW4IrLVGjZ2eEn9hhxJyIL7HPD4vc9icFu/KNXYqPg2gjjPtS0vIF
         s/plz9l9kcoOAZk5Um+wX6QMUIUdjMUOFDXWc=
Received: by 10.210.11.13 with SMTP id 13mr1110853ebk.0.1241860657395;
        Sat, 09 May 2009 02:17:37 -0700 (PDT)
Received: from @ (91-164-138-138.rev.libertysurf.net [91.164.138.138])
        by mx.google.com with ESMTPS id 7sm3327708eyb.45.2009.05.09.02.17.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 02:17:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <slrnh0agtv.4rv.sitaramc@sitaramc.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118655>

The 09/05/09, Sitaram Chamarty wrote:
> Hello,
> 
> Would it make sense to teach "git branch" the short option
> "-t" the same way that "git checkout" knows it, (ie., as an
> abbreviation for "--track")?

It makes sense for me.

> I use both frequently, and often forget that in "git branch"
> the short option does not work.

Same here. :-)


-- 
Nicolas Sebrecht
