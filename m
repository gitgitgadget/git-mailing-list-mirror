From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Exporting a tree from a repository
Date: Sun, 15 Jul 2007 10:12:08 +0300
Message-ID: <8e04b5820707150012r13c5db69g96b97d910dc1b137@mail.gmail.com>
References: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
	 <Pine.LNX.4.64.0707142237190.13310@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 09:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9yHK-0007Qv-08
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 09:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbXGOHMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbXGOHML
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 03:12:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:18992 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbXGOHMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 03:12:10 -0400
Received: by wx-out-0506.google.com with SMTP id h31so878538wxd
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 00:12:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q4U0JSXnhs6jaS0hdOiF4OiGddQyVo8lk7/vzkf2oBEYzmbrkvzzoKpnZ6ocZuBvphVc1XBXDAcbJ44ByfpC7jkToiNubkcSZJ80Hs5jnYsi3/4loNqtvvV9bMbV0anno35OQSJ68dHEKOlqsQSVsmQqzgRMDjhMPFnPxA4qoRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hl5Y/G2831nOyh9qwSyKml/DKpenXHQB5PQUoom5v85+5f9DqbuuU5nq4dlmQfTu2qUbTTO4yxkvX/aQDHNjgNmVPJNgjQ0wA7SiTw4qISlYBpf3BVYxZ2x6zBLuiGHdDkDKT7pEqEcXf27FNEKRkrDRJvvt9mXfXUa1/EI3vWM=
Received: by 10.70.13.1 with SMTP id 1mr5740855wxm.1184483528647;
        Sun, 15 Jul 2007 00:12:08 -0700 (PDT)
Received: by 10.70.123.17 with HTTP; Sun, 15 Jul 2007 00:12:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707142237190.13310@beast.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52530>

On 7/15/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Sat, 14 Jul 2007, Ciprian Dorin Craciun wrote:
>
> >   Hello all!
> >
> >   I am a new GIT user, I like it, so I started playing with it for
> > different projects I work on.
> >
> >   Currently I am playing with "Linux from Scratch", and I have
> > written some scripts to automatize the build process -- kind of
> > install scripts...
> >
> >   For this I use GIT to store all the source packages -- each inside
> > it's own branch :).
> >
> >   My question is the following: How can I export an entire tree
> > without using a working directory, or cloning the repository. (Because
> > from what I have seen so far there is no way to use the same
> > repository with many working directories...)
>
> You can have as many working directories as you want from one repository
> using the git-new-workdir script from contrib/workdir.  You do need to be
> careful when updating references though (you basically want to avoid
> updating a reference that you are using in another working directory).
>
> You should also be able to use this to get an "export" - simply create the
> new workdir and then remove the .git (being careful not to accidentally do
> this in your actual repository).  However I expect there is a better way
> to do this ...
>
> --
> Julian
>
>   ---
> Quark!  Quark!  Beware the quantum duck!


    Thank you for the hint about git-new-workdir! I will try it.

    Now for the export thing... I know that I can just clone the
remote repository and then remove the .git folder, but for my purpose
I just want to have the HEAD tree downloaded, without any history...
And by using git clone I end up downloading much more than I actually
need.

    I am looking for a feature like 'svn export <repo+tree_path>
<destination_path>'...

    Ciprian.
