From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb problem?
Date: Mon, 01 Mar 2010 23:40:08 -0500
Message-ID: <m3vddfuyjb.fsf@winooski.ccs.neu.edu>
References: <m34ol0wmze.fsf@winooski.ccs.neu.edu>
	<m3bpf8mj5k.fsf@localhost.localdomain>
	<m3zl2suun5.fsf@winooski.ccs.neu.edu>
	<m37hpwma9u.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 05:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmJuQ-0004my-1h
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 05:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab0CBEkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 23:40:22 -0500
Received: from lo.gmane.org ([80.91.229.12]:57093 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab0CBEkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 23:40:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NmJu7-0004bM-WE
	for git@vger.kernel.org; Tue, 02 Mar 2010 05:40:20 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 05:40:19 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 05:40:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:7ubTKxDxWqPwpLJO0yix3UdX0uo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141374>

Jakub Narebski <jnareb@gmail.com> writes:

> BTW. the first line number is in git_cmd invoked (called) from
> git_get_project_config.

(Oh yeah, I forgot about that one, sorry.)

> [...]
>
> The last solution, while requiring most work, has the advantage of
> being able to do override via user (~apache/.gitconfig) or system
> (/etc/gitconfig) gitweb config file.  But I am not sure if it is
> worth it...

Thanks for the fix!  As for the point above, isn't the whole point of
the feature system to do this kind of toplevel configuration possible?
(If so, it sounds like a concrete explanation for why it's not worth
the effort: it only makes it possible to specify the defaults in a
toplevel .gitconfig file, which could be nice but probably confusing.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
