From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Git-Svn-Bridge
Date: Fri, 19 Nov 2010 17:30:17 +0100
Message-ID: <AANLkTimH=iv5y5OdBXnVM=EVY2+FvY7dTgnLc4pZSkWP@mail.gmail.com>
References: <227dr7-3nl.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 19 17:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJTr1-0005ub-LR
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 17:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab0KSQaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 11:30:19 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59865 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab0KSQaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 11:30:18 -0500
Received: by qyk33 with SMTP id 33so54818qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xE2lE0SpTQXXH8isKgEq5x4hF8XhBWPqTr72004CVMg=;
        b=OHWkx7jJo6IH1IjiNbKdeTDtvg34Rn6V39LPt8jLfjLsRhqLXlMrq3v09bS8Dilnqz
         2zPKAigJ2QD2xTlRX1dJJLciKlWarl3zgVLT1UvQ04FF2sE4FRW1iMRBXRmFEtnxRN2g
         EDkJE8w6fphesJStgszc0b1/3TiMzgcbqU9H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OqBdrKVOSWPDyf5xb+w7Q2+uEeJNd6qH/juUOUNzm2popPeH3RZii47cOaT/NIm/BI
         866DXoJo4Qxx06MxwXXiytpEn3nTLWrA0ZJmSep+vqhEUhvvGlHevdKL0j8rSK3iA6Sd
         Bh/FiRigI2MoQnlWXwy26Psh5+eU3d14cR6UI=
Received: by 10.224.180.131 with SMTP id bu3mr2020236qab.11.1290184217257;
 Fri, 19 Nov 2010 08:30:17 -0800 (PST)
Received: by 10.220.194.193 with HTTP; Fri, 19 Nov 2010 08:30:17 -0800 (PST)
In-Reply-To: <227dr7-3nl.ln1@burns.bruehl.pontohonk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161764>

I would like to add a +1 on this topic.

There are very few "official" resources or de-facto recipes on how to
set up a git-svn bridge.

According to the 2010 survey [1], roughly 20% use git-svn in some way.
A subset of these are probably very interested in a git-svn-bridge
setup that works.

I've experimented with my own "hybrid bridge" setup [2], but I've yet
to hear whether it's wrong or can be done better. Someone on #git
claimed it was more complicated that it had to be, but as far as I've
heard, the setup in Loeliger's book is even worse [3] (no offense to
his book though, I haven't read it but heard it's great).

I've roamed through this mailing list, StackOverflow, and generally
googled all over, but I haven't found any *really* good setups. It's
not mentioned in the GitSVN migration guide [4]. With the amount of
people still using git-svn, I would've thought this topic would get
some more attention.

Some say that creating a centralized bridge is generally bad idea, and
it's better for all to just individually use git-svn as an SVN-client
directly. But I'm sure if I had advocated this at my company,
checkout/update performance wouldn't impress many, and I would still
be the only git-user. Thanks to the git-svn bridge, we are now a
handful Git-users, using Git for builds in Hudson, and steadily
gaining traction.

So, to shape it in form of a question: What is the optimal git-svn brid=
ge setup?

Thanks,

-Thomas

[1] https://git.wiki.kernel.org/index.php/GitSurvey2010
[2] http://www.tfnico.com/presentations/git-and-subversion
[3] http://blog.emmanuelbernard.com/2010/05/git-how-my-life-has-improve=
d-since-last-month-when-i-used-svn/comment-page-1/#comment-2248
[4] https://git.wiki.kernel.org/index.php/SvnMigration


2010/11/17 Christoph Bartoschek <bartoschek@gmx.de>:
> Hi,
>
> we would like to use a Git-Svn-Bridge as it is described in Jon Loeli=
ger's
> book. However there are some open questions:
>
> We have the bridge repository and the bare repository created.
>
> a) Are the developers supposed to work on a branch that follows =A0ma=
ster from
> the bare repository or on a branch that follows svn/trunk on the mast=
er? I
> assume they follow the master.
>
> b) How do we get changes from the bare repository to the bridge repos=
itory?
> Should there be a new branch for the changes or should one use master=
 from
> the bridge?
>
> c) How do we get changes from subversion to the bare repository?
>
> d) Are the changes from subversion applied to the bare repository mas=
ter or
> only to the svn/* branches?
>
>
> Thanks
> Christoph
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
