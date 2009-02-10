From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with an 
	asterisk
Date: Mon, 9 Feb 2009 19:22:50 -0500
Message-ID: <76718490902091622y9a6d1bak5dc401858382e2ff@mail.gmail.com>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
	 <20090210000321.78025483@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 01:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWgQG-0005h2-Os
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 01:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBJAWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 19:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbZBJAWw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 19:22:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:25527 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZBJAWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 19:22:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2038850rvb.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 16:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q6zqdH7HwuNMqH6xvAT9QTmzRvA6JDJouIFXYoxg5z0=;
        b=NSjlQGpv+XioMEiHRAkbVG9g15qWtsMayLI5/rh5HZ1GdZEbhzWvPMUogoxj6iVkdB
         nnw91NvlHw0+T61+CcTnzP2ybRrxNxbKW9/RVUghoX2ADFFXvfzdvINja2+h26RYKfgo
         NyXrzCqhXC5PBoxIR3VWc3PICupO74yONnCMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v9mBNvlXA88YDnqnf2JuNdTOD77lTXvmP7KKL7UfS71Wy/gVdgnXtQVL2zCe1Qr4gM
         1eAd7jKlhW4piCyAsEy4Is70QcbIRIjGbDnIvFUTbgnXrsuU4unWi6tre8D/W3p1IHVE
         B19aJhnaRBmkwdZoGoTsUUDZElQLKIPqq5vIM=
Received: by 10.141.53.1 with SMTP id f1mr4287752rvk.6.1234225370575; Mon, 09 
	Feb 2009 16:22:50 -0800 (PST)
In-Reply-To: <20090210000321.78025483@crow>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109167>

(Please don't trim cc:)

On Mon, Feb 9, 2009 at 7:03 PM, Mark Burton <markb@ordern.com> wrote:
> I don't know if I have any scripts that rely on a single star in front of
> the local HEAD or not (I'm sure some people must have them), but I do
> think this new feature would be very confusing, especially when used
> with -a.
>
> At the very least, make the indicator something other than a star, an @
> or #, perhaps.

With color, it shouldn't be confusing at all as only one branch is in
green. W/o color, it still seems clear to me as the remote branches
have their remote name prefixed to them. Even if you're on a detached
head:

* (no branch)
  master
  next
  sent/branch-show-remote-HEAD
  wip/am-usability-improvements
  wip/push-docs
  origin/html
  origin/maint
  origin/man
* origin/master
  origin/next
  origin/pu
  origin/todo

A different marker doesn't really seem like an improvement to me:

* (no branch)
  master
  next
  sent/branch-show-remote-HEAD
  wip/am-usability-improvements
  wip/push-docs
  origin/html
  origin/maint
  origin/man
@ origin/master
  origin/next
  origin/pu
  origin/todo

But I'm happy to have the community paint the shed I've constructed.

j.
