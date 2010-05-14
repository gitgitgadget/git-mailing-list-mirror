From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Git log follow question
Date: Fri, 14 May 2010 11:19:39 -0400
Message-ID: <AANLkTimfuINt0v_SETz9NsMGVXDL9d150B8En4TKqw3b@mail.gmail.com>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au> 
	<20100514043704.GC6075@coredump.intra.peff.net> <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	Albert Krawczyk <albert@burgmann.anu.edu.au>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 14 17:20:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCwgS-0004pu-5F
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 17:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab0ENPUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 11:20:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34069 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab0ENPUA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 11:20:00 -0400
Received: by fxm6 with SMTP id 6so1608279fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=a2GeKfNHNqj3InBbPu1tPnKpSpkjYydguIb2ULzvO1E=;
        b=YURJsGpBHnxq4Oo507/NpLV3ZwAYbTTjjOI55kLYm56Q3VBazOphnaHx2iKZ4YMnW7
         FRUntjUIc5ggwezy00zgfpi+haiTpmUjG9lNs+5SKWojqRcAXlFT2N8uPROvCT/KUSIV
         h3jqW+AV105kZ9lfIEJhkfWwINacuIG37Sv/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AOqDPF4Jn2PHPxK36lit0M1k3lv8OTwVwuJY+4/Hun4VA6PtCZaNvnifrkLuCLXLP/
         gSH0mM+D7RktJXMcrVwWi9YOj0dlgmNoeW8/PGCSqajzy82TPUlY8jIoRO5Kdf22LcPq
         tF7MFmPh7kwKGxK1UkLQnyC0ajGUBBjpI+POs=
Received: by 10.204.155.87 with SMTP id r23mr94920bkw.27.1273850399198; Fri, 
	14 May 2010 08:19:59 -0700 (PDT)
Received: by 10.204.120.65 with HTTP; Fri, 14 May 2010 08:19:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147091>

On Fri, May 14, 2010 at 10:50 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> If we want --follow and --parent to work together, you'd need to move the
> special rename hack to be in the early phases. I'm sure it's possible. It
> might even be reasonably simple. But it's very fundamentally not what we
> do now.
...
> It would
> be nice if "gitk --follow <pathname>" worked properly, but it's just not
> something I care very much about.

Putting the internal machinery aside, it would be enormously useful
for the end user.

The Linux kernel is unusual in that there are relatively few renames /
reorgs in the mainline -- maintainers pushback and force those things
to happen before a patchset is merged. And you (as the lead
maintainer) probably know all the renames in your own project.

The use case for this is: "Where the hell does this WTF-worthy
function come from, in this WTF-esque old codebase I just inherited?"

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
