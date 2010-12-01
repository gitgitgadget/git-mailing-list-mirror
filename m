From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 01 Dec 2010 09:48:57 -0800 (PST)
Message-ID: <m362vd4c6h.fsf@localhost.localdomain>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 18:49:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqno-0006jL-HC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab0LARtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:49:01 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60802 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0LARtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:49:00 -0500
Received: by fxm20 with SMTP id 20so302672fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=JKU1nC+jT1oiewAjSKs0lqo+Zskm+h8Z7pYDX5oClcs=;
        b=piTbiTeBbWYZXfNKUmPZPiRO/2fzCWD6t/KZqxPMCouE+zhqRl8kT+LbxYI9IYftBb
         e6Ktau6ZKYv9EQG981l4IOUdj62DRDJMj6o4yXQerVW37p7Og+xweFFgPLzqSp45hYHV
         HvTeOVMNEmbCHKfITdWvQ1wKhuJdrQmW4yjtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Z/o6izE6/WmLeeH2xuKPpXWEx1xLZIKS8Lno+dlvJVXpRYG5jsKIqaFNzcexw1HTcX
         rYWhjUmBb9BhBkSdJuiU5ec44Z+PB0bMmBS5s1YBQRsOdUCQQ+tjejQkQTZD0iN4mOKS
         65k6WzdUUfA5MdOIquqSHJXqO7OCL1WHxc6Dc=
Received: by 10.223.70.133 with SMTP id d5mr4084229faj.64.1291225738954;
        Wed, 01 Dec 2010 09:48:58 -0800 (PST)
Received: from localhost.localdomain (abvl90.neoplus.adsl.tpnet.pl [83.8.209.90])
        by mx.google.com with ESMTPS id o17sm112783fal.25.2010.12.01.09.48.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 09:48:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB1HmPPc025123;
	Wed, 1 Dec 2010 18:48:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB1Hm7b5025087;
	Wed, 1 Dec 2010 18:48:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87r5e1v2g8.fsf@picasso.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162555>

Jari, could you please do not cull Cc list, if possible?  Thanks in
advance.

Jari Aalto <jari.aalto@cante.net> writes:
> 2010-12-01 18:50 Jonathan Nieder <jrnieder@gmail.com>:

> > If the goal is sorted option lists in all manpages, that will _have_
> > to be automated.
> 
> Who is going to write that script? I'm afraid that will never happen.
> 
> It's easier and faster to edit. One page at a time. As time allows.
> Nobody is going take vacation and do it once for all. Bit by bit is
> better approach.

But because some manpages "include" other pages (to refactor common
options), it would be impossible to sort alphabetically options in all
manpages.  So why bother with impossible?  It would only introduce
inconsistency.

> > why would I want sorted option lists in all manpages?
> 
> Does that really need an answer? You read from top to bottom, therefore
> A-Z. Well, GNU uses it in manual pages. 

What do you mean by "GNU" here?

>                                          It looks good, it looks
> professional, it looks clean. And it works when searching (= no
> orientation problems).

It works if you have separate user's documentation from reference
documentation.  GNU projects were meant to have manpages as reference,
and info pages as user's documentation.  Options sorted alphabetically
might make sense for reference documentation.  

But git manpages doesn't serve _only_ as reference documentation.  And
learning commands from manpages where options are sorted alphabetically
instead of grouped together by function *suck* big time.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
