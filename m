From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] gitweb: Create install target for gitweb in
 Makefile
Date: Wed, 12 May 2010 01:45:58 +0200
Message-ID: <20100511234558.GP3563@machine.or.cz>
References: <20100429235046.29606.35311.stgit@localhost.localdomain>
 <7vbpcz4d95.fsf@alter.siamese.dyndns.org>
 <201005012236.16703.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 01:46:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBz9P-0003op-2h
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 01:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab0EKXqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 19:46:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60382 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab0EKXqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 19:46:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 833EF125A0EA; Wed, 12 May 2010 01:45:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005012236.16703.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146913>

On Sat, May 01, 2010 at 10:36:15PM +0200, Jakub Narebski wrote:
> Subject: [PATCHv2] gitweb: Create install target for gitweb in Makefile
> 
> Installing gitweb is now as easy as
> 
>   # make gitwebdir=/var/www/cgi-bin gitweb-install  ;# as root
> 
> The gitweb/INSTALL file was updated accordingly, to make use of this
> new target.
> 
> Fix shell quoting, i.e. setting bindir_SQ etc., in gitweb/Makefile.
> Those variables were not used previously.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>
