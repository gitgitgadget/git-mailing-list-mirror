From: "Steve French" <smfrench@gmail.com>
Subject: Re: default commit message for a tree
Date: Fri, 25 Apr 2008 21:13:21 -0500
Message-ID: <524f69650804251913s302bf05n2853c267a0475768@mail.gmail.com>
References: <524f69650804251839u56198808o8b7a66d9894fbbfc@mail.gmail.com>
	 <alpine.LFD.1.10.0804251859100.2813@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 04:14:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpZvY-0007eu-4D
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 04:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbYDZCNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 22:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYDZCNX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 22:13:23 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:29454 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYDZCNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 22:13:22 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5225011fkr.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rdY62bN1Cpq3r9YEQtIdafjFC6SJt6uBeIIZlk6j2Jo=;
        b=NNH9ogJ0yR1Ym0tmD+bax2PMPXo0tR3edpRAQCRffcG2wjst+4C7ODJZsn/1Up4XHxqEU98s7uA6kNUNkApFHdKdDMCRIGuZObjW3ATjfhi8yVang+XUwxmYRHu7vaZqukWBBgcnVa7JoG4nI5Nvaa4LAvT3tYf9tdKmME3cBmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G67/dZHeC0q/KRw2Eny2goQdLL5W77hPzKyZFzMXn6KAFC2LpWYf8mBWsoEAmkgcFd0PKU5Jj9pNDU2WGvCdsVcHEgBtO8jXpF8TLgi9d5LNGKG0PuIzPeSIjLV3bLVcopvkLXhLQhcVFg7Q6VP4P119Al7ut9je6rHad/TiVDk=
Received: by 10.78.14.13 with SMTP id 13mr3411362hun.79.1209176001183;
        Fri, 25 Apr 2008 19:13:21 -0700 (PDT)
Received: by 10.78.172.19 with HTTP; Fri, 25 Apr 2008 19:13:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0804251859100.2813@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80364>

Worked beautifully - thanks

On Fri, Apr 25, 2008 at 9:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  On Fri, 25 Apr 2008, Steve French wrote:
>  >
>  > I created a file .git/commit-template with default text as follows:
>  >
>  > [CIFS]
>  >
>  > Signed-off-by: Steve French <sfrench@us.ibm.com>
>
>  You need to use
>
>             git-config commit.template .git/commit-template
>
>  (or use the whole absolute pathname to your template file). The pathname
>  is relative to the working tree, not GIT_DIR.
>
>                 Linus
>



-- 
Thanks,

Steve
