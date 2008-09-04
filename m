From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: prepare-commit-msg hook and git gui
Date: Thu, 4 Sep 2008 11:38:37 -0700
Message-ID: <20080904183837.GE23708@spearce.org>
References: <48C023C0.10306@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Williams <joshua.williams@qlogic.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 20:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbJl4-0003dw-2j
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 20:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbYIDSik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 14:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757420AbYIDSij
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 14:38:39 -0400
Received: from george.spearce.org ([209.20.77.23]:54292 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbYIDSii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 14:38:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EB00038353; Thu,  4 Sep 2008 18:38:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48C023C0.10306@qlogic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94945>

Joshua Williams <joshua.williams@qlogic.com> wrote:
>
> The commit-msg hook does appear to be run after hitting the
> commit button in git gui and git gui does display the proper
> output from the commit-msg hook.  It appears that this is a
> prepare-commit-msg only issue...

git-gui does not invoke the prepare-commit-msg hook.  So it
cannot display its output for you.

Patches are welcome.  ;-)

-- 
Shawn.
