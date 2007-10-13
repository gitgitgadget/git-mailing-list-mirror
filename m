From: Tom Tobin <korpios@gmail.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 15:21:13 -0500
Message-ID: <1192306873.6103.14.camel@athena>
References: <471045DA.5050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnUF-0001wN-7R
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbXJMUVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbXJMUVQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:21:16 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:41792 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXJMUVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:21:16 -0400
Received: by py-out-1112.google.com with SMTP id u77so2249948pyb
        for <git@vger.kernel.org>; Sat, 13 Oct 2007 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:from;
        bh=4izGH85viByHpk+IA5Bo/PF9B44XZjQaYUAgbGEPd4o=;
        b=AEHpXtyiyAYA0dwchq+UV2SR67hKcGGDdAIWxL4HL08swiCqPnin8InwfMaRV7kgHajnB6h+gpVZavl6Tv1GjfnIBudG1OLmLIlLZRaqxvpmQjWnmfse8LRmr+RVCW4pU0Z1hd9UVe+lMVR6tQLq0c9Aqz+dfdzF6cV/9RBuNZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:from;
        b=d1WQFo3vn8Eb4pMJwjGya9HzgGMuQB6YslCh5Sv3WD6jZrs2J6MlyUJr/czpJ7w5jneVTlLG7XMN4pR3a6rSY14KhARlCbAHwy3n7WlUEbmXSALK8kdoA0lOgqkC9RkY4bnIwFztUjdCyIlrx+zvcAOGJE0BFHa1UIa1jXISvG4=
Received: by 10.35.63.2 with SMTP id q2mr5378913pyk.1192306875176;
        Sat, 13 Oct 2007 13:21:15 -0700 (PDT)
Received: from ?192.168.1.197? ( [24.124.68.243])
        by mx.google.com with ESMTPS id f45sm4620283pyh.2007.10.13.13.21.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Oct 2007 13:21:14 -0700 (PDT)
In-Reply-To: <471045DA.5050902@gmail.com>
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60772>

On Fri, 2007-10-12 at 23:13 -0500, Dan Zwell wrote:
> Recently there was some talk of color for git-add--interactive, but the 
> person who said he already had a patch didn't produce it.

Meh, I really need to start posting the stuff I've hacked into git.
First the git-stash changes, now this.  Sigh.  ^_^

I have a variant of git-add--interactive that properly adds coloration
to diffs, taking the config file values already set for the color.diff
key and colorizing the unadorned diffs internally (rather than expecting
the output of git-diff/git-diff-files to be colorized).

Give me a couple of hours (still setting up my Macbook after repaving it
and installing Ubuntu) and I'll post what I've got for others to tear
apart and point out where I screwed up.  ;)
