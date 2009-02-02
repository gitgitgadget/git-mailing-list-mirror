From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH,v2] git-bundle(1): add no references required simplest
 case
Date: Mon, 2 Feb 2009 01:04:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902020056520.3586@pacific.mpi-cbg.de>
References: <87tz7i6scg.fsf_-_@jidanni.org> <87pri12078.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, mdl123@verizon.net, spearce@spearce.org,
	git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Feb 02 01:07:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTmKw-0004iC-Fj
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 01:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbZBBADq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 19:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbZBBADq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 19:03:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:49683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbZBBADp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 19:03:45 -0500
Received: (qmail invoked by alias); 02 Feb 2009 00:03:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 02 Feb 2009 01:03:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wSzpZv4MwuxTSx9kVkMewDb5YcPdUz7KE0sigRA
	jwsX0RbYqqs0EJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87pri12078.fsf@jidanni.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108028>

Hi,

On Mon, 2 Feb 2009, jidanni@jidanni.org wrote:

> Words totally by Junio C Hamano.
> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---
> 
> Junio: I used your words.
> You might have missed this patch. Resending.

You are not serious, are you?  People have explained time and time again 
what is required by a commit message.

Now, I am not a native speaker, but the commit subject seems to contain 
grammatical errors.  Even if it weren't, it is not understandable.

So the only thing that is in your complete commit message remotely 
purporting to explain what the patch is about and why it is good, fails to 
do so.

Also, we always have an empty line before SOB lines.

> +A complete bundle is one that does not require you to have any

I have not heard of any "complete" bundle before, and I do not understand 
the need for such a definition, either.

> +prerequisite object for you to extract its contents.  Not only you
> +can fetch/pull from a bundle, you can clone from a complete bundle

"Not only you can" violates grammar in my book.

> +as if it was a remote repository, like this:
> +
> +----------------
> +$ git clone /home/me/tmp/file.bdl mine.git
> +----------------
> +
> +This will define a remote called "origin" in the resulting
> +repository that lets you fetch and pull from the bundle, just
> +like the previous example lets you do with the remote called
> +"bundle", and from then on you can fetch/pull to update the
> +resulting mine.git repository after replacing the bundle you store
> +at /home/me/tmp/file.bdl with incremental updates.

IMO this paragraph just adds words, not anything the user does not know 
already by that stage.

Ciao,
Dscho
