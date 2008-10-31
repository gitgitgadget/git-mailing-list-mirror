From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: libgit2 - a true git library
Date: Fri, 31 Oct 2008 10:07:04 -0700
Message-ID: <20081031170704.GU14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 18:08:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxTw-0006vK-O8
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 18:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbYJaRHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 13:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYJaRHH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 13:07:07 -0400
Received: from george.spearce.org ([209.20.77.23]:36012 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYJaRHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 13:07:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0466638360; Fri, 31 Oct 2008 17:07:04 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99608>

During the GitTogether we were kicking around the idea of a ground-up
implementation of a Git library.  This may be easier than trying
to grind down git.git into a library, as we aren't tied to any
of the current global state baggage or the current die() based
error handling.

I've started an _extremely_ rough draft.  The code compiles into a
libgit.a but it doesn't even implement what it describes in the API,
let alone a working Git implementation.  Really what I'm trying to
incite here is some discussion on what the API looks like.

API Docs:
http://www.spearce.org/projects/scm/libgit2/apidocs/html/modules.html

Source Code Clone URL:
http://www.spearce.org/projects/scm/libgit2/libgit2.git

-- 
Shawn.
