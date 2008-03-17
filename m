From: David Brown <git@davidb.org>
Subject: Excessive memory consumption.
Date: Mon, 17 Mar 2008 08:43:53 -0700
Message-ID: <20080317154353.GA9062@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 16:44:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbHVv-0003T7-GI
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYCQPnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbYCQPny
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:43:54 -0400
Received: from mail.davidb.org ([66.93.32.219]:47853 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbYCQPny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:43:54 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1JbHVB-0002TG-HL
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:43:53 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77442>

I'm working with a repository containing a large number of revisions (it
has the full 2.6 kernel history) along with a bunch of large tarfiles of
prebuilt images (basically firmware images).  These tarfiles are about 50MB
and are updated frequently.

I'm trying to figure out how to limit memory consumption when fetching from
this repo.  The repo lives on a network drive, and during the

   "remote: Compressing objects: ..."

phase, git-pack-objects quickly grows to 3 or more GB in size.  I've tried
setting  pack.windowMemory = 512m, and pack.deltaCacheLimit = 512m.  Any
other suggested things to try?

This is running 1.5.4.3.

Thanks,
David
