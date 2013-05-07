From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: offtopic: ppg design decisions - encapsulation
Date: Tue, 7 May 2013 10:32:15 -0400
Message-ID: <CACPiFCLtYKsXQ-aoPadJxkB5phQ+j2PAfHnDTJK6B85mcfRF_g@mail.gmail.com>
References: <CACPiFCL+cd1vmqj6JEj84L5rDvHGxDgo+zGw5__ard6-sumipA@mail.gmail.com>
 <20130506155353.GF25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 07 16:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZiwb-0005JX-NG
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab3EGOch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:32:37 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:42041 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab3EGOcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:32:35 -0400
Received: by mail-vc0-f171.google.com with SMTP id m16so549834vca.2
        for <git@vger.kernel.org>; Tue, 07 May 2013 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7LhSKnL7gdxEA0YX1LzooHCdRq8zcdEjost/iFxzNUQ=;
        b=QgtVtSrP7A59QwGE/1/QOYmYKi+cnP/aZ2aY4S8zf0SJITa9yBaHo8UgvvlMCj/p2J
         b52xcYPnWl80s7yzchsABWuGe0rEP1agT1wTuBP+wUMRbvigW4w1OoYZpUHcsZ1xMEzZ
         lSoKmV4YQJCuUCGwiUF/3xk2puz3KClGEvGuHN17Y9CQs6xVjGaE2LvuAc9ML53qBiI5
         I9FyNsygSEHlMa7mcA3F+OsOwVKd7+IgPcWLjUwej9DeO01Q7Su+tc7jNxPA27N/rfKT
         heGejfW5mCTP5WT1QRqu6tgd2qlFaHvsApveLnNQUAFInIor5WBc4yvTmRKRkrqSzm8d
         +x2w==
X-Received: by 10.220.168.202 with SMTP id v10mr1346528vcy.71.1367937155168;
 Tue, 07 May 2013 07:32:35 -0700 (PDT)
Received: by 10.220.248.79 with HTTP; Tue, 7 May 2013 07:32:15 -0700 (PDT)
In-Reply-To: <20130506155353.GF25912@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223573>

On Mon, May 6, 2013 at 11:53 AM, John Keeping <john@keeping.me.uk> wrote:
> I'm not sure I fully understand what the reports are, but it sounds like
> they are closely related to original configuration commits.  If that is
> the case, have you considered using Git notes instead of a separate
> repository?

Interesting suggestion! I read up on git-notes.

Yes, reports are closely related to a commit -- it's a lot of the
execution of puppet with that config on a client node. At the same
time, we have one report per change deployment, per client -- with
thousands of clients. So it will be a large dataset, and a transient
one -- I intend to use git as a store-and-forward mechanism for the
reports, and it is safe&sane to forget old reports.

I don't see much ease-of-expiry in the notes, so I guess I would have
to write that myself, which complicates things a bit :-)

cheers,


m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
