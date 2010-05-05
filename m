From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/3] Teach Girocco to mirror http:// style SVN repos
Date: Wed, 5 May 2010 20:54:09 +0200
Message-ID: <20100505185409.GV11185@machine.or.cz>
References: <cover.1269255835.git.kirr@mns.spb.ru>
 <b7d25a4325c26bed2351257521878109b71ad771.1269255835.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, admin@repo.or.cz
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed May 05 20:54:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9jjn-00079M-LN
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 20:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0EESyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 14:54:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54407 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab0EESyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 14:54:13 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 04939125A0EA; Wed,  5 May 2010 20:54:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b7d25a4325c26bed2351257521878109b71ad771.1269255835.git.kirr@mns.spb.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146413>

On Mon, Mar 22, 2010 at 02:08:01PM +0300, Kirill Smelkov wrote:
> From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> 
> Currently we can mirror svn:// repos, but http:// is assumed to be used
> for Git. Teach the tool to use svn+http:// style urls for http:// svn
> repositories.
> 
> This is very needed, because most SVN hosting services only provide
> http:// style access to their services. e.g. google code, python.org,
> etc...
> 
> This has not been tested on full Girocco installation - just partly. But
> if it works, let's also add svn+https later.

Thanks, applied.

(BTW, it would be much better if you sent patches to admin@repo.or.cz
instead. At least in theory - if anyone is interested helping out with
various rather badly needed repo.or.cz tasks
[http://repo.or.cz/w/girocco.git/blob/rorcz:/TODO], please let me know
and I will give you some admin permissions.)

-- 
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
