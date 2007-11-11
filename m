From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 16:20:26 -0500
Message-ID: <9e4733910711111320u1deafe69r96d64babbb893adf@mail.gmail.com>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
	 <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com>
	 <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de>
	 <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com>
	 <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 22:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKEU-0002GT-IH
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbXKKVU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 16:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbXKKVU1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:20:27 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:7127 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbXKKVU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:20:26 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1313897wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6pWcHriC79APP3wGDrB820okAJ8S7Co/oAMq9LyRvfw=;
        b=p9/0FqyFIre9UD58dwL6D/VM8Y/84YWOo0BxXH5HixLt2zL9TeXGwBDjthgown0VeZUgvjYOB5JDVTr/DBbxbbndjuyc1/LZDqGXpTUa7dhLnPWlzxgG0nQR2U5VpqTlye5OjlbYLlanjVcmtkEgVUQWzo3fGRxV66cXXVxaWkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hmUyUCvoE9Y833lvGzjnV0TIDV8J+W07wABHceh3F1VyMTkF02bfE6D7bOKnBgqBYzCFA7S3sS3YezrCCryGs3phF+cdZC6yDX4OPzHOMzMTZ6sKoydWuA33MxNrx1jSjvmDL8M/vOBMDJH/olm1u3nDC0n+B+ZeutQpWImQa5A=
Received: by 10.115.109.1 with SMTP id l1mr2088633wam.1194816026267;
        Sun, 11 Nov 2007 13:20:26 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 11 Nov 2007 13:20:26 -0800 (PST)
In-Reply-To: <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64516>

On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
> > jonsmirl@terra:~/mpc5200b$ git remote show linus
> > * remote linus
> >   URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
> > linux-2.6.git
> >
> > How do I push the definition of the linus remote repo?
>
> You can't. Remotes are local to a repository. They cannot be
> "pushed" nor will they be "cloned" or "fetched".

Dreamhost is way slow compared to kernel.org, so it is better to clone
from kernel.org first and then pull from dreamhost. What is the right
sequence of commands so that a new user will end up with a kernel they
can use 'git pull' on to get updates from dreamhost? I'll add these to
the repo description page.

I'm trying this locally and I can't figure out the right sequence of
git command to redirect origin from kernel.org to dreamhost.

Doing this was bad, it messed up my heads.
jonsmirl@terra:~/foo/digispeaker$ git remote rm origin
error: unable to resolve reference refs/remotes/origin/master: No such
file or directory
update-ref -d refs/remotes/origin/master
6e800af233e0bdf108efb7bd23c11ea6fa34cdeb: command returned error: 1

-- 
Jon Smirl
jonsmirl@gmail.com
