From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git-* in hook scripts
Date: Thu, 25 Feb 2010 02:15:05 -0500
Message-ID: <m38wahwzuu.fsf@winooski.ccs.neu.edu>
References: <m3hbp7x673.fsf@winooski.ccs.neu.edu>
	<20100223235941.GG12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 08:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkXwT-0005KJ-QY
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 08:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab0BYHPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 02:15:19 -0500
Received: from lo.gmane.org ([80.91.229.12]:40867 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab0BYHPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 02:15:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NkXwK-0005Go-AG
	for git@vger.kernel.org; Thu, 25 Feb 2010 08:15:16 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 08:15:16 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 08:15:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:bmyndV0fjF7fwr4ha+Ev/vLTLxs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141031>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Feb 23, 2010 at 11:33:36AM -0500, Eli Barzilay <eli@barzilay.org> wrote:
>> There are several sample hook scripts that use `git-*' -- should
>> these use `git *' instead?
>
> No need to do so, `git --exec-path` is already in PATH when those
> scripts are invoked.

To make this a little more concrete, I was thinking about the fact
that `git cmd' can be different from `git-cmd' if I add a file with
the second name for one of the builtin commands.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
