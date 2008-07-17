From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Subversion's do-everything-via-copying paradigm ( was RE: Re: Considering teaching plumbing to users harmful)
Date: Thu, 17 Jul 2008 18:07:36 -0400
Message-ID: <32541b130807171507j98f883by2e937e894838852@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <alpine.DEB.1.00.0807161902400.8986@racer>
	 <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
	 <alpine.LNX.1.00.0807161605550.19665@iabervon.org>
	 <861w1sn4id.fsf@lola.quinscape.zz>
	 <m3od4wse30.fsf@localhost.localdomain>
	 <86k5fk1ooq.fsf@lola.quinscape.zz>
	 <63BEA5E623E09F4D92233FB12A9F79430238A16B@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 00:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJbeP-0002Fj-40
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 00:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbYGQWHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 18:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903AbYGQWHi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 18:07:38 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:51676 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbYGQWHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 18:07:37 -0400
Received: by qw-out-2122.google.com with SMTP id 3so82285qwe.37
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hBKUrtlKiUHh/UzNg0wUkYgX8tmZQK9RKizOIm5x+Tk=;
        b=L/bL2Yk+O1g+1gcj/6ffhZCgyTmDZCFobc/KULu0rovIVfbtYPAV1RZU+22ba8q0qz
         +mm5u3qRO7FdPDc5rhIwL/OHHtO788sGbZCN37GK3aMA7yysr1wpA1+zsqloPGMyeG/0
         4xINKJLFC7m9VQAC5HNkEj6l8OjzdrJ/k422g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=f+q5nmT5CwStpVERq5yWs+TXLNHHQd/eojQYdyL3gXvz/QC/4TdKTX7oduB/J2A/DP
         EQkUiZ3HyZc9C7QEY0LQb4ouGoYwFpDfCUP15W2uV+ncS0H1uP4HNiNc9GqE102am9Bs
         SomKS+L0hj+P5KArArUvpBX3WgLObJMR6/OwA=
Received: by 10.150.206.1 with SMTP id d1mr1175868ybg.144.1216332456253;
        Thu, 17 Jul 2008 15:07:36 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Thu, 17 Jul 2008 15:07:36 -0700 (PDT)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430238A16B@emailmn.mqsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88930>

On 7/17/08, Craig L. Ching <cching@mqsoftware.com> wrote:
>  Does it not bother you that renaming a file is a copy + delete [1].
>  Have they fixed that yet?  That was one of the biggest reasons we never
>  moved to subversion.

Perhaps you've confused CVS with subversion.

svn's handilng of renames is not as graceful as git's, but it does
work in the common cases.  For example, after the aforementioned
copy+delete, "svn blame" and "svn log" will still follow history back
through the rename.

Not sure how I ended up defending subversion on this list.  Somehow
I've been tricked into being on the losing side of this argument :)  I
guess I just wanted to balance the viewpoints a little; there are good
things to be learned from svn, but not things about branching,
merging, or rename tracking.

Have fun,

Avery
