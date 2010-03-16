From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Retrieve a specific file from some revision.
Date: Tue, 16 Mar 2010 17:59:36 -0400
Message-ID: <46a038f91003161459t58c8df59q2b7fa18c1fccba88@mail.gmail.com>
References: <87vdcwxfit.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Harry Putnam <reader@newsguy.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 23:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nreo6-0001zU-Ej
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 23:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab0CPWAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 18:00:01 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:52606 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0CPV77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 17:59:59 -0400
Received: by gxk9 with SMTP id 9so184510gxk.8
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=mSM3zBXFOX+evWPXLqfdQAzsPzW+E8alQrRQ5rpUtp0=;
        b=dPa6t/ZmZAoYDuovvHgJwbzQM9PQgUl+PUcKqQ1Tm9KuO3enQU2pq7VcnhVph5OO07
         5fAt13uXDXTieEdhHno4zyMj577cqfzUFMnnNaJYLEc/ozPeEjYiSBqWUMGE8nERThn4
         6xuXcPdx+6Te8z1nD6G245vJeOh9FvvjySrV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b/THoR3B94V1IW49O7KPMvKB9RgKoc+Zs8PteP2yOvkIY/2umBOA1jnuQyiLzyUnvI
         k05vGF38v0AWu6B06FAB80GfU0CBVZBAPMh6qwx/4CcFq82jifstodE68PWht2rkoAwG
         BQsAzjXGTh1172Di+DONz8GFFMnEFbUaqdRA4=
Received: by 10.101.42.3 with SMTP id u3mr90240anj.323.1268776796177; Tue, 16 
	Mar 2010 14:59:56 -0700 (PDT)
In-Reply-To: <87vdcwxfit.fsf@newsguy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142353>

On Tue, Mar 16, 2010 at 2:55 PM, Harry Putnam <reader@newsguy.com> wrote:
> How would I do that in bazaar/git?

The easiests, most convenient is:

   git show <revision>:path/to/file.c

git show can do various other things -- like show you a commit.

You should really follow a tutorial for git (and/or bazaar) to get
"the basics". Any good tutorial will cover git show (but may not touch
this specific point) and a few others.

It is safe to say that bazaar, git and hg have a good command for
something clear and basic like this. Asking these questions probably
won't help you decide what you want to decide ;-) --



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
