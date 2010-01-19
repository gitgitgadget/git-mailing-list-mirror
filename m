From: Adam Megacz <adam@megacz.com>
Subject: Re: "warning: Updating the currently checked out branch may cause confusion" on bare repositories
Date: Tue, 19 Jan 2010 18:55:25 +0000
Organization: Myself
Message-ID: <xuu2my093owy.fsf@nowhere.com>
References: <xuu2ska3doix.fsf@nowhere.com> <20100119062904.GB23212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 19:56:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJFH-0006W0-8p
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 19:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab0ASS4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268Ab0ASS4A
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 13:56:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:54639 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165Ab0ASS4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 13:56:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXJF1-0006QE-Eo
	for git@vger.kernel.org; Tue, 19 Jan 2010 19:55:51 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 19:55:51 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 19:55:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:i9QDCkZI/k/USxKJBo/3dW49m3k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137483>


"Shawn O. Pearce" <spearce@spearce.org> writes:
> That should already be the case.  Did you create the bare repository
> by taking a copy of a non-bare's .git directory?  Check your bare
> repository's config file and see if core.bare = false, if so set
> it to true to signal it really is bare.

Hrm, is there a reason why this is explicitly configured rather than
detected?

I was under the impression that you could create a bare repository by
simply throwing away the working tree and renaming ".git" to any other
name, but I guess I was wrong.

  - a
