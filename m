From: Sean <seanlkml@sympatico.ca>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 00:38:36 -0500
Message-ID: <BAYC1-PASMTP0989BAD99482FD877540CBAE2F0@CEZ.ICE>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 06:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNLx5-0006zc-RM
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 06:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYBHFie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 00:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYBHFie
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 00:38:34 -0500
Received: from bay0-omc2-s41.bay0.hotmail.com ([65.54.246.177]:28746 "EHLO
	bay0-omc2-s41.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961AbYBHFid (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 00:38:33 -0500
Received: from BAYC1-PASMTP09 ([65.54.191.182]) by bay0-omc2-s41.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Feb 2008 21:38:32 -0800
X-Originating-IP: [74.14.66.77]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.14.66.77]) by BAYC1-PASMTP09.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 7 Feb 2008 21:38:32 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JNMsP-0005mF-5r; Fri, 08 Feb 2008 01:38:21 -0500
In-Reply-To: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.7; i686-pc-linux-gnu)
X-OriginalArrivalTime: 08 Feb 2008 05:38:32.0821 (UTC) FILETIME=[D78BC250:01C86A14]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73041>

On Fri, 8 Feb 2008 17:44:12 +1300
"Martin Langhoff" <martin.langhoff@gmail.com> wrote:

> This means that beyond the branches I actively work on, I also have
> local tracking branches for remote heads that I am not updating. When
> I say git push, these stale local tracking branches are making a lot
> of noise in the output:

There may be other workflows where the noise in the output is appropriate.
What about using "git push origin HEAD" (or an alias for it) to push only
the branch you have checked out and avoid noise for other branches?

Sean
