From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Alternative to manual editing with git add --patch
Date: Wed, 14 Oct 2015 18:30:58 +0200
Message-ID: <vpqeggx9zul.fsf@grenoble-inp.fr>
References: <561E6FBB.7060302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sven Helmberger <sven.helmberger@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:31:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmOxJ-0003sB-8o
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 18:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbbJNQbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 12:31:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49411 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbbJNQbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 12:31:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9EGUvMa019499
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 18:30:57 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EGUwGK032544;
	Wed, 14 Oct 2015 18:30:58 +0200
In-Reply-To: <561E6FBB.7060302@gmx.de> (Sven Helmberger's message of "Wed, 14
	Oct 2015 17:07:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Oct 2015 18:30:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EGUvMa019499
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445445057.40851@O6swgu9J/plUCrUIVEDwTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279578>

Sven Helmberger <sven.helmberger@gmx.de> writes:

> Hello,
>
> I hope this hasn't been discussed before.
>
> I'm a big fan of cleanliness in commits and therefore often use git add
> --patch to sort code changes I made into the right commits etc.
>
> What I then often encountered was the situation where I happened to have
> inserted consecutive lines of code that conceptually belong to different
> commits. Normally I can nicely split patches, but not in this case,
> making manually editing the patch the only alternative.
>
> Shouldn't there be at least a way to quickly say line-by-line if you
> want to have it added or not?

Many GUI or text-editor plugins for Git allow you to just select lines
and stage the selection. Even though I love "git add -p", I find magit
(Git integration for Emacs) more convenient when it comes to staging
individual lines.

That said, a "split hunk line by line" option for "git add -p" could be
nice.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
