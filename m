From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Mon, 16 Apr 2012 15:08:31 -0500
Message-ID: <nng3983phhc.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Namit Bhalla <namitbhalla@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsE9-00024s-O5
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab2DPUIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:08:41 -0400
Received: from exprod6og110.obsmtp.com ([64.18.1.25]:34961 "EHLO
	exprod6og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2DPUIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:08:40 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob110.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT4x8Rf7rplBZaS7u198XzqCp2L/0GdrK@postini.com; Mon, 16 Apr 2012 13:08:40 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Apr
 2012 15:08:35 -0500
In-Reply-To: <m3hawjagw9.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Mon, 16 Apr 2012 07:30:17 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195684>

Jakub Narebski <jnareb@gmail.com> writes:

> Put reusable library in its own repository, and use submodules to link
> it up to project-a and project-b repositories.

git-subtree is another option.  It was recently merged into contrib/.
Whether to use submodules or subtrees largely depends on the work style
of your group and how coupled the projects are to each other.
submodules requires a bit more day-to-day maintenance by the user (in my
experience) while with subtrees it's a bit more involved to push changes
from the combined repository back to the separate repositories.

                              -Dave
