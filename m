From: Miles Bader <miles@gnu.org>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Sat, 31 Jul 2010 14:41:40 +0900
Message-ID: <87zkx8cinf.fsf@catnip.gol.com>
References: <i308gl$v6p$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 07:42:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of4ph-0000rq-AN
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 07:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab0GaFmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 01:42:00 -0400
Received: from lo.gmane.org ([80.91.229.12]:45365 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab0GaFl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 01:41:59 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Of4pR-0000nr-N2
	for git@vger.kernel.org; Sat, 31 Jul 2010 07:41:49 +0200
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:41:49 +0200
Received: from miles by 218.231.154.125.eo.eaccess.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:41:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 218.231.154.125.eo.eaccess.ne.jp
System-Type: x86_64-unknown-linux-gnu
Cancel-Lock: sha1:+RruvIPqasXy+tTVhxyQWYdzFC4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152304>

Walter Bright <boost@digitalmars.com> writes:
> I've just started with git. Exactly what do I put in $HOME/.gitconfig ?

+ your personal info (user.*)

+ various global personal preferences for tool operation
  (diff.renames, branch.autosetupmerge, apply.whitespace)

+ core.excludesfile = ~/.gitignore

  ... then in ~/.gitignore, put filenames to ignore that are related to
  your personal habits or tool preferences rather than any particular
  project (e.g., "*~" if you use emacs; I also put ",*" because I use
  that pattern for scratch files)

+ command aliases (alias.*)

-miles

-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
