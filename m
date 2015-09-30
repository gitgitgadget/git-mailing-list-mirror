From: Peter Vasil <peter.vasil@posteo.de>
Subject: gitk crashes with german translation
Date: Wed, 30 Sep 2015 09:58:14 +0000 (UTC)
Message-ID: <loom.20150930T115122-885@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 12:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhEEo-0004k6-UH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 12:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbbI3KDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 06:03:39 -0400
Received: from plane.gmane.org ([80.91.229.3]:54889 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200AbbI3KAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 06:00:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZhEB9-0001QT-EB
	for git@vger.kernel.org; Wed, 30 Sep 2015 12:00:04 +0200
Received: from 46.231.181.198 ([46.231.181.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:00:03 +0200
Received: from peter.vasil by 46.231.181.198 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 46.231.181.198 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.42 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278844>

Hi list,

When I try to run "gitk --all" on Mac with German language settings I get
the following error:

Error in startup script: bad menu entry index "Ansicht bearbeiten ..."
    while executing
".bar.view entryconf [mca "Edit view..."] -state normal"
    invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
    # create a view for the files/dirs specified on the command line
    se..."
    (file "/usr/local/bin/gitk" line 12442)

I use git version 2.6.0

If I remove the folder with translations in order to use the english version,
 gitk does not crash.

Cheers,
Peter
