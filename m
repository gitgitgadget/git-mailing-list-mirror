From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH 1/6] gitweb: Hyperlink committags in a commit
 message by regex matching
Date: Wed, 18 Nov 2009 09:26:36 +0100
Message-ID: <20091118082636.GE12890@machine.or.cz>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 09:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAfsA-0005jC-LS
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 09:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbZKRI0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 03:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZKRI0b
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 03:26:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35275 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbZKRI0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 03:26:31 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 888A386201C; Wed, 18 Nov 2009 09:26:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133154>

On Tue, Nov 17, 2009 at 10:22:25PM -0800, Marcel M. Cary wrote:
> +			# Avoid matching punctuation that might immediately follow
> +			# a url, is not part of the url, and is allowed in urls,
> +			# like a full-stop ('.').
> +			'pattern' => qr!(https?|ftps?|git|ssh|ssh+git|sftp|smb|webdavs?|
> +			                 nfs|irc|nntp|rsync)
> +			                ://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
> +			                   [-_a-zA-Z0-9\@/&=+~#<>]!x,

You meant ssh\+git here. ;-)

				Petr "Pasky" Baudis
