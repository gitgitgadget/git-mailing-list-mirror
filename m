From: Jed Brown <jed@59A2.org>
Subject: Re: Find/prune local branches after upstream branch is deleted?
Date: Fri, 19 Apr 2013 12:50:48 -0500
Message-ID: <87bo9a4dfr.fsf@mcs.anl.gov>
References: <87ehe64f91.fsf@mcs.anl.gov> <20130419173717.GA26964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFSf-00026G-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3DSRu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:50:57 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:65340 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3DSRu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:50:57 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so2464943iag.0
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=Ht3DuGRwx96yPK5lER6SDJ6zgAvT41rGXWjuZ68OCK0=;
        b=osGe12EZ8R7D8N/k6Wug/uug1lhybODvGzDzQ275VOrX7qqVUHBMo6B3/5aMSGHlJc
         2cK5o0QlR9xXt8m6k2KtgUG/BCYWYR/keFGc3sDgaQ6oQl/OYnCUWqC1dccFCP1NW5P/
         0dppHi1TaYbA73FkSXUScYh9ld0b3saXTi7AbJR7XaboyTOUxBhOeMwkBnUIDBLc46+w
         gq929FNkRE3GrEx7tF1u+6njwKEdGlxWIPhG88SBzGlDLSeiCdfw4pPhzGzLOTJeqljF
         uNwx37PGTrDOiWu53dhp4DsvBL0g5ykwCjo75C+UaxbrqIyD731Kz9u6ntnJf5ypalgy
         tGGQ==
X-Received: by 10.42.95.147 with SMTP id f19mr8555432icn.24.1366393853668;
        Fri, 19 Apr 2013 10:50:53 -0700 (PDT)
Received: from localhost (mb95036d0.tmodns.net. [208.54.80.185])
        by mx.google.com with ESMTPS id s8sm4154399igs.0.2013.04.19.10.50.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 10:50:53 -0700 (PDT)
In-Reply-To: <20130419173717.GA26964@sigill.intra.peff.net>
User-Agent: Notmuch/0.15.2+78~g5404ac5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221786>

Jeff King <peff@peff.net> writes:

> Try "git branch --merged master" to get a list of branches that have
> already been merged.

That's what I use, but I was hoping for something more precise.  For
example, a branch that started at 'maint' would show up there, but its
integration hasn't completed until it makes it back to 'maint'.
