From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git-Mediawiki : cloning a set of pages
Date: Wed, 8 Jun 2011 19:04:27 +0200
Message-ID: <BANLkTim54YGYN50gZtqwe8w6-du_aTDWTQ@mail.gmail.com>
References: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com> <20110608151940.GD7805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:05:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMBt-0007kF-Lz
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab1FHRFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:05:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43696 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab1FHRFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:05:08 -0400
Received: by qwk3 with SMTP id 3so328945qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0kelPoyuhPgppLkL5tgqTtUDJknz/KyTHcOraXu6czg=;
        b=D53spvnSvgWcPmx+2tsdeZqgByf8WBQtdquak6KGkS1Kt0hiSAj4gtP0AQAhdb4+8w
         tuyD3LM1YXoXkQkm58AL2/JQwbIlVz03gfBcwkd/kbjHMzB0kqv72ckVhK7KzWst1ig9
         EQdPsNlvz3OlsfpqATDt3FbBL3cM41e2FBDvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=F4OzLXCDefc+ef1B3rtN9Eq4BM/d81F6pZFuQU+EuacPW9N+xur/Ipah+YxwA82AaD
         OvlxO0QbeKy1oJiosYwUorvcB2fkJYQ3n7Pf1J4JazDlYjgVNdN6msPi4aHozBiMeyP3
         ciZ7C2BTUk/Zyi4NPy39XPHCl58XZ7HHeUcA4=
Received: by 10.224.136.5 with SMTP id p5mr4083264qat.127.1307552707254; Wed,
 08 Jun 2011 10:05:07 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 10:04:27 -0700 (PDT)
In-Reply-To: <20110608151940.GD7805@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175401>

Heya,

On Wed, Jun 8, 2011 at 17:19, Jeff King <peff@peff.net> wrote:
> Maybe it would be even simpler and more flexible to give clone a "-c"
> flag that writes specific config variables in the newly-created
> repository.

This makes a lot of sense. What about a use case like git-svn supports
currently, where you want to indicate "use the default
trunk/branches/tags setup"? Yes, you could do `git clone -c defaults
svn://example.com` and then git-remote-svn can set the relevant config
options itself. The only downside is that git-remote-svn then needs to
unset 'defaults' and set the appropriate values itself (to avoid
cluttering the config file). Thoughts?

-- 
Cheers,

Sverre Rabbelier
