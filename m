From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Using repo to work with multiple GIT repositories
Date: Mon, 8 Dec 2008 08:23:40 -0800
Message-ID: <20081208162340.GE31551@spearce.org>
References: <ece1079f0812050320n7191097sbc1c10c353b23708@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kanagesh radhakrishnan <rkanagesh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9iuo-0004Cd-6w
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbYLHQXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbYLHQXl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:23:41 -0500
Received: from george.spearce.org ([209.20.77.23]:46382 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbYLHQXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:23:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5508738200; Mon,  8 Dec 2008 16:23:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ece1079f0812050320n7191097sbc1c10c353b23708@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102551>

kanagesh radhakrishnan <rkanagesh@gmail.com> wrote:
> 
> My work currently resides in four different source trees, namely:
> 
>    * bootloaders   (git://192.168.10.1/bootloaders)
>    * kernel           (git://192.168.10.1/kernel)
>    * applications  (git://192.168.10.1/apps)
>    * build             (git://192.168.10.1/build)
> 
> I maintain them as four different git repositories.  They are hosted
> on a local server enabling any other developer to be able to clone
> from one of the trees, make changes, commit locally and then push to
> the git server.
> 
> I was browsing through the Android source code and found that they
> have a similar situation where code is maintained in a large number of
> independent GIT repositories.  The tool 'repo' is being used to
> initialize and sync each tree.

FWIW this was cross-posted to repo-discuss, which is possibly
better suited to discussion about "repo".  :-)

I posted my answer there this morning:

http://groups.google.com/group/repo-discuss/browse_thread/thread/67fdbba9619084

-- 
Shawn.
