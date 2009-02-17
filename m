From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Mon, 16 Feb 2009 17:12:56 -0800
Message-ID: <20090217011256.GA23314@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 02:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEXY-0005Kz-MS
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 02:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbZBQBM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 20:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbZBQBM5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 20:12:57 -0500
Received: from george.spearce.org ([209.20.77.23]:60016 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZBQBM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 20:12:56 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 32EA6381FF; Tue, 17 Feb 2009 01:12:56 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110288>

Gerrit is a web based code review system, facilitating online code
reviews for projects using the Git version control system.

Gerrit makes reviews easier by showing changes in a side-by-side
display, and allowing inline comments to be added by any reviewer.

Gerrit simplifies Git based project maintainership by permitting
any authorized user to submit changes to the master Git repository,
rather than requiring all approved changes to be merged in by
hand by the project maintainer.  This functionality enables a more
centralized usage of Git.

Gerrit 2.x and later run in any standard Java servlet container,
and includes an embedded SSH daemon, providing gitosis like group
security and data access.  If desired, the review process can be
skipped by directly pushing branches/tags, if the necessary access
has been granted to the user.

The last time I announced Gerrit on this list, it only ran on
Google App Engine.  Gerrit 2.x and later is designed to run in
any environment, without requiring the use of a Google product,
or network connectivity to the Internet.  This makes it much more
suited for corporate deployments, or open source projects which
already have their own servers.

Currently, Gerrit is under very active development, with stable
releases being made about once per week.  As such, I won't be
announcing future releases here very often.

For more information:

  Homepage:   http://code.google.com/p/gerrit/
  Live Demo:  http://review.source.android.com/open
  Source:     git://android.git.kernel.org/tools/gerrit.git
              (but see http://code.google.com/p/gerrit/wiki/Source?tm=4)

-- 
Shawn.
