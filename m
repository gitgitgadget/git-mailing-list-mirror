From: Len Brown <len.brown@intel.com>
Subject: needs merge
Date: Sat, 7 Jan 2006 03:32:36 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200601070332.36654.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 07 09:32:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9VD-0006Yi-GT
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWAGIcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWAGIcl
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:32:41 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:42661 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030356AbWAGIck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 03:32:40 -0500
Received: from intel.com (c-24-63-232-79.hsd1.ma.comcast.net[24.63.232.79])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2006010708324001400q8msge>; Sat, 7 Jan 2006 08:32:40 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14242>

a merge results in multiple conflict files.

some of the files are resolved by editing and picking changes from both branches.

but some files I want to ignore the new changes and keep what was originally there.
However, if I restore what was originally in the destination
either by editing the destination and ending up with what i started with,
or via git checkout on the file, i get

$ git commit
my-file needs merge

how do i tell git that there is no merge to do and the (unchanged) working file is what
i want to keep as the result of the merge?

i recall running into this a long time ago and i added blank line to the destination file
and that made git happy, but maybe i shouldn't have to resort to that, yes?

thanks,
-Len
