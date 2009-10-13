From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: backup git repo on every commit
Date: Tue, 13 Oct 2009 11:18:43 -0700
Message-ID: <20091013181843.GZ9261@spearce.org>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com> <20091012141544.GF9261@spearce.org> <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com> <20091012143043.GJ9261@spearce.org> <194a2c240910130943j40c12902o760e463e7a8ce8fa@mail.gmail.com> <20091013174913.GV9261@spearce.org> <194a2c240910131108h10acbacdy68306c9c3389517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Israel Garcia <igalvarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxm3G-0006Ju-L6
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934019AbZJMSTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934017AbZJMSTU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:19:20 -0400
Received: from george.spearce.org ([209.20.77.23]:60435 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984AbZJMSTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:19:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AAA6C381FF; Tue, 13 Oct 2009 18:18:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <194a2c240910131108h10acbacdy68306c9c3389517@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130174>

Israel Garcia <igalvarez@gmail.com> wrote:
> Thanks for your answer,  could you please put here how you think
> post-update file should be setup? Remember in my case I want to backup
> every repo to /backups/git folder for example.

Exactly the same as that post-commit I mentioned, just call the
file .git/hooks/post-update instead.

-- 
Shawn.
