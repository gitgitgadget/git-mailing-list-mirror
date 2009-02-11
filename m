From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 21:20:51 +0200
Message-ID: <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211180559.GC19749@coredump.intra.peff.net>
	 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
	 <20090211184429.GA27896@coredump.intra.peff.net>
	 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
	 <20090211191445.GU30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKf8-00057T-1J
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbZBKTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbZBKTUy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:20:54 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:44843 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbZBKTUx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:20:53 -0500
Received: by fxm13 with SMTP id 13so1057424fxm.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 11:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ycQH8yvYlqkQ9OCkW7EY+eYE/+IrHt7XUIImYEi+ZLg=;
        b=e/AJEFv+2PVYG1jzRHtZlnr5AOfiJo4VecOZvVjtGL4jymIZEOG7Ktyb6HJHS87WJf
         +HgGrW7luYqJM8K+q8VsqkyaJhDOiPZ9IBQykZMa2K4vctcNtdSCGFa+FWm+AO8q6RjH
         FD9A3ZBOROTFBTTC94MPrJPV8X9gM+5x6ZHWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ry4rJd5PpYackP1xwa095Gx3+8vt/9LYH0K9Ou1O6Y03fEDNtR7nseyen0MMercoRa
         Bdc8QvXEHDm0EVjpwvvm54U6rzGHxY8IaOekWQR5Opc8y6/Y7k70ZOAideP6eRaf+MEI
         XqUl5TAP3G92/rgNVQ321Lhcjb+tZXe02y0RU=
Received: by 10.181.208.11 with SMTP id k11mr843517bkq.180.1234380051264; Wed, 
	11 Feb 2009 11:20:51 -0800 (PST)
In-Reply-To: <20090211191445.GU30949@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109508>

On Wed, Feb 11, 2009 at 9:14 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> wrote:
>>
>>     Here is what I'm trying to accomplish: I want to add to the git
>> search path also the folder ${GIT_DIR}/bin if this already exists...
>> (This allows me to have repository specific commands...)
>
> for f in `cd $(git rev-parse --git-dir)/bin && ls *`; do
>  git config alias.$f '!$(git rev-parse --git-dir)/bin/'$f
> done
>
> No need to patch git.
>
> --
> Shawn.

    :) Yes I know about the alias trick...

    But I find it easier to just create a bin folder and drop my
scripts there... (For example git-branch-import that takes a new
branch name and an URL and creates the branch with no ancestry and
knows http, ftp, svn, tar.{gz,bz2}, zip, etc...)

    Ciprian.
