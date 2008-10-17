From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 02:16:35 -0700 (PDT)
Message-ID: <m3d4hzk2du.fsf@localhost.localdomain>
References: <7vy70of6t2.fsf@arte.twinsun.com>
	<2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio Hamano" <junio@twinsun.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:17:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqlSy-0003Q9-CV
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 11:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYJQJQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 05:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbYJQJQj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 05:16:39 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:41283 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbYJQJQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 05:16:38 -0400
Received: by ey-out-2122.google.com with SMTP id 6so160258eyi.37
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=oNVIwLdU2ZnU5juSOioZiiIRsie1FtxJ2R6jfnOj79Q=;
        b=F4mMU2jQSvTJKmGyGPdMWW4e1u6E9bjglh3ens335KHZI1ZGtc2dXY8TcxAW4Fgfua
         gmBLIY84ZJzkqRZCEe41uoFMwrbzXaIFfc3YoghmEUWyyyz0AxjoKQHON6a6ERixTNho
         D0Q9WRn/zs9x5sqRxCMpclP/MK5fZUIlpUviw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jmf/HLXCLIo1PFRhXAK731MCYtYT8kbYHjto1BubSMt+V/1fZlLKfamH3LRIOSOmAw
         hzeXWbNu6AGv8igkpA0F+lUxY162q4MulQ8f43EgMWj+mATeaCLLzoima1jlBz+0SKG+
         UxBVjMAVnZRpL+0AkgMzJxSizMz2PZAMjBNr4=
Received: by 10.210.24.7 with SMTP id 7mr4173220ebx.11.1224234996510;
        Fri, 17 Oct 2008 02:16:36 -0700 (PDT)
Received: from localhost.localdomain (abvf153.neoplus.adsl.tpnet.pl [83.8.203.153])
        by mx.google.com with ESMTPS id 3sm3428821eyj.3.2008.10.17.02.16.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 02:16:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9H9GVGC029931;
	Fri, 17 Oct 2008 11:16:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9H9GTiI029928;
	Fri, 17 Oct 2008 11:16:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98462>

"Richard Hartmann" <richih.mailinglist@gmail.com> writes:

> On Fri, Oct 17, 2008 at 01:39, Junio Hamano <junio@twinsun.com> wrote:

> >  (2) pre-commit hook is a last ditch effort to help ignorant
> >     users who have already done "git add" without thinking and
> >     lost the "unmerged" state.  It has to look at and guess at
> >     the contents for that.
> 
> Ignoring the ad hominem attack, I would argue that the two
> distinct mental concepts of 'I want to commit this in the next
> commit' and 'I have resolved this conflict' should have two
> distinct commands.
>
> To err is human, which is why rm -i exists. Else, you could
> just use alias rm='rm -rf'.

>From time to time somebody proposes to add a command which is used
only to say that given conflict got resolved, i.e. yet another
porcelain "around" git-update-index plumbing (in addition to git-add,
git-mv and git-rm).  One of problems is how to call it: git-resolve,
git-resolved, git-mark-resolved?

BTW. while I usually use "git commit -a", when comitting merge commit
I usually use explicit "git add" together "git commit" (without '-a').
-- 
Jakub Narebski
Poland
ShadeHawk on #git
