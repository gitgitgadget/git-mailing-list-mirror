From: Mike Hommey <mh@glandium.org>
Subject: Re: MKCOL fails, 403 error
Date: Sun, 3 Feb 2008 16:35:38 +0100
Organization: glandium.org
Message-ID: <20080203153538.GA17980@glandium.org>
References: <eae1aef50802030535u1402471fh182a230f3e0667ea@mail.gmail.com> <eae1aef50802030539l14287c7exa914696755e7ade4@mail.gmail.com> <20080203143101.GB7946@glandium.org> <eae1aef50802030732s7536dfacufd0aaf41974c85d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz
To: Alan Smith <alanrogersmith@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 16:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLgt3-0000Yq-Is
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 16:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbYBCPfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbYBCPfc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 10:35:32 -0500
Received: from vuizook.err.no ([85.19.215.103]:43715 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbYBCPfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 10:35:31 -0500
Received: from aputeaux-153-1-85-206.w86-205.abo.wanadoo.fr ([86.205.43.206] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JLgtB-0007tz-Oo; Sun, 03 Feb 2008 16:36:19 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JLgsc-0004hs-B1; Sun, 03 Feb 2008 16:35:38 +0100
Content-Disposition: inline
In-Reply-To: <eae1aef50802030732s7536dfacufd0aaf41974c85d6@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72364>

On Sun, Feb 03, 2008 at 10:32:39AM -0500, Alan Smith wrote:
> Mike,
> 
> I do have access to the log at /var/logs/apache2/error_log. What
> should I be looking for?

For whatever error message shows up at the time corresponding to when
the MKCOL request was done. You can grep MKCOL in the access_log to find
out. That might help you understand why the MKCOL fails.

Mike
