From: David Aguilar <davvid@gmail.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Sat, 27 Mar 2010 15:27:32 -0700
Message-ID: <20100327222730.GA10922@gmail.com>
References: <20100323232055.GV7038@pixar.com> <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com> <4BA9DCDD.6060109@viscovery.net> <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com> <vpqd3yt4yyp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Lars Damerow <lars@pixar.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 27 23:27:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NveTu-0003nc-CJ
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 23:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab0C0W1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 18:27:41 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:65213 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0C0W1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 18:27:40 -0400
Received: by yxe29 with SMTP id 29so1366322yxe.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 15:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5NZnQq/ogbrZNfbTHkYfd07rhoyPnqUyVuTH2ayX/BU=;
        b=X23VRnZjolyb7oXCUUkmr2UAnyXdYfXwv9U6feZIuu9/ApJ0RKjekFCp8GEjqyRuci
         koH95fLiuhjrXTnlT6haIgJMQZbSLAOGw5ZzRDDgdZCAcqkqQA289Oj4xDbge/wkQUs8
         WZ+JFT6+mffL21w36aBh4uWkUDRFwii1pnG+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dLoLCmqYWpojy4SHuCnWqpQDOMhHbEWeKTeal3CeYR2om+sC0VUY5BalIesZ1RRH+X
         OG8FMdCBkaQgEpH348iER2a6u9jomyh1+JS0jvD+PWrW9e5t2pCuFnCAMoDBUuAKGwn5
         BdRWXUjdwJFLxv0ti2HOqPy7DROwm3lkWGEcE=
Received: by 10.100.89.5 with SMTP id m5mr4297143anb.118.1269728858887;
        Sat, 27 Mar 2010 15:27:38 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm646621ywd.28.2010.03.27.15.27.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 15:27:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqd3yt4yyp.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143361>

On Wed, Mar 24, 2010 at 02:43:26PM +0100, Matthieu Moy wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > On Wed, Mar 24, 2010 at 10:35, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >> Am 3/24/2010 10:29, schrieb Alex Riesen:
> >>> And while at it, how about making it a config option? (i.e. core.oneFilesystem?)
> >>
> >> It's difficult to have this as a config option when you are looking for a
> >> repository... ;)
> >>
> >
> > Isn't it a little pointless to look for repository when you can't
> > access its config?
> 
> I guess Johannes's point is that the config option can be in
> $GIT_DIR/config, which you can't access when looking for $GIT_DIR.
> OTOH, looking at ~/.gitconfig to find a core.oneFilesystem makes sense
> (but is probably painfull to implement since the current code to parse
> config file will look for $GIT_DIR first).
> 
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Right.

As this thread showed, we can't have a config option for this
feature.  Were there any other objections to the patch?
It looks good to me.

Peff also agreed that it was an overall improvement.
http://thread.gmane.org/gmane.comp.version-control.git/142262

Thread with the latest (v3) version of the patch:
http://thread.gmane.org/gmane.comp.version-control.git/142436

We could use this feature at Disney Animation as well.
We maintain a list of $GIT_CEILING_DIRECTORIES and could do
without having to maintain it if we had this feature.


Plus, Lars is one of the git users that doesn't even flinch when
the Perforce servers at Pixar get a hiccup, so we should try and
help our fellow "renegade" git users ;-)

-- 
		David
