From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Wed, 2 Apr 2014 22:04:09 +0200
Message-ID: <20140402200409.GA9984@sandbox-ub>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Ronald Weiss <weiss.ronald@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:57:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeVg-000348-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbaDBUEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 16:04:23 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:60824 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709AbaDBUEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 16:04:22 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WVROV-0001jF-44; Wed, 02 Apr 2014 22:04:19 +0200
Content-Disposition: inline
In-Reply-To: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245702>

On Mon, Mar 31, 2014 at 05:29:03PM -0700, Junio C Hamano wrote:
> * hv/submodule-ignore-fix (2013-12-06) 4 commits
>  - disable complete ignorance of submodules for index <-> HEAD diff
>  - always show committed submodules in summary after commit
>  - teach add -f option for ignored submodules
>  - fix 'git add' to skip submodules configured as ignored
> 
>  Teach "git add" to be consistent with "git status" when changes to
>  submodules are set to be ignored, to avoid surprises after checking
>  with "git status" to see there isn't any change to be further added
>  and then see that "git add ." adds changes to them.
> 
>  I think a reroll is coming, so this may need to be replaced, but I
>  needed some practice with heavy conflict resolution.  It conflicts
>  with two changes to "git add" that have been scheduled for Git 2.0
>  quite badly, and I think I got the resolution right this time.
> 
>  Waiting for a reroll.

Since Ronald and Jens picked up this topic[1], I think you can discard
my series.

Cheers Heiko

[1] http://thread.gmane.org/gmane.comp.version-control.git/245341
