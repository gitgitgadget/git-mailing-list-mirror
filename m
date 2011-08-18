From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Branches & directories
Date: Wed, 17 Aug 2011 23:45:55 -0500
Message-ID: <20110818044555.GA20752@elie.gateway.2wire.net>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org>
 <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 06:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtuUs-0001Zd-P5
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 06:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab1HREqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 00:46:22 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36968 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1HREqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 00:46:21 -0400
Received: by yie30 with SMTP id 30so1249550yie.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SR8X8VTXZBVEFuzS+Gdedw2wtMeKFBDMoQmw0LwftuI=;
        b=J9G/cmrIIl+DGnqs+PjCOF+p3h8qV1c44A7M1deDgA5Tc7qzq4dwBlImyYQtqZDrrw
         ezZjTMimzml/U5aL5cpXiGGk2eI1UclhdXQ1gvkSGZJNJyi0MQ2orhA0I4R4TUINNuZu
         0c5SYradS4fm5uAJGIEM1a/YYJTtUHLyewlm4=
Received: by 10.150.133.11 with SMTP id g11mr260991ybd.370.1313642780691;
        Wed, 17 Aug 2011 21:46:20 -0700 (PDT)
Received: from elie.gateway.2wire.net ([68.255.105.3])
        by mx.google.com with ESMTPS id o2sm1782260yhl.29.2011.08.17.21.46.18
        (version=SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 21:46:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179556>

Hi Hilco,

Hilco Wijbenga wrote:

> It would be really nice, though, if Git could somehow
> "stash" such files when checking out a different branch. In general, I
> would prefer if uncommitted changes and untracked and/or ignored files
> stuck to the branch where they were created.

This is just a random guess, but: wouldn't it be convenient in this
workflow to have a separate worktree for each branch you are working
on?  That way, switching branches would not carry over unwanted state
or throw away valuable state, clobber timestamps that "make" pays
attention to, etc.

If I am understanding correctly, then the git-new-workdir script
from contrib/workdir might help.  (Note, though, that it comes with
some caveats.  A quick mailing list search should find them.)
