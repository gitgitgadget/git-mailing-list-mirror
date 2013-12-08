From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-subtree manpage missing from git-manpages tarballs
Date: Sun, 8 Dec 2013 14:30:21 -0800
Message-ID: <20131208223020.GB9108@google.com>
References: <CABGRy0o3AJLMhmVJL8XAjrnQJd=yuV+1Q=cLToetnhmB0V=hfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	"David A. Greene" <greened@obbligato.org>
To: Stefanus Du Toit <sjdutoit@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 08 23:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpms4-0005j3-PA
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 23:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759935Ab3LHWaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 17:30:25 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:39798 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab3LHWaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 17:30:24 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so2081382yho.30
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UNnbBbC/KBeJTYOUHpYqw/wYVmGZmkJO1C9+rCp+wLI=;
        b=zXkXaOXGpnhcIJAP6F8tAR17tGNekxYrlqHmdlwUE/qpxkmZyMk52k20N6OM0Vi8eQ
         1K8snbhGpN4OxlNux1FKQ/b8AjdW9V6E4CZNceWJ16owb7GLw4qsZrsgWW0ClUaCh983
         A3NfKwN73tjQYfvBKHmOYyVrxmLmwMwhaBU+bIkycrsL1/v1yZkBGVlos6smRxLhFopv
         UNNzfi4vqMV16oZMMbmDaUemU3jxjwo2BkN0FuSN9478wRakzkyyfc8OmmII5f2AitML
         b0wrZW7vCf32AXLVB0hl5bqMDrgDFNLIYC6Jp7ppB/QLIlSaD+OdGs82CVJTz1A1D5jm
         YKaA==
X-Received: by 10.236.50.194 with SMTP id z42mr13265985yhb.18.1386541823998;
        Sun, 08 Dec 2013 14:30:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m29sm12162818yho.14.2013.12.08.14.30.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 08 Dec 2013 14:30:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABGRy0o3AJLMhmVJL8XAjrnQJd=yuV+1Q=cLToetnhmB0V=hfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239053>

Hi,

Stefanus Du Toit wrote:

> The git-subtree manpage is currently missing from the git-manpages
> tarballs at https://code.google.com/p/git-core/.
>
> For example, https://code.google.com/p/git-core/downloads/detail?name=git-manpages-1.8.5.1.tar.gz
> does not include it.
>
> A side effect of this is that "git help subtree" fails when using git
> installed from homebrew, because the homebrew recipe uses those
> tarballs as its source of documentation.

git-subtree and its documentation are in the contrib/subtree
directory.  contrib/subtree/Makefile includes rules to build
a manpage for it.

If the homebrew rules are installing the git-subtree command
from there, perhaps they could be tweaked to build the manpage,
too.  What do you think?

Alternatively: I'm not sure what the status of git-subtree
maintenance is.  Is there someone taking active enough care
of it that it would make sense to promote it out of contrib/
to be a full git command installed by default?

Thanks,
Jonathan
