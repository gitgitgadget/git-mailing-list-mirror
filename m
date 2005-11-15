From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] git-core-foo -> git-foo, except the core package
Date: Tue, 15 Nov 2005 08:41:23 -0600
Message-ID: <625fc13d0511150641k353d7128pf72f3542da601104@mail.gmail.com>
References: <43797C41.2050809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 15:46:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec1zy-0003IH-Of
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 15:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVKOOlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 09:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVKOOlY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 09:41:24 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:43650 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751430AbVKOOlX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 09:41:23 -0500
Received: by zproxy.gmail.com with SMTP id 14so1589810nzn
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 06:41:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JbM21yLm4arbomfa18hw3A2wgos2j4Y61RA7S8K1MJAHQrUgp44ElYfRzTPGP4PrRCMs3HrqA9DfgslcpkDW47U5EzSd7meqOMLqE5ZbDOQPgzaMxssQIpNlQzAYCl7Mx7ywBEK7LzC8n4Mh6F9joy4ex5Mxo4tYcAt+CpMNkeE=
Received: by 10.37.18.7 with SMTP id v7mr5200906nzi;
        Tue, 15 Nov 2005 06:41:23 -0800 (PST)
Received: by 10.36.100.14 with HTTP; Tue, 15 Nov 2005 06:41:23 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43797C41.2050809@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11906>

On 11/15/05, H. Peter Anvin <hpa@zytor.com> wrote:
> This patch renames the tarball "git" rather than "git-core", and changes
> the names of various packages from git-core-foo to git-foo.  git-core is
> still the true core package; an empty RPM package named "git" pulls in
> ALL the git packages -- this makes updates work correctly, and allows
> "yum install git" to do the obvious thing.

What about "yum remove git" ?  I don't think that will work quite so
well.  The "git" package will be removed just fine since nothing
depends on it, but git-<foo> will still remain.  Maybe not that big of
a deal, but it might not be obvious to some.

Also, what about http://www.gnu.org/software/git/git.html ?  I seem to
recall that was the reason the name git-core was used in the first
place.

josh
