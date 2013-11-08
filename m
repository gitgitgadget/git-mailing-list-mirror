From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: Selectively commit/publish files to GIT
Date: Fri, 08 Nov 2013 17:50:10 -0600
Message-ID: <87fvr6cv2l.fsf@gmail.com>
References: <CA+PenvEDY6mc+DyjXy4ebZKdK4R=ucM28MDXGC42XKxvJ=a-pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 00:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vevou-0002TT-OH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 00:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab3KHXu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 18:50:28 -0500
Received: from plane.gmane.org ([80.91.229.3]:35484 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757595Ab3KHXu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 18:50:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vevol-0002Gd-IT
	for git@vger.kernel.org; Sat, 09 Nov 2013 00:50:23 +0100
Received: from nat-128-62-53-203.public.utexas.edu ([128.62.53.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Nov 2013 00:50:23 +0100
Received: from keshav.kini by nat-128-62-53-203.public.utexas.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Nov 2013 00:50:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-128-62-53-203.public.utexas.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:CewBRDgtaKNC7h5csCc4YTylRVU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237474>

Thomas Manson <dev.mansonthomas@gmail.com> writes:
>   The problem is that in Bazaar, I've commited some big files (63MB &
> 173MB), but this files are no longer in my project, only in the
> revisions files of Bazaar and now Git.
>
>   I don't need this files to be pushed on Github.
>
>   How can I search git history for big files and remove them, or mark
> them to be not published ?

I see you already solved your problem, but for future reference, there
is a nice tool that is more limited in functionality than git
filter-branch but also much faster and possibly easier to use:

    http://rtyley.github.io/bfg-repo-cleaner/

-Keshav
