From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git config'
Date: Sun, 11 Feb 2007 18:47:53 +0100
Message-ID: <e5bfff550702110947s77e8f264k951ae1c158fcee98@mail.gmail.com>
References: <e5bfff550702110613q315e1f7es4ca1a88b92e4c3e9@mail.gmail.com>
	 <Pine.LNX.4.63.0702111720260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702110921l710d62cr6c82baed1b678ab2@mail.gmail.com>
	 <Pine.LNX.4.63.0702111829230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 11 18:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGInu-0002MM-TA
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 18:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXBKRr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 12:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbXBKRr4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 12:47:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:52408 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXBKRrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 12:47:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so376851uga
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 09:47:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IOKkS1ur8bD12rWs1tAFtBoi3C4uv3gex3vWQyaE+r1vpAnT3XBfbCda7+3Hr+pvmvKUEImDcaC5KXTmgdTlVGkB22ONCZDC9Wbz+LYbn4pdSRIJQVsZfJNKKBIXFsOkih7aeTQhnIeOPaSpty8qFgX7uUhl6AQx9FkO+IXJ8zs=
Received: by 10.114.152.17 with SMTP id z17mr6567669wad.1171216073665;
        Sun, 11 Feb 2007 09:47:53 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 11 Feb 2007 09:47:53 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702111829230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39300>

On 2/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Yes, this is probably a bug. But it's obvious that if git-config _without_
> --global would _not_ use ~/.gitconfig, that would rather make ~/.gitconfig
> pointless, wouldn't it?
>

Yes.

> So yes, the description should mention that this is meant for the case of
> _setting_ variables, not _querying_ variables. The original poster (Sean)
> probaly though -- IMHO correctly -- that querying with --global makes no
> sense.
>

Yes. It makes non sense but it' allowed. So probably, at least for
consistency, could exists a query without silent fallback. Something
like

git repo-config --local user.name


Marco
