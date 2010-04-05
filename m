From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: How to keep different version numbers in different branches?
Date: Mon, 5 Apr 2010 19:50:01 +0200
Message-ID: <i2j46d6db661004051050rfb6aa9d0i3a9e20a348e5a110@mail.gmail.com>
References: <hpcscv$umg$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 19:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyqRB-00033i-LM
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 19:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0DERuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 13:50:08 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:57421 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab0DERuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 13:50:06 -0400
Received: by bwz1 with SMTP id 1so2949334bwz.21
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=fbC4ZeuprYjWuS2YfqPZir0jg8pYZJvEFJ09ml91Gsw=;
        b=c6p1+CP0/mVs1/FgiAHcdtpxwTt9WmV+UF2jTdTrCXTV7ydydcjo9ty5arCk6rwg+T
         MA2O2OQIf0k/l7oJtrRlWcKGyjrrNmCzVj/1Ae3PDrLU9r5EmQ3QRpvDGyf3AtlRZEOB
         B/ta2jBaqF4VkdmHy1MUdIhI/wqK0NvcSaOB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xwysPBfAFS9F8rCmmcz/iVOQYvV7kD75L7tc69Iutmy0ZBjooNkt+p5QKtTHZknQom
         os+ZxWsBCJr09leoPl736pz8vYzUQ87LVLBypkdPo1U6p/0VltLThxVEiOEBnWCQr31Z
         e63I3Gui1josXtYgEM9Yxe+ofoMOR63UTLVFs=
Received: by 10.204.72.6 with HTTP; Mon, 5 Apr 2010 10:50:01 -0700 (PDT)
In-Reply-To: <hpcscv$umg$3@dough.gmane.org>
Received: by 10.204.162.145 with SMTP id v17mr2695816bkx.83.1270489802895; 
	Mon, 05 Apr 2010 10:50:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143995>

On Mon, Apr 5, 2010 at 4:34 PM, Stephen Kelly <steveire@gmail.com> wrote:
>
> Hi,
>
> My project uses git and so far has only one branch, 'master'.
>
> http://gitorious.org/grantlee/grantlee
>
> I want to make a 0.1 release, so that would mean creating a 0.1 branch and
> updating files contained in the branch such as the README file and the CMake
> files and the api documentation to report version 0.1.0, and creating the
> 0.1.0 tag. The next tag on that branch would be 0.1.1 etc. Simultaneously,
> the version number in those files is changes to 0.2.0 in the master branch.
>
> However, now I have changes in my maintenance branch (0.1) which should not
> be merged into master (that is, the commits which change the version
> number).
>
> How are you supposed to handle that with git? Simply merge and resolve the
> conflict on master by keeping its version number? Am I missing some other
> way of doing it here?
>
> Additionally, I have some stuff currently in master that should not be in
> the 0.1 release, but should be in the 0.2 release. If I branch and then
> remove those files from the 0.1 branch, a merge will then remove them from
> master too? How do I keep them on master but delete them on 0.1 and still be
> able to merge from 0.1 into master?
>
> The only option I can think of are to do the merge, then revert the commit
> sha on master that does the delete.
>
> Is that the recommended way of doing this? I have read the git workflows
> page, but it doesn't seem to cover either of these scenarios.
>
> http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html
>
> Thanks,
>
> Steve.
>

Steve,

you might want to have a look at this: http://nvie.com/git-model

Rgds,

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
