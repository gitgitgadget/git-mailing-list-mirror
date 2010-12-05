From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5] generalizing sorted-array handling
Date: Sun, 5 Dec 2010 04:44:26 -0600
Message-ID: <20101205104426.GG4332@burratino>
References: <1291545247-4151-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Dec 05 11:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPC5Q-0007a8-Ce
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 11:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0LEKoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 05:44:46 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47421 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab0LEKop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 05:44:45 -0500
Received: by iwn6 with SMTP id 6so2003207iwn.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 02:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2LLLViM0iNUDcysP6KpWXni5ncSoC8hlGqr8LnsXVJA=;
        b=SYk+mRqLKfd7vY5kfxM8NbAAYq0x9d39i/sVQV7S6yTp8IRCKaVFR6sKoXh2lz1jFo
         A49acGUfYPGIWyKD+YO6leRoHk6ki90GpWvN9xgravxLMrqhyHLWhpofhoMCGk0PQ5VZ
         in96npjWB8pi56UQmj9wjuiEcVU4BfO4RTvkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LQFJo544YK1OWq2+WZOTUoMwAzAb/Nlb8GVWzZaSC7IvWkbmPqOGYxWKGJZ6e68uRM
         AiD0RHcpKS2P9bvauAy5RLnohKXZsFp5XqaojauAmf14BhtxxbvQ2rbj5PEcbLyv/Fiy
         ntDgpNoaipgKVaIS+V1jAmcvXJI3Vs7N707Vo=
Received: by 10.42.166.7 with SMTP id m7mr801809icy.273.1291545884899;
        Sun, 05 Dec 2010 02:44:44 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id d21sm3775483ibg.21.2010.12.05.02.44.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 02:44:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291545247-4151-1-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162942>

Yann Dirson wrote:

> * better API documentation (was previously lacking or plain obsolete)

Thanks!  In general I find it is easiest to read and write
documentation out of line for this sort of thing.  That way, even
after the documentation grows obsolete it doesn't seem so out of
place.

See Documentation/technical/api-strbuf.txt, api-sigchain, and
api-allocation-growing for some nice (up-to-date) examples.

In particular:

> * This API is very verbose, and I'm not happy with that aspect.

Could you give a quick stripped-down usage example?

[...]
> Adding "simple" API variants that would call all the necessary stuff
> would help code readability, but adding yet more entry points seems a
> dubious approach.

On the contrary, simple API variants don't sound so bad to me,
once the fundamentals are in good shape.
