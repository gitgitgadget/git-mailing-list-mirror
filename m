From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move gitweb style to gitweb.css
Date: Sat, 17 Jun 2006 19:23:33 -0700
Message-ID: <7vhd2j5hi2.fsf@assigned-by-dhcp.cox.net>
References: <200606171123.56643.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 04:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frmwu-0000HQ-0u
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 04:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFRCXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 22:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWFRCXf
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 22:23:35 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60927 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932069AbWFRCXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 22:23:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618022334.MWJV15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 22:23:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200606171123.56643.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 17 Jun 2006 11:23:56 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22047>

Jakub Narebski <jnareb@gmail.com> writes:

> Move gitweb style from embedded <style> element in gitweb/gitweb.cgi
> to external CSS file gitweb/gitweb.css.
>
> ---
> External CSS file can be downloaded only once and cached.

That's good, but I'm wondering if you dropped this deliberately
or it was just an accident.

> -body {
> -	font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
> -	margin:10px; background-color:#ffffff; color:#000000;
> -}
