From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 3/7] Documentation: git-init: template directory: reword
Date: Tue, 5 Aug 2014 22:15:18 -0700
Message-ID: <20140806051517.GB12559@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-4-git-send-email-linusarver@gmail.com>
 <xmqqmwbioaeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:15:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtZQ-0004MT-4X
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 07:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbaHFFPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 01:15:24 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:47050 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbaHFFPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 01:15:23 -0400
Received: by mail-yh0-f44.google.com with SMTP id f73so1392368yha.17
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ki4a8+WZCHcI7Cd1s8T3I0b4BbotxEhLzlF7Bw9huEc=;
        b=bM1GXERnMe1yHDE/6naPh+xQJbz+qAY6G4yCGsZW59ONaSQbF/SsVTHITdW1u/N1WA
         vNq/STR/pi55aPd/lxzW9LKNICKcw987YPAe0g/yavwyqi6aHNZiGzOG+w9V7bjzXiGj
         Oj71IImEq+x4GYZnHF3HHUs9x/ji1FtsYE+QXUO8oCbhwc2WdW/reMTrvpccfXznGjn/
         wnH+yNCiPTB7t45Ub4B9TyEFxgemaTijEECyxRGbQhtYnzGzczYL0INBzna0qVpSck3f
         X7n5jukme2LiOG8xQcUantcDKnbWgyZu89HpxDPRE9DUB89oivYr2deq/ucVucw1hmYQ
         G8Dg==
X-Received: by 10.236.131.109 with SMTP id l73mr12980709yhi.96.1407302122433;
        Tue, 05 Aug 2014 22:15:22 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id z45sm6820466yhb.54.2014.08.05.22.15.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Aug 2014 22:15:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmwbioaeh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254843>

On Tue, Aug 05, 2014 at 03:10:30PM -0700, Junio C Hamano wrote:
> Linus Arver <linusarver@gmail.com> writes:
> 
> > Signed-off-by: Linus Arver <linusarver@gmail.com>
> > ---
> 
> This seems to reword and also reformat at the same time, but was the
> latter change (i.e. to unindent the bulletted items and to remove
> blank lines between items) necessary?

No, the unindenting/removal of blank lines is a non-grammar change and
is not necessary, as it doesn't have any effect on the actual output
(html/txt/manpage).

I can either keep the same coding style with the rewording, or chop this
into two commits, one for the rewording and another for reformatting.
Which one do you suggest?

> >  Documentation/git-init.txt | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> > index 45501d0..f21b85b 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -113,22 +113,18 @@ line, the command is run inside the directory (possibly after creating it).
> >  
> >  --
> >  
> > -
> >  TEMPLATE DIRECTORY
> >  ------------------
> >  
> >  The template directory contains files and directories that will be copied to
> >  the `$GIT_DIR` after it is created.
> >  
> > -The template directory used will be (in order):
> > -
> > - - The argument given with the `--template` option.
> > -
> > - - The contents of the `$GIT_TEMPLATE_DIR` environment variable.
> > -
> > - - The `init.templatedir` configuration variable.
> > +The template directory will be one of the following (in order):
> >  
> > - - The default template directory: `/usr/share/git-core/templates`.
> > +- the argument given with the `--template` option;
> > +- the contents of the `$GIT_TEMPLATE_DIR` environment variable;
> > +- the `init.templatedir` configuration variable; or
> > +- the default template directory: `/usr/share/git-core/templates`.
> >  
> >  The default template directory includes some directory structure, some
> >  suggested "exclude patterns", and copies of sample "hook" files.
