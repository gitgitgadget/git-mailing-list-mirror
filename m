From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sat, 22 May 2010 17:52:31 +0200
Message-ID: <1274543552.21346.166.camel@Luffy>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
	 <4BF7B751.7050704@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat May 22 17:52:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFr0G-0000mc-8X
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 17:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab0EVPwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 11:52:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57093 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab0EVPwi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 11:52:38 -0400
Received: by wyb29 with SMTP id 29so569851wyb.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=QH+eFIdI27zhRZ0IsiarvKbS4b0G5cH6PXZSUUglg5U=;
        b=OtVzI7v5PkOo2oUGVdKvfbUXcYOudA8X9FBEgCs9PgzucvTsPdHNt8qSU7yatPaP1h
         KsnBlc8vvw91+NdyS0b1ff5wnAS2+ZnbPZUvQK+4JbjKe56365DPcFKtNsORfYG/gVQX
         6L2UvOl7rScxZCykcsqIX3oLAIoOQIIP2qDG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=pmbN0ukRIx2CBg7oPzYozNo7UKDg66Yy1q5lrz2M0vI8v+3tdHVOiA1J1Oe4W3Tp6o
         P5CjxYDN7EFxoRGKIgNon8HS+XnzrxIRpRw8jzy+JV7nBHgtqFQdZFwXxmoJDoVhQ4nF
         KwJ5OvTnb/ceVCRelQvAIl9AraRVdQPlXAeag=
Received: by 10.227.151.138 with SMTP id c10mr2844272wbw.219.1274543556152;
        Sat, 22 May 2010 08:52:36 -0700 (PDT)
Received: from [192.168.1.2] (host32-6-dynamic.52-82-r.retail.telecomitalia.it [82.52.6.32])
        by mx.google.com with ESMTPS id t20sm16278538wbc.22.2010.05.22.08.52.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 08:52:34 -0700 (PDT)
In-Reply-To: <4BF7B751.7050704@pileofstuff.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147528>

Il giorno sab, 22/05/2010 alle 11.52 +0100, Andrew Sayers ha scritto:
> Hi Daniele,
> 
> I'm a developer getting towards the end of introducing my company to 
> Git.  Here are some thoughts based on the (mis)steps I took.

thanks


> I found that advocating specific steps wasn't that effective - I just 
> came across as being pushy and hard to work with.  It was more effective 
> to politely show off what I could do with git-svn, and let people get 
> jealous enough to work the "how" out for themselves.  Here are some 
> examples:
> 
> I would quietly bisect a hard-to-fix bug, then .... [big-snip]
> 
> Over the course of a few months, people became convinced that Git was 
> something that makes you more productive.  Our lead developer had a go 
> with git-svn for a while, before our boss decided we should all make the 
> switch.

I'm already doing this stuff..
but i'm in the *lead developer* position now, so, if I say that they had
to start using git (at least my team) they will..

But I don't thing going throw git-svn is a good idea.. it has some
limitation over the normal git and you have to be more careful about
rebasing (interactive) and you should avoid merge (as much as I
understood it).

I'd like to make the big move going directly to git.
I don't think i'll had the time to do it now, the new project is already
going on.. but I'd like to have all prepared and ready for the next
one :)


> I tried to make git-svn as painless as possible with some svn-like 
> aliases and a cheatsheet, which I'd be happy to upload if the list could 
> suggest a good place to put a PDF and some text.

I think that may be useful to many.
In my specific case it wouldn't help, since everybody is used to click
around with the git-svn graphical interface, they don't even know the
svn commands to do those stuffs. They are almost all windows-minded :)
you know: "writing when you can click? why?" - I use to think the
opposite :)

What i mean here is: git should be graphical, at least at the beginning,
better if inside eclipse itself.

> The move worked for a while, but it turned out that one-and-a-half git 
> experts supporting the rest of the team wasn't enough to stop people 
> from making rookie mistakes like `git merge`ing into an SVN branch with 
> unpushed changes.  We had to accelerate our move to git on the server, 
> and I got a lot of exercise and not much work done that month as I 
> dashed from desk to desk.

that's what I fear, because we usually are overladen of work and we
can't stand some slow down if it last more then 2-3 days in a row.
If that happen I'll be the one who will be blamed for the issue :)

> Things gradually calmed down as people got more comfortable with git. 
> But I expect to be occasionally called over for a long time as people 
> learn new tricks - "how do I, like, cherry-unpick a single commit?"

Well.. that's ok.. the problem is with things I don't know about git
like: what's the best way to manage binary files? how do I manage
submodules? and so on... if I don't know how to properly reply to those
questions I'll obtain the opposite effect :)

Thanks for your experience,

Daniele
