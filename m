From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] completion: Change "if [...]" to "if test ..." to
	match git convention
Date: Wed, 11 Feb 2009 08:24:32 -0800
Message-ID: <20090211162432.GF30949@spearce.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com> <1234366634-17900-2-git-send-email-ted@tedpavlic.com> <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHuT-00060z-Kd
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbZBKQYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbZBKQYe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:24:34 -0500
Received: from george.spearce.org ([209.20.77.23]:56799 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647AbZBKQYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:24:33 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EE75638210; Wed, 11 Feb 2009 16:24:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109437>

Ted Pavlic <ted@tedpavlic.com> wrote:
> In the single case of:
> 
>     if [...] || [...]
> 
> changed to:
> 
>     if test ... || test ...

NAK.

This script only runs in bash.  bash supports [...].  The
prevailing convention in the script is to use [...].  Only
4 tests inside of __git_ps1 use "test", the rest of the code
is using [...].

I would agree to a test->[...] conversion patch as its fairly small,
but not this one.  Too large, too much code churn, no benefit.
 
-- 
Shawn.
