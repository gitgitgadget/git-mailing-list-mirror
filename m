From: David Aguilar <davvid@gmail.com>
Subject: Re: Araxis in mergetool, was Re: What's cooking in git.git (May
	2009, #03; Mon, 25)
Date: Mon, 25 May 2009 02:50:45 -0700
Message-ID: <20090525095044.GA13411@gmail.com>
References: <7vd49xy42b.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905251050050.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 25 11:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WqW-0000ZS-8N
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZEYJuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZEYJuy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:50:54 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:56687 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbZEYJux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:50:53 -0400
Received: by pxi1 with SMTP id 1so2486195pxi.33
        for <git@vger.kernel.org>; Mon, 25 May 2009 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uS0harS61V0evzfDzYJMpJqz2IgeiTzQoSwAPX7wZCc=;
        b=TBmmxbYHt2ngueq+snQDBAzOkaLRzdE/aiOkKtVF6cpqRXANnuMTYFoqPTTvteXl6b
         IMQfg741ndIdWUvMGFhdvtelU0KRZRSHo8wvxeslvMDkv3nXriZIC7B9eje2yE3EgixO
         7OY2jD1ojPnZwNgHkrJwDSeWhaoEAZRM+3knk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Devb0ZmbsAaQqeoQTZBB/BAMW62SPbbe/v2BVC6ibOSbb8BibkV46MrW2OUkaZMvDA
         AWGA0uZbNL2A31tLgfJQz86CeHwtcbiKUig8SRfyfSSCzPGlCuMrshyhnQBiAiyco+M+
         VhVVozCueX4ozeMWyTaUCfyGSwqaStwanG8g0=
Received: by 10.114.154.1 with SMTP id b1mr14550368wae.77.1243245054500;
        Mon, 25 May 2009 02:50:54 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l28sm6210578waf.54.2009.05.25.02.50.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 02:50:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905251050050.4288@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119912>

On Mon, May 25, 2009 at 10:54:43AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 25 May 2009, Junio C Hamano wrote:
> 
> > * da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
> >  + mergetool--lib: add support for araxis merge
> > 
> > I admit that I feel certain distaste in supporting a closed tool, but we
> > already make things bearable for people on Windows; Araxis is no worse,
> > right?
> 
> Well, I think it is the first closed-source tool that we support, and I 
> would feel less unhappy if somebody reported back that she tested it and 
> it works fine.
> 
> For the future, it might be better if mergetool could be configured using 
> /etc/gitconfig to call the merge helper properly.  Then we would not need 
> to clutter git.git with properietary stuff, but could just have the 
> Windows-specific handling in Git for Windows.

I have the same reservations.

When I first picked up mergetool it supported ecmerge.
ecmerge is also closed which is why I reasoned that it was ok
to try and win over Windows users.

It should be possible to configure it today using
/etc/gitconfig, so we might be best served going down the
add-an-entry-to-the-git-wiki route next time; provided
Windows paths and shell-quoting doesn't drive us mad when
writing it, of course ;)

-- 

	David
