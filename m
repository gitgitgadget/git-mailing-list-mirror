From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH try2] Improve error output of git-rebase
Date: Sun, 17 Aug 2008 06:11:35 +0200
Message-ID: <20080817041135.GA23513@leksak.fem-net>
References: <7v1w0ocqow.fsf@gitster.siamese.dyndns.org> <1218945930-29281-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUZed-0007Ob-VC
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbYHQELl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbYHQELl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:11:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:49186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbYHQELk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 00:11:40 -0400
Received: (qmail invoked by alias); 17 Aug 2008 04:11:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 17 Aug 2008 06:11:39 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19DzXoMViFDMZpQ2vHG6UW3k/+MA81DB7eRtEstfq
	2HV8d+N6H200Ev
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KUZc7-0007hL-80; Sun, 17 Aug 2008 06:11:35 +0200
Content-Disposition: inline
In-Reply-To: <1218945930-29281-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92569>

Hi,

Stephan Beyer wrote:
> @@ -285,7 +294,7 @@ else
>  	if test -d "$dotest"
>  	then
>  		die "previous rebase directory $dotest still exists." \
> -			'try git-rebase < --continue | --abort >'
> +			'Try git-rebase (--continue | --abort | --skip)'
				^^
			This should perhaps be dashless. :\

And when "git rebase -m" has been invoked, a conflict occurs and the
user is typing "git rebase", then

	fatal: Needed a single revision
	invalid upstream

shows up again. So the patch does not affect all cases... :|

Regards

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
