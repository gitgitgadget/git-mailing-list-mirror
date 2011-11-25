From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Fri, 25 Nov 2011 09:43:14 +0530
Message-ID: <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 05:13:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTnA9-0005MS-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 05:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab1KYENQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 23:13:16 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50243 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab1KYENP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 23:13:15 -0500
Received: by ghrr1 with SMTP id r1so3077590ghr.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 20:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=coHmY6D8rOE22UFkFhsvmKX2GJw5UIqda4va5WNzW7I=;
        b=SeUVH/pMh64I3UKIFT5Lg8+yep+Ot84U86VekOXQuJGoWrbQwlubJZOhlC8XH+DMVw
         BlG9Tx7VOy3KA8R29Hn3lk9h6ufbgnfbMMeZ6vI8EsXOpuf133/cnKsfbgb11mVjbiwh
         K8/+MVBpqVny7mziP+NIcPQzmzKlwCeLl1CNA=
Received: by 10.182.147.4 with SMTP id tg4mr9963203obb.60.1322194394963; Thu,
 24 Nov 2011 20:13:14 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Thu, 24 Nov 2011 20:13:14 -0800 (PST)
In-Reply-To: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185926>

On Fri, Nov 25, 2011 at 8:46 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> (...and/or a post-upload hook)
>
> Has this ever come up?

Sorry for the google-fu fail and for replying to my own post.
http://git.661346.n2.nabble.com/Removal-of-post-upload-hook-td4394312.html
is the longest thread I (later) found.

The quick summary, in the words of Jeff (second post in that link) is:
"Because [upload]-pack runs as the user who is [fetching], not as the
repository owner. So by convincing you to [fetch from] my repository
in a multi-user environment, I convince you to run some arbitrary code
of mine."

My contention (today) is:

  - you're already taking that risk for push
  - so this would add a new risk only for people who fetch but don't push
  - which, I submit, is a very small (if not almost empty) set of people

I may be wrong but I imagine shared environments are those where
almost everyone will push at least once in a while.  It's a closed
group of people, probably all developers, etc etc etc...

Thanks for listening.
