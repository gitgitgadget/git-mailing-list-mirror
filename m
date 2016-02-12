From: Mike Hommey <mh@glandium.org>
Subject: `git rev-parse --git-common-dir` doesn't work in a subdirectory of
 the main work tree
Date: Fri, 12 Feb 2016 12:47:23 +0900
Message-ID: <20160212034723.GA20739@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 04:47:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU4hi-000615-Da
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 04:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbcBLDra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 22:47:30 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57400 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbcBLDr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 22:47:29 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aU4hX-000361-HI
	for git@vger.kernel.org; Fri, 12 Feb 2016 12:47:23 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286037>

Hi,

In a worktree, git rev-parse --git-common-dir returns the non
worktree-specific git directory. e.g. .git instead of
.git/worktrees/name. The problem is that while it returns the right
thing from a subdirectory of a worktree, it doesn't from a subdirectory
of the "main" work tree. In the latter case it returns ".git" instead
of the full path to it.

Mike
