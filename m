From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 21:31:13 +0300
Message-ID: <20160114213113.c700484c7e3acddc467d0e75@domain007.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: pedro rijo <pedrorijo91@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmmP-0002HN-LX
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599AbcANShu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:37:50 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:57233 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbcANSht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:37:49 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2016 13:37:49 EST
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id u0EIVDvB027661;
	Thu, 14 Jan 2016 21:31:14 +0300
In-Reply-To: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284078>

On Thu, 14 Jan 2016 18:17:48 +0000
pedro rijo <pedrorijo91@gmail.com> wrote:

> If I clone a repo, the repo will be on a specific branch, the 'main'
> (typically 'master') branch.

`git clone` checks out the branch which is pointed by by the HEAD ref in
the source repository.

> Is there any direct command to find that main branch, since that
> information is present?
> 
> If so, is there any way to find it without actually cloning the repo
> (similar to git ls-remote)?

Run `git ls-remote <url>` and, record the SHA1 name of the HEAD ref,
then look that name up in the list of the remaining refs.
