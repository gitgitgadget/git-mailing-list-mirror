From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 00:59:54 +0200
Message-ID: <20090405225954.GA18730@vidovic>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Apr 06 01:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbLN-0000EA-Tc
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZDEXAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbZDEXAE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:00:04 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:40014 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbZDEXAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:00:00 -0400
Received: by ewy9 with SMTP id 9so1692321ewy.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=iaOhvRa/vdNX0pbUPWkIXR1YRDms+X6H0lisiEztX8o=;
        b=GMSGumVCG/QVOH1sw7v45zJnAgvV6mbT0NwIxCh1j8uS4qq3LDt20yUKa8Gu5rJPwc
         F1Msfmd8Y/LaROPYRTSiMaWEJv91Apicj1AMh5564Nizp33Zsbbxc7UcfSpY0XyNYkT1
         CwpTUCy+3KVbIxFujOoRew3ADvAH2nglAjfCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AYKxNeqRX6VeirDqCZqISbDRe5cCYgsURKepVIhcGDnJIIuubHhAsVCxFD3eo7YQqL
         n0CzrvES1rX4SsseELX2aN1f8bejaUvndEBXsWEuNsUkw14Nyf3xDQjTVmqXd93Npcgs
         +wTqJQ36/d/tQITOr+4+0aOAPUoQKZ7gawrRk=
Received: by 10.210.115.17 with SMTP id n17mr2829969ebc.43.1238972397732;
        Sun, 05 Apr 2009 15:59:57 -0700 (PDT)
Received: from @ (83-154-175-191.rev.libertysurf.net [83.154.175.191])
        by mx.google.com with ESMTPS id 28sm6011853eye.44.2009.04.05.15.59.56
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 15:59:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115731>

On Sun, Apr 05, 2009 at 02:28:35PM -0700, david@lang.hm wrote:

> guys, back off a little on telling the gentoo people to change.

Don't blame Git people, please. I currently am the only one here to
discuss that way and see a painful work coming at Gentoo.
Git people didn't discuss around thoses issues.

>                                                                 the 
> kernel developers don't split th kernel into 'core' 'drivers' etc pieces 
> just because some people only work on one area.

And you might notice that they don't provide a CVS access and actually
don't work around an unique shared repo. Also, you might notice that
keeping the history clean to assure the work on the kernel easier is not
an elementary issue.

> just because some people only work on one area. I see the gentoo desire 
> to keep things in one repo as being something very similar.

That's why I think the gentoo desire is not very clean (don't be
affected). What I see is that in one hand you want a DSCM and on the
other hand you want to keep a central shared repo.

> the problem here is a real one, if you have a large repo, git send-pack  
> will always generate a new pack, even if it doesn't need to (with the  
> extreme case being the the repo is fully packed)

What about the rsync solution given in this thread?

-- 
Nicolas Sebrecht
