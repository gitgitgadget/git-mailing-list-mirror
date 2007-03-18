From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 3/5] introduce GIT_WORK_TREE environment variable
Date: Sun, 18 Mar 2007 21:12:09 +0100
Message-ID: <20070318201209.GA1968@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx> <20070317144403.GC26290@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 21:12:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT1jo-0003j7-GV
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 21:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbXCRUMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbXCRUMP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 16:12:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:56429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933094AbXCRUMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 16:12:14 -0400
Received: (qmail invoked by alias); 18 Mar 2007 20:12:12 -0000
X-Provags-ID: V01U2FsdGVkX19gcSQoq8xgGU4U/aYtUU2R46vqQnChV/haClDTEG
	kAI6dERNewFq6h
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317144403.GC26290@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42514>

Matthias Lederhofer <matled@gmx.net> wrote:
> +		inside_working_tree = !prefixcmp(cwd, worktree);
[..]
> +			inside_git_dir = !prefixcmp(cwd, gitdir);

This time a real bug: the parameters have to be the other way around.
