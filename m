From: Jeroen van der Ham <vdham@uva.nl>
Subject: Deprecated help message
Date: Tue, 6 Nov 2012 10:44:12 +0100
Message-ID: <00F68AED-5D59-44F2-B0F1-E541881BC2CB@uva.nl>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 10:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVfrc-0001MW-Q8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 10:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2KFJyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 04:54:18 -0500
Received: from positron.soleus.nu ([94.142.246.99]:17298 "EHLO
	positron.soleus.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2KFJyQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2012 04:54:16 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2012 04:54:16 EST
Received: from doc.dckd.nl (doc.dckd.nl [145.99.178.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by positron.soleus.nu (Postfix) with ESMTPSA id 8E5EEF8088
	for <git@vger.kernel.org>; Tue,  6 Nov 2012 10:44:12 +0100 (CET)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209105>

Hi,

It seems I hit a deprecated help message:

% git pull
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream nsiv2 origin/<branch>

% git branch --set-upstream nsiv2 origin/nsiv2
The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
Branch nsiv2 set up to track remote branch nsiv2 from origin.

Jeroen.
