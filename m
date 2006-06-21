From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Minor gitweb modifications and cleanups
Date: Wed, 21 Jun 2006 02:04:43 -0700
Message-ID: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net>
References: <11508760843417-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 11:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsydj-0004eX-Jx
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWFUJEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFUJEo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:04:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:15548 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751401AbWFUJEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 05:04:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621090444.YSBG19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 05:04:44 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11508760843417-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of =?utf-8?Q?=22=EF=BD=B6ro=2C?= 21 cze 2006 09:48:01
 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22243>

Jakub Narebski <jnareb@gmail.com> writes:

> This series of patches is based on git.git 'next' branch
> 69d830d1a3a1236036bd0f84dd9794d7c8d34b3f
>
> My future gitweb-related batches will be based on this series.
>
> ---
>
>  gitweb/gitweb.cgi |   53 +++++++++++++++++++++++++++++++----------------------
>  gitweb/gitweb.css |    4 ++--
>  2 files changed, 33 insertions(+), 24 deletions(-)
>
> -- 
> Jakub Narebski
> Poland

All three applied cleanly (finally!), but with hand munging of
Date: field.

I think git-send-email should internally do LC_ALL=C or stop
using strftime() or both.
