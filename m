From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Girocco hosting infrastructure v1.0
Date: Wed, 11 Nov 2009 12:30:51 +0100
Message-ID: <20091111113051.GH12890@machine.or.cz>
References: <20091110104027.GI17748@machine.or.cz>
 <4AFA9A1E.5050107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 12:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8BPl-0001WZ-U8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 12:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbZKKLau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 06:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbZKKLau
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 06:30:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40145 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbZKKLat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 06:30:49 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 082A6862020; Wed, 11 Nov 2009 12:30:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AFA9A1E.5050107@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132641>

On Wed, Nov 11, 2009 at 12:03:58PM +0100, Michael J Gruber wrote:
> How does the svn mirroring work? Do I simply enter a svn:// url for
> "Anywhere"? Is it always standard layout (git svn clone -s)?
> Can I specify an authors file?

Yes, you simply enter a svn:// URL (http:// URLs are currently not
supported), it is always standard layout, no you can't specify an
authors file.

The support is only very basic, if you want anything better, please
send me a patch. :-)

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
