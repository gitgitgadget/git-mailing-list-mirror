From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 11/12] documentation: replace Discussion section by
	link to user-manual chapter
Date: Sat, 15 Sep 2007 21:56:06 -0400
Message-ID: <20070916015606.GA5118@fieldses.org>
References: <11893670591013-git-send-email-bfields@citi.umich.edu> <11893670592312-git-send-email-bfields@citi.umich.edu> <11893670593596-git-send-email-bfields@citi.umich.edu> <11893670592701-git-send-email-bfields@citi.umich.edu> <11893670593670-git-send-email-bfields@citi.umich.edu> <1189367060244-git-send-email-bfields@citi.umich.edu> <11893670603146-git-send-email-bfields@citi.umich.edu> <11893670603581-git-send-email-bfields@citi.umich.edu> <11893670601869-git-send-email-bfields@citi.umich.edu> <46E45F45.3040109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Sep 16 03:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWjN7-0005Gu-NI
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 03:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbXIPB4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 21:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXIPB4K
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 21:56:10 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38442 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031AbXIPB4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 21:56:09 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IWjMk-0002NJ-9x; Sat, 15 Sep 2007 21:56:06 -0400
Content-Disposition: inline
In-Reply-To: <46E45F45.3040109@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58291>

On Sun, Sep 09, 2007 at 11:01:57PM +0200, Andreas Ericsson wrote:
> J. Bruce Fields wrote:
>> +
>> +A git project normally consists of a working directory with a ".git"
>> +subdirectory at the top level.  The .git directory contains, among other
>> +things, a compressed object database representing the complete history
>> +of the project, a set of pointers into that history ("refs")
>
> ... into that history ("refs" - branches and tags)

I slept on it and took another look, and decided you were right; this is
what I have there now:
 
  A git project normally consists of a working directory with a ".git"
  subdirectory at the top level.  The .git directory contains, among
  other things, a compressed object database representing the complete
  history of the project, an "index" file which links that history to
  the current contents of the working tree, and named pointers into that
  history such as tags and branch heads.
 
--b.
