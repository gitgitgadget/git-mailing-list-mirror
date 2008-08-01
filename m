From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Git vs Monotone
Date: Fri, 1 Aug 2008 09:23:36 +0200
Message-ID: <bd6139dc0808010023r5d44e7a2ke062c9c39dfb865c@mail.gmail.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOp0J-0007R3-7C
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131AbYHAHXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 03:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758097AbYHAHXk
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:23:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:5588 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbYHAHXh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:23:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1250747wfd.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rSJ+GP5SHyBvA7HtANXW7+PL7JR9H+PX3vGHFSkb26E=;
        b=H2NXaRie6t/TAshODaiIdO4phuSFADKo6IWAfkMvGYKoUqsTLkyz2S7QntpoSvyfND
         pjDc0Yy83vg/3xDt9R+ZGGo5+gNBXg1r5DM8iHHjICK7y3CjI/89C9IPg351qAqvNzNJ
         QYjvdpUF/070k2plXu7Jjd+FHOEEWbvoKT7O4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kAH7BPFysdvaHrOhpabaNzS5+QkPr5AfNVQI+hjq/ATk0S+ygmMNvpmPcuc5YY9Bfw
         WzwtJ8C+I4Y2ei5Id2wJ6CVUk0WahEZn183zPzktAWS31lmT29bAlruI1B0gMuh0f2I3
         gQzxaYqTF0ZHdbrP7DuUFB7m+myhhkWjlyJcI=
Received: by 10.142.139.19 with SMTP id m19mr3623521wfd.25.1217575416381;
        Fri, 01 Aug 2008 00:23:36 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Fri, 1 Aug 2008 00:23:36 -0700 (PDT)
In-Reply-To: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91034>

On Thu, Jul 31, 2008 at 20:13, Sverre Rabbelier <alturin@gmail.com> wrote:
> I just read this blog post [0] in which one of the Pidgin devs sheds
> his light on their 'tool choice'. In the post he mentions the
> following figures:

> [0] http://theflamingbanker.blogspot.com/2008/07/holy-war-of-tool-choice.html

I have poked him on #pidgin, and he has added the following:

"Note: It's come to my attention that I had missed the ability to
share a git database across multiple working copies. In that scenario,
the total size of the database and 11 working copies is slightly under
750 MB, and thus a space savings in the neighborhood of 150 MB over
monotone. It had been my understanding that I needed a copy of the
database per working copy. I stand corrected. I don't use git on a
daily basis, as the projects I work with currently use CVS, SVN, or
monotone, so I am bound to miss finer details of git here and there.
There are other reasons I prefer to stick with monotone, but I won't
get into them here, as they're not important to the point of this
post."

So I'm happy ;).

-- 
Cheers,

Sverre Rabbelier
