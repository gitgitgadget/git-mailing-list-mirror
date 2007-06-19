From: jimmy bahuleyan <jimmy.cancer@gmail.com>
Subject: git exclude patterns for directory
Date: Wed, 20 Jun 2007 01:38:21 +0530
Message-ID: <20070619200821.GA16423@camelot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 22:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0k0o-0007D5-KZ
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 22:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764358AbXFSUIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764165AbXFSUIb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 16:08:31 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:36584 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764358AbXFSUI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 16:08:29 -0400
Received: by py-out-1112.google.com with SMTP id a29so3968424pyi
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 13:08:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=RDErr1SZjWgc/cutdMdBv23zJcU5pmCNVyecWCMu56ly15PbifTICVd3EUQaK33VCPkvmD7vEClA84Cs+o3L4MTasdrOikO6n94uyFTMdvdySJVRt5wHvI1ZlUt9LNVVrRJAW4OQy21m9oKwZyPSXks6rRfmFhL0KxiS8BqZok0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mBB4o5k9+qt+wp7b84/8tTk/PfmVmPskrMZMqqy4EK+t9sJnMfXMvayrOMQ5f+Gg0kAfJDlEkPxxuCB90xPwZ3zzkhhXbYfed+lweLxLJw4BUGs18ZWdjAbPLURxk2umhyAaTv+s+tSlaySPoIqH6LB0HXbf5BtL9GsYakAC2bc=
Received: by 10.35.91.10 with SMTP id t10mr13246222pyl.1182283708622;
        Tue, 19 Jun 2007 13:08:28 -0700 (PDT)
Received: from localhost ( [122.167.7.167])
        by mx.google.com with ESMTP id f77sm13049580pyh.2007.06.19.13.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2007 13:08:27 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50504>

(Please Cc on replies)

I just started using git (yes, newbie ;) and hit a problem that i cant
seem to solve.

Is there a way where I could specify a pattern in .git/info/exclude that
would make git ignore directories.

Suppose I had in each of my project's sub-directories a directory called
'IGNORE/', how do I make git ignore this directory (and all it's
contents)?

I tried putting in

IGNORE/*

but this only takes care of the directory in the root dir. Then I tried

*/IGNORE/*

which doesn't work for dirs at >1 depth. I did read gitignore man page
(and it looks impossible .. ):

So, is there any way I can do this without adding a gitignore file in
each of my sub-directories?

-jb
-- 
Tact is the art of making a point without making an enemy.
