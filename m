From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 1/7] .git directory should be ignored
Date: Sun, 04 Mar 2007 23:02:46 +0100
Message-ID: <877itwu0op.fsf@wine.dyndns.org>
References: <15268.1172917083@localhost>
	<7vzm6u7zle.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:02:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNyn8-0005UI-As
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbXCDWCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbXCDWCv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:02:51 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:43257 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXCDWCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:02:50 -0500
Received: from adsl-89-217-0-36.adslplus.ch ([89.217.0.36] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HNyn3-0006Vu-Kr; Sun, 04 Mar 2007 16:02:50 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0F3944F691; Sun,  4 Mar 2007 23:02:47 +0100 (CET)
In-Reply-To: <7vzm6u7zle.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 03 Mar 2007 14\:05\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41374>

Junio C Hamano <junkio@cox.net> writes:

> I am no Emacs vc expert to judge, but I wonder if it is kosher
> to muck with that global variable from a vc backend.
>
> The above does mirror what pcl-cvs does for "CVS/" but I notice
> that vc-cvs.el does not do so, neither vc-rcs.el excludes
> "RCS/".

Yes, I think if we really want to do this, it should be done in
git.el, not in vc-git.

-- 
Alexandre Julliard
julliard@winehq.org
