From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 9 Jul 2006 08:54:53 +0200
Message-ID: <e5bfff550607082354g62e99216gc72b07055762de3a@mail.gmail.com>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
	 <e8p8pj$jk3$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 08:54:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzTBx-0007G7-3g
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 08:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWGIGyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 02:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWGIGyy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 02:54:54 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14740 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161102AbWGIGyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 02:54:53 -0400
Received: by py-out-1112.google.com with SMTP id 57so600476pya
        for <git@vger.kernel.org>; Sat, 08 Jul 2006 23:54:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mjqsGOpCrT5wvn20nDWqk6ozkR55vHOmiMFlQe1BqYPxOAfTohzHPYtlfVXeacdVXucXSHrMxSa8eFaQXsye2xz5DokzdzmgZpxG+35HE5++gBuhrCX8TUIhNxbylAOEXWaxgHuyd2uVcOzJRAzQroneKvZIQs7GHWboMet4xNE=
Received: by 10.35.84.16 with SMTP id m16mr3903726pyl;
        Sat, 08 Jul 2006 23:54:53 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Sat, 8 Jul 2006 23:54:53 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e8p8pj$jk3$2@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23525>

On 7/8/06, Jakub Narebski <jnareb@gmail.com> wrote:
> moreau francis wrote:
>
> > Hi GIT folks.
> >
> > I'm a complete newbie on git development so excuse me if
> > this idea is completely stupid.
> >
> > Would it be possible to let the user stick a short explanation
> > on  what a branch is supposed to implement during its creation.
>
> It would be possible when/if branch and remotes config would migrate
> to .git/config. Currently too many I think relies on refs/heads being
> simple sha1 of "top" commit.
>

It is possible to add a message (and more) to a tag creating a tag
object. FWIK this is not allowed for the other refs.

Why there is this (artifical?) difference between tags and the other
kind of refs?


   Marco
