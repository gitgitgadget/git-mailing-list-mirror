From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary
 directories
Date: Sun, 15 Jun 2014 14:57:52 +1000
Message-ID: <20140615045752.GF21978@iris.ozlabs.ibm.com>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 06:58:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww2WH-0002wx-OL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 06:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbaFOE6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 00:58:00 -0400
Received: from ozlabs.org ([103.22.144.67]:49820 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaFOE56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 00:57:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9BB4E140091; Sun, 15 Jun 2014 14:57:55 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1402695828-91537-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251665>

On Fri, Jun 13, 2014 at 02:43:48PM -0700, David Aguilar wrote:
> gitk uses a predictable ".gitk-tmp.$PID" pattern when generating
> a temporary directory.
> 
> Use "mktemp -d .gitk-tmp.XXXXXX" to harden gitk against someone
> seeding /tmp with files matching the pid pattern.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>

Thanks, applied.

Paul.
