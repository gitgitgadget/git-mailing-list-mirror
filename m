From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: Why does diff --binary include content of files being deleted?
Date: Sun, 22 Jun 2008 00:05:36 -0400
Message-ID: <20080622040536.GA10813@lifeintegrity.com>
References: <20080622033454.GA10578@lifeintegrity.com> <20080622035118.GD11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 06:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAGqY-0003uw-0C
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 06:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYFVEFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 00:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbYFVEFi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 00:05:38 -0400
Received: from aeol.lifeintegrity.com ([209.135.157.90]:35538 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFVEFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 00:05:38 -0400
Received: from vent.lifeintegrity.com (pool-71-174-251-18.bstnma.fios.verizon.net [71.174.251.18])
	by submission.lifeintegrity.com (Postfix) with ESMTP id 2DFE9D5C103
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 04:05:37 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id 8912B304366; Sun, 22 Jun 2008 00:05:36 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080622035118.GD11793@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85748>

On 2008-06-21T23:51:18-0400, Shawn O. Pearce wrote:
> In order to apply the diff in reverse we need the old binary data
> in the diff output.  So that's why its larger.

Makes sense, thanks.  In my use case (where I do not need the reverse 
diff) this adds 500+ MB or 43159% overhead.

When I tried to apply the large diff my virtual private server with 512 
MB of memory git apply ran out of memory and died.  Is there any way to 
bound the memory usage of git apply?


/Allan
