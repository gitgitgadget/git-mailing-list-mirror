From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: unable to checkout branches and proper procedure for creating a 
	new branch based off of another one
Date: Wed, 16 Jun 2010 22:32:14 -0500
Message-ID: <AANLkTillFOvwAK_rHhUjhbjRupD1DnQpcMFB3QbExctt@mail.gmail.com>
References: <AANLkTilZ6zoByCngAGoCbgQ9yd424VcChpTKh_XLnogd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 05:33:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP5qe-0004Mz-2n
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 05:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab0FQDcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jun 2010 23:32:16 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44122 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab0FQDcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 23:32:15 -0400
Received: by pxi8 with SMTP id 8so4264018pxi.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=0Kbb+roTqB5TqRdUtNOirQ5RpNpxjGiiRAZ2rnPX6Pw=;
        b=CqQB9MOSXKSWKtXAblZvg/fgQNeo0xl4rghcbNQyIGWp7ZvaP1/ElBRqUoJOUjlKkR
         XwbnAuaIPXcOZVC07FRBhlTIR3OHElczz591OuWMRkmI29DfYNfO0IFr9VTdteVU7ODM
         MWAAsZjQGn1Q1CLjBZZk7+Zn8jjdakzYBTN9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=CXZ0sY+sWu2491vddMtw88UI42A6HicrpE5AqSZaNNLwEkmN656MQ31oCKSJbFjWyT
         IAlulsWqaFyPIlUp4zFcA45g9OdSrDVJoZqB9wrZhky9wCTkWUr4Jl3avFriGHZzFedr
         H5dVHe8la+xdQZTMEZYWZRFoqUab3/BM209FE=
Received: by 10.142.210.15 with SMTP id i15mr7008941wfg.256.1276745534592; 
	Wed, 16 Jun 2010 20:32:14 -0700 (PDT)
Received: by 10.142.87.4 with HTTP; Wed, 16 Jun 2010 20:32:14 -0700 (PDT)
In-Reply-To: <AANLkTilZ6zoByCngAGoCbgQ9yd424VcChpTKh_XLnogd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149286>

I guess what I was trying to do was checkout a remote branch.  Of
course, it's unclear to me what the difference between "git checkout
origin/branch" and "git checkout -b origin/branch" is.  The latter
creates a local branch and the former doesn't?  Does that mean that,
with the former, changes I commit and subsequently push will get
written to the remote default branch and not the remote "branch"
branch?

And how do I check that files in the current working directory are
from the desired branch?  "git log" shows commits made to the default
branch - not to the "default" branch, which doesn't give me much
confidence...

On Wed, Jun 16, 2010 at 9:41 PM, Thomas Anderson <zelnaga@gmail.com> wr=
ote:
> Say there's a Git repository with two branches: default (which is the
> default branch) and branch. =A0I want to checkout branch and start
> working on that but am unsure of how to do it. =A0Here are the comman=
ds
> that I did:
>
> git clone git@github.com:username/repo.git
> cd repo
> git checkout branch
>
> But that gets me the following error:
>
> fatal: Not a git repository (or any of the parent directories): .git
>
> I do "git branch" and here's what I see:
>
> * default
>
> Where's "branch"?
>
> And let's say I wanted to create my own branch based on "branch".
> Let's say "branch-zelnaga". =A0How would I do that? =A0Do I just chec=
kout
> that branch, create a new branch while the current working directory
> contains files from the desired branch and then push / commit as
> appropriate?
>
