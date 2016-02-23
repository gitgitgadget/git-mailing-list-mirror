From: Seb <spluque@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Tue, 23 Feb 2016 17:05:37 -0600
Organization: Church of Emacs
Message-ID: <87egc358ou.fsf@gmail.com>
References: <87io1j6laz.fsf@gmail.com> <56C91D21.90306@moritzneeb.de>
	<87io1f5nsi.fsf@gmail.com> <56CCE3C2.1050608@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYM1e-0007hQ-Du
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbcBWXFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:05:47 -0500
Received: from plane.gmane.org ([80.91.229.3]:53910 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbcBWXFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:05:46 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aYM1Y-0007bG-5o
	for git@vger.kernel.org; Wed, 24 Feb 2016 00:05:44 +0100
Received: from s0106503955564c1f.wp.shawcable.net ([24.77.8.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 00:05:44 +0100
Received: from spluque by s0106503955564c1f.wp.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 00:05:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s0106503955564c1f.wp.shawcable.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:el0ZeV8/ypSt5u3d/2YW/Ic6e6s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287140>

On Tue, 23 Feb 2016 23:57:06 +0100,
Moritz Neeb <lists@moritzneeb.de> wrote:

[...]

>> OK, I've followed this advice and looked at the dependency graphs in
>> gitk before and after rebasing, I've managed to obtain what I was
>> after.  The repository now has two branches: master and topic.
>> However, Gitk reveals a problem with a string of commits that are not
>> part of any branch:

>> A---B---H---I (master) \ C---D---E (loose string of commits) \
>> D'---E'---F---G (topic)

>> How do I remove these loose commits (C, D, E)?


> what you might be after is "git gc". But I never used it, it was not
> neccesary for me. I would let the automatic garbage collection drop my
> dangling commits. It's safer - who knows when you will still want to
> restore your recent "loose string of commits".

> How exactly are the loose commits causing trouble?

Sure enough, these dangling commits were removed automatically without
any intervention.  All is good.

Thanks!

-- 
Seb
