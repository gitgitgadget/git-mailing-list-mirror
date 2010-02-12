From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH 4/7] Documentation: merge: add an overview
Date: Fri, 12 Feb 2010 19:45:11 +0530
Message-ID: <87zl3ey1zk.fsf@hariville.hurrynot.org>
References: <20100123092551.GA7571@progeny.tock>
	<20100123094246.GE7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 15:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfwfm-0007VX-IB
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 15:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab0BLOjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 09:39:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:59607 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab0BLOjB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 09:39:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nfwfa-0007NU-19
	for git@vger.kernel.org; Fri, 12 Feb 2010 15:38:58 +0100
Received: from 117.192.134.243 ([117.192.134.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 15:38:57 +0100
Received: from harinath by 117.192.134.243 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 15:38:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.134.243
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.92 (gnu/linux)
Cancel-Lock: sha1:gU7Kw1Xg9fPUe8MXm5OTt2u2cO8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139712>

Hi,

Jonathan Nieder <jrnieder@gmail.com> writes:
[snip]
> +Assume the following history exists and the current branch is
> +"`master`":
> +
> +------------
> +          A---B---C topic
> +         /
> +    D---E---F---G master
> +------------
> +
> +Then "`git merge topic`" will replay the changes made on the
> +`topic` branch since it diverged from `master` (i.e., `E`) until
> +its current commit (`C`) on top of `master`, and record the result
> +in a new commit along with the names of the two parent commits and
> +a log message from the user describing the changes.

The word 'replay' seems inappropriate for a description of 'merge'.  To
me 'replay' seems a synonym of 'rebase' (and IIRC tla has a 'replay'
command that was similar to 'rebase' [1]).

(Yeah, I know, I'm responding 3 weeks too late, and the patch is already
in the tree.)

- Hari

[1] http://www.gnu.org/software/gnu-arch/tutorial/Introducing-replay-_002d_002d-An-Alternative-to-update.html
