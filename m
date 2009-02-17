From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Cloning into an existing directory
Date: Mon, 16 Feb 2009 18:53:17 -0800
Message-ID: <e38bce640902161853s20d44f5bmde42713ab66963df@mail.gmail.com>
References: <e38bce640902152310x195a14e5p445817bdfc6e319f@mail.gmail.com>
	 <c1b8b6670902152331p9bbdb8fo7bf7048039b5301c@mail.gmail.com>
	 <e38bce640902160813u2771d55co3eb583a0922c09c5@mail.gmail.com>
	 <a030d93b0902160848x1c0521c3jb5ed2f1bf865a097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:54:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZG6k-0002re-Mm
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZBQCxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbZBQCxU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:53:20 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:56745 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZBQCxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:53:19 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1050081yxm.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 18:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hkDg3fArQBfhPs1L9S5JqbI3h0wf2qF7b7wBkUs0YBc=;
        b=oe5Ba7eQG1UrKqgQ/+7Mn2VzkmoixCK5IBT2Yy5G5YEzQwC1wGGZn44MTLp7pRNxBf
         t4eMzfrE5rcUdUmA6MyN5t36jbGj4hORBUkChs7/xFEsEi8l/tOFerD5vr8FkODJUO1Z
         GMZDBYjuD/Uc7dC/RWqlAO/T+Os3+mU7OYELs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FjhVG0WMgvwzM/wJe8B64EhpBcwcqEq35ZuJmNZhNyaF89AW/iUPr76gqtlQ6u5gm8
         dOAYfc8gDBFto3s4cgEt8XholfMgoPxCrXVD4znzskEOzCCBKDo75kiA9I66lcim2lQu
         qcKWjSEUZaPZQEqYo/Tig89ZRrgkdYphMY9t4=
Received: by 10.90.98.12 with SMTP id v12mr787252agb.105.1234839197973; Mon, 
	16 Feb 2009 18:53:17 -0800 (PST)
In-Reply-To: <a030d93b0902160848x1c0521c3jb5ed2f1bf865a097@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110300>

On Mon, Feb 16, 2009 at 8:48 AM, Andrew Ruder <andy@aeruder.net> wrote:
>
> On Mon, Feb 16, 2009 at 9:13 AM, Brent Goodrick <bgoodr@gmail.com> wrote:
> > 1. Move aside each file it complains about
> > 2. Run the git-checkout command again
> > 3. Move each file back to their original names, thus creating a local
> > edit w.r.t. git
>
> Actually, on my git (1.6.0.4) this just magically works due to the
> fact that 'git init' sets up the repository with HEAD pointing to
> refs/heads/master (which doesn't exist yet) and you go ahead and
> create the master branch with the 'git branch' command.
>
> In other words, in this particular situation the 'git checkout'
> command is completely unnecessary and if you just run a 'git status'
> you should already see that git sees all the differences already as
> local edits (assuming you didn't call you branch in the 'git branch'
> step something other than master).

Well, it does show them as local edits, and actually shows the file as
deleted. I ended up having to do a git-add on those files and commit
them, which will work for me.

bg
