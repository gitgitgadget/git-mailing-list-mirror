From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: contrib/ area
Date: Sat, 18 Feb 2006 17:49:33 +0100
Message-ID: <87r760k3xe.fsf@wine.dyndns.org>
References: <7vmzgq451m.fsf@assigned-by-dhcp.cox.net>
	<873biikx6k.fsf@wine.dyndns.org>
	<7vu0axupnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 17:49:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAVHD-0005l6-UV
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 17:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWBRQtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 11:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWBRQtk
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 11:49:40 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:50908 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751419AbWBRQtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 11:49:39 -0500
Received: from adsl-84-226-98-136.adslplus.ch ([84.226.98.136] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FAVH5-0004VP-VR; Sat, 18 Feb 2006 10:49:38 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 2D2094F929; Sat, 18 Feb 2006 17:49:33 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0axupnx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 17 Feb 2006 22:49:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.98.136
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_NJABL_DUL,RCVD_IN_XBL,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16416>

Junio C Hamano <junkio@cox.net> writes:

> Alexandre Julliard <julliard@winehq.org> writes:
>
>> Is there interest in an emacs interface for git?  I posted a first
>> version (http://marc.theaimsgroup.com/?l=git&m=113313040724346&w=2)
>> some time ago, I'd be happy to send you a patch with my latest version
>> if you want to include it.
>
> Martin already said he wants it, and I would second that.  VC
> backend is one of the things I kept in the TODO list for quite a
> while (I think since early September 2005)...

Actually the interface I wrote (patch in separate mail) is not an
emacs VC backend, it's a project tree browser similar to pcl-cvs. It's
IMO a much better fit to the git philosophy than the per-file VC
hooks. But I'm planning to add VC backend support eventually...

-- 
Alexandre Julliard
julliard@winehq.org
