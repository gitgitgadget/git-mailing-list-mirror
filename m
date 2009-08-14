From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v5 0/6] Re: {checkout,reset,stash} --patch
Date: Fri, 14 Aug 2009 22:57:53 +0200
Message-ID: <20090814205753.GD12950@vidovic>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:58:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc3qk-0002sc-TN
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 22:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZHNU6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 16:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbZHNU6B
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 16:58:01 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:57327 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbZHNU6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 16:58:00 -0400
Received: by ewy10 with SMTP id 10so1781296ewy.37
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OO3ADi+SzftFTrV9eHO+Uvt2h6incGXEPq4Wr7otFEg=;
        b=gGNFbZbiWaDWtlx+IEqo4IHS3g+Mxind4W28YYQXI5gvI/TPFyOQ1vpyP81ft7Ibt3
         Hn7QOTFKyG0KiAX2Wqr0u/kvRa4QDxfIcQCzutrrDjbF7QTUBziRwZdMm83VBt7cgPz9
         AWPia4dzze351aSHqgYLERoo1klKL0Jdm/ar0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f4q66VTegwk6LcX3/rAWx0RLCIHpJvU9R8mubknQoRJW9siYMcFlZK//10l0XysbvH
         2S6LP/jABjKQyEiVH/cguyl0MCZs4b8tUACSq251613GUoMlKXujtbX6xlF8DxcoHr/t
         YOZW5Rvh/YV6wTgCFr6lRmVt55tK7a/Z/VuHY=
Received: by 10.211.162.12 with SMTP id p12mr3692221ebo.75.1250283480438;
        Fri, 14 Aug 2009 13:58:00 -0700 (PDT)
Received: from @ (88-122-115-214.rev.libertysurf.net [88.122.115.214])
        by mx.google.com with ESMTPS id 28sm3101477eye.44.2009.08.14.13.57.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 13:57:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125955>

The 13/08/09, Thomas Rast wrote:
> Junio C Hamano wrote:

> > * tr/reset-checkout-patch (Tue Jul 28 23:20:12 2009 +0200) 8 commits
> [...]
> > Progress?
> 
> Slow, as always.  There are three groups of changes:

<...>

> Thomas Rast (7):
>   git-apply--interactive: Refactor patch mode code
>   Add a small patch-mode testing library
>   builtin-add: refactor the meat of interactive_add()
>   Implement 'git reset --patch'
>   Implement 'git checkout --patch'
>   Implement 'git stash save --patch'
>   DWIM 'git stash save -p' for 'git stash -p'

Tested-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>

-- 
Nicolas Sebrecht
