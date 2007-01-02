From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: www.kernel.org/git
Date: Tue, 2 Jan 2007 19:59:02 +0000
Message-ID: <20070102195902.GB7710@localhost>
References: <459A05F7.4060405@gmail.com> <46a038f90701012325w3738ddd7l841f017453272aa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	warthog19@eaglescrag.net
X-From: git-owner@vger.kernel.org Tue Jan 02 20:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pn9-0000vz-RN
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbXABT7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbXABT7T
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:59:19 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:49595 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbXABT7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:59:18 -0500
Received: from 213-202-135-13.bas502.dsl.esat.net ([213.202.135.13] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H1pmh-0005MV-Iu; Tue, 02 Jan 2007 19:58:55 +0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90701012325w3738ddd7l841f017453272aa3@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35809>

> Which URLs are failing for you?

The url is correct but it should only be displayed and not be a
clickable link.

Also can I suggest that the link be moved to the summary page, it really
messes up the look of the project_list action page.

> This does look broken... I'll see if I can find out more.

It's broken because the search action page still prints it's output
instead of concatenating the output to a string and returning the string
in gitweb/gitweb/search.pm.

Robert
