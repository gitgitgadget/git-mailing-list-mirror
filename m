From: Mark Blakeney <markb@berlios.de>
Subject: gitk does not show path file list
Date: Tue, 17 Nov 2009 22:09:14 +1000
Message-ID: <33e2b2760911170409q4cbdad8ay83ae5c941bc5ff95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 13:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAMs3-0003a0-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 13:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbZKQMJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 07:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbZKQMJJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 07:09:09 -0500
Received: from mail-px0-f180.google.com ([209.85.216.180]:41072 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbZKQMJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 07:09:08 -0500
Received: by pxi10 with SMTP id 10so1895470pxi.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 04:09:14 -0800 (PST)
Received: by 10.142.3.13 with SMTP id 13mr973687wfc.273.1258459754273; Tue, 17 
	Nov 2009 04:09:14 -0800 (PST)
X-Google-Sender-Auth: 5bacf10ab3aee7ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133088>

gitk takes a path to limit commits to those touching those files.
However, doing "gitk ." does not list any files in the right window
file list when trying to view commits for the current dir (which would
seem to be a common use-case, particularly for me at least). Why is
the affected [subset] of files not shown?

Just seems to be a bug to this newbie, particularly when it does work
as I expect if I do a "cd .." and then "gitk src" where src was my
original dir. I'm using version 1.6.5.3 now but this has existed since
I started with git quite some time ago.
