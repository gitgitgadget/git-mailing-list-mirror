From: Dilip M <dilipm79@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 17:02:06 +0530
Message-ID: <c94f8e120909280432r35794641ycd50b4cee0bd89b7@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: newsgroups@catchall.shelter13.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 13:32:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsESv-0000Oy-A6
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 13:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbZI1LcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 07:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZI1LcD
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 07:32:03 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:63330 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbZI1LcC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 07:32:02 -0400
Received: by ywh4 with SMTP id 4so4582569ywh.33
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=bIPIamyt87UPhA+uZJV8IPssUP0pazAiI6iMqNv15H4=;
        b=Xrpp5bA47/Yd1kyj8WoTb4zOsBZ/39AqnsJrKhjV8gBpZPj/J3W3konKVQoK/uMjDa
         5lNuDRslquygmhBWiV7cqjVBayiWX1GHlckr7YkRfz2ngtRa/4e3KGHYIUryMlIZCKxP
         S0IIHKsUyp8izVyQF9M89WJLWb8Z+MFYxi4NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=lGiL0XDN81URuepUnvaPxfADQdLkCWMs49qO7OrwsvHcn0ZWp4hhrHfYJdeMK1+rDt
         UPKIiXI/MoqREJvkhPrUN95xmkVhZy4a53f1BAWcj8UtiBCyxYIWrBeGXgAmFQC/Vp6C
         64xW6e4W2ZtEewqSEYuSZ9NmpMhaB9fafnpU0=
Received: by 10.151.93.16 with SMTP id v16mr7613198ybl.205.1254137526719; Mon, 
	28 Sep 2009 04:32:06 -0700 (PDT)
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129251>

You better evaluate yourself on the project you are going to use git
or Hg. Hg and git are used both by big companies. Google uses git to
host android, where as it also uses Hg to host google wave! So don't
go which company uses what, but try to evaluate... Check what is the
kind of operations your developers do often? Is it checkout, diff,
blame, also are they ready to do git gc often? What about developer
who is not interested in using cli? How do u care them for operations
they intended to do? what is the workflow? Which tools supports it to
great extent?

At the end of day, it is a developer who spends much time using tool..

Just  my opinion...... you put this question in Hg list, I bet you
will get the different views....

The above is solely my opinion and I am not biased! I think so:)



On 9/27/09, Anteru <newsgroups@catchall.shelter13.net> wrote:
> Hi,
>
> I'm currently evaluating DVCS for a project, and we're at a point where
> it comes down to either Mercurial or Git. Right now, I'm advocating for
> Git, while my co-workers like Mercurial, so I'd like to provide some
> good arguments in favor of git. Unfortunately, I'm not a git expert, so
> I hope I can get some help here ...
>
> First of all, what's the matter with git and Windows, is there some
> long-term commitment to make git work on Windows as well as on Linux?
> I'm using msysgit on Windows, and personally I'm happy with it, but my
> co-workers constantly nag that Mercurial has superior portability ...
>
> Mercurial's revision number system: With git, I get an SHA1 hash for
> every commit, but it's not possible to see whether Hash1 is newer than
> Hash2, while Mecurial also adds a running number to each commit. What's
> the rationale behind this decision for git, and is it possible to
> emulate Mercurial's behavior somehow?
>
> Integration into tools: We're using Trac currently, which also has a
> nice binding to Mercurial (well, obviously easy to do as Mercurial is
> written in Python, just as Trac itself), while the git support is in
> development and looks quite alpha'ish. Do you plan to make it easier to
> integrate git with other tools by providing bindings to other languages,
> or is this a low-priority issue?
>
> So far, my key arguments are that git is more robust (more projects
> using it, larger developer base), of course git's excellent performance
> and the much better support for SVN, which is important for us as we can
> slowly migrate from SVN->Git, while hgmercurial is still in the making
> (and Python's SVN->Hg switch is for instance waiting for it).
>
> Cheers,
>   Anteru
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sent from my mobile device

Dilip
