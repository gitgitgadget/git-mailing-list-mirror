From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4] gitk: Add a "Copy commit summary" command
Date: Thu, 13 Aug 2015 17:37:08 +1000
Message-ID: <20150813073708.GA17652@fergus.ozlabs.ibm.com>
References: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Thu Aug 13 09:52:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPnIu-0005HI-Al
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 09:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbbHMHhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 03:37:51 -0400
Received: from ozlabs.org ([103.22.144.67]:56219 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbbHMHhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 03:37:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E320214027F; Thu, 13 Aug 2015 17:37:48 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275836>

On Sat, Jul 18, 2015 at 01:15:39PM +0200, Beat Bolli wrote:
> When referring to earlier commits in commit messages or other text, one
> of the established formats is
> 
>     <abbrev-sha> ("<summary>", <author-date>)
> 
> Add a "Copy commit summary" command to the context menu that puts this
> text for the currently selected commit on the clipboard. This makes it
> easy for our users to create well-formatted commit references.
> 
> The <abbrev-sha> is produced with the %h format specifier to make it
> unique. Its length can be controlled with the gitk preference
> "Auto-select SHA1 (length)", or, if this preference is set to its
> default value (40), with the Git config setting core.abbrev.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>

Thanks, applied.

Paul.
