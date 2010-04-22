From: Petr Baudis <pasky@suse.cz>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 13:56:25 +0200
Message-ID: <20100422115625.GJ3563@machine.or.cz>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aghiles <aghilesk@gmail.com>, git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 13:56:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4v1F-0001TI-Uf
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 13:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0DVL41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 07:56:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40382 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320Ab0DVL40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 07:56:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3492A125A114; Thu, 22 Apr 2010 13:56:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100421221953.GA25348@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145523>

On Wed, Apr 21, 2010 at 05:19:54PM -0500, Jonathan Nieder wrote:
> Aghiles wrote:
> 
> > "fatal: The remote end hung up unexpectedly"
> > 
> > Is that really meaningful ? Or maybe it is a configuration problem
> > on my side ?
> 
> Please, fix it. :)

I have seen a lot of users who plainly had a lot of trouble even
_understanding_ the error message - it is phrased in super-dense
networking jargon. I think something like

	"fatal: Server terminated the connection for unknown reason"

might come a long way (though of course specific error messages would
still be far more helpful).

(I assume that the remote end is the server since (i) it is most often
the case (ii) it is if you look at it through the client-server optics,
which may not always be the best one, but see (i).)

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
