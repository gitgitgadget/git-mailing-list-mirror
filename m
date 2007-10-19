From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 20 Oct 2007 01:27:54 +0200
Message-ID: <8fe92b430710191627k570d9acfh22255a3971f172ed@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Federico Mena Quintero" <federico@novell.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 01:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij1GH-0003rg-Ju
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 01:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbXJSX2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757134AbXJSX2A
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 19:28:00 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:59121 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbXJSX2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 19:28:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so593986rvb
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=inMLkXMrcYpwNv4XWf7ZC2Ua8jwaKHMzMrpv4C7WEhk=;
        b=CMDLapwookl1tlyWCPbNmPjM6goStyDphwLAyPv/Vcd0l1nntIGI0Y4DZCPJ1zkgLBTGcY3E3cIM0z4/OF1mUwiKO0cGDuTK2eoTLx4x3DQ+6r3JQ9BIoQEIYDxEHk4xnGXu2jPPrccfKSoQf6JrC4DaxBJxKMgEXfriS+bEymE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Op60UcAVClGPVnA6Sl1tQKZkOM4x8gxV3RWuCdqtAJdPRUwbT8LEQQ2Du5Qsurk+uak7ks+9RxkWPAMk0eUUoz8sh38HIDQZ1WJsvyJEEd57T2vz8RgJJArMaa3AQZx6E/Ubtfo0paLCi3kyIbmJwkmRh8elDMmG9tH2T/bvDk8=
Received: by 10.114.254.1 with SMTP id b1mr2617652wai.1192836474404;
        Fri, 19 Oct 2007 16:27:54 -0700 (PDT)
Received: by 10.114.160.12 with HTTP; Fri, 19 Oct 2007 16:27:54 -0700 (PDT)
In-Reply-To: <1192827476.4522.93.camel@cacharro.xalalinux.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61774>

On 10/19/07, Federico Mena Quintero <federico@novell.com> wrote:

> "Make git more task-oriented rather than data-model-oriented" is about
> making the tool adapt to what you usually want to do, instead of making
> *you* adapt to the way the tool wants to work.  Many commands in Git
> have documentation like
>
>   "option --foo updates the refs without modifying the index.  Requires
>   a clean working tree"
>
> This is gibberish for people who are not very familiar with Git's
> internals.  "Git for computer scientists" provides a *very nice*
> explanation of the DAG and refs and tags, but unfortunately it doesn't
> explain the index, why you would want to know about it, etc.

That is what "Git User's Manual" (and tutorials) is for. And there is
glossary in documentation.

[...]
> It's nice that Git lets you manipulate the repository in all kinds of
> ways, but presenting porcelains at the same level as plumbing makes
> things hard for users to learn.  I was just in our Beijing office,
> teaching people about development tools and Git in particular.
>
>   Federico: "get Git from this location"
>
>   Beijing hacker: tap tap tap, "okay, it's installed now"
>
>   Federico "Git commands all start with 'git'"
>
>   Beijing hacker: git<Tab>
>
>   Bash: Display all 150 possibilities?
>
>   Beijing hacker: "oh, shit..."

It is better to use bash (or zsh) completion, than rely on completion
of commands names.

Beijing hacker: git <Tab>

(that is, space after 'git') shows around 62 commands.

> It's hard to know where to begin :)  Do I need "git-cherry-pick" or
> "git-cherry"?  Why is the "apply a patch" command called "git-am"?  Why
> is it different from "git-apply"?  From "git-applypatch"?  Etc.

I think git-cherry will soon be obsoleted and removed, such like
git-applymbox and it companion git-applypatch are being obsoleted by
git-am.

git-am applies series of patches _with description_ from messagebox,
creating commits if patch applies without conflicts. It requires git
extended patch for sensible operation; it is best when patch is result
of git-format-patch. git-apply is to apply GNU patch (optionally git
patch) to working area, or working area and index, but do not create a
commit. It is improved version of GNU patch utility (it understands
git extended diff syntax), but it is not meant (alone) to work with
commits send by email.

-- 
Jakub Narebski
