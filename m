From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] vc-git.el: Switch to using git-blame instead of git-annotate.
Date: Thu, 05 Oct 2006 11:52:52 +0200
Message-ID: <87fye39jij.fsf@wine.dyndns.org>
References: <87k63f9kjf.fsf@wine.dyndns.org>
	<7v4pujf6mx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 11:53:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVPuW-00024r-L3
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 11:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWJEJw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWJEJw5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 05:52:57 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:15746 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751577AbWJEJw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 05:52:56 -0400
Received: from adsl-89-217-6-110.adslplus.ch ([89.217.6.110] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GVPuR-0000ul-6P; Thu, 05 Oct 2006 04:52:55 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id DDDFE4F8E1; Thu,  5 Oct 2006 11:52:52 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pujf6mx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 05 Oct 2006 02\:34\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28353>

Junio C Hamano <junkio@cox.net> writes:

> Not that I am preferring the annotate output format over blame's
> native output format.  I just wanted to know if the reason you
> did not do -c was because you tried and "blame -c" was not
> compatible as advertised (in which case we have one more thing
> to fix).

As far as I can tell, "blame -c" works fine. I switched because I find
the default blame output nicer, it wastes less horizontal space and
the file contents are properly aligned.

-- 
Alexandre Julliard
julliard@winehq.org
