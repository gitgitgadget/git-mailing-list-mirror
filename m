From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 03:31:17 -0700 (PDT)
Message-ID: <m38wsei8ne.fsf@localhost.localdomain>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
	<cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 12:32:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtJy5-0006uu-EJ
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 12:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYJXKbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 06:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYJXKbV
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 06:31:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:9429 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYJXKbU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 06:31:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so326064nfc.21
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CHTAANSotiJRkOPmpbTTI+q65uYO6Sny1xiygHFN9LY=;
        b=ft3qqnXb5Le8YycBVZvo8Cf+IzxyV+hIrrkdasw25AxyWfbI4P68VlQRdXOqCWmQyz
         LXqBwYwGhA0l1/t3n4A09CFgni+PF+dkn8alwFpOyHk9Inp+7z+RVhWVk46K5z/OviCu
         3HI14GM8JeZH0DyDh6qRuyc0wc0RLBxoUoqrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=YOUnpovbwn7UhU3HLnCuyvOjnK2z43826vsbHEK+5waEZVaWn+JgoVEVXdidlaZzlN
         GSbE2vVReGAZCJcPz0EzYTy1rg20lt6kTIE9pBtTq/coRLy1g8ElvBJM2EaI5QlCht3I
         bj4uET4ZlZYPLwvNl505kPwLDXAQ+Piju1g38=
Received: by 10.210.68.17 with SMTP id q17mr2092101eba.181.1224844278823;
        Fri, 24 Oct 2008 03:31:18 -0700 (PDT)
Received: from localhost.localdomain (abwq207.neoplus.adsl.tpnet.pl [83.8.240.207])
        by mx.google.com with ESMTPS id 20sm18400968eyk.4.2008.10.24.03.31.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 03:31:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9OAYVtF019686;
	Fri, 24 Oct 2008 12:34:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9OAYUL2019683;
	Fri, 24 Oct 2008 12:34:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99024>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
> On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:

> > If you decide against a shared repository, maybe you want to
> > consider to not use ".zit.file/", but ".zit/file/" as the
> > repository?  This would reduce the clutter to a single directory,
> > just like with ".git".  And moving files around wouldn't be that
> > much complicated.
> 
> Right. I'll give that a shot.

By the way RCS which I use for version control of single files use
both approaches: it can store 'file,v' alongside 'file' (just like
your '.zit.file/' or '.file.git/'), but it can also store files on
per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
'.zit/file.git/' solution)

By the way, it would be nice to have VC interface for Emacs for Zit...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
