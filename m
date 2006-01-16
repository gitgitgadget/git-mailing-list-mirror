From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 11:44:48 +0100
Message-ID: <200601161144.48245.Josef.Weidendorfer@gmx.de>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 16 11:45:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyRrF-00033u-4z
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 11:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWAPKox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 05:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAPKox
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 05:44:53 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:53928 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751116AbWAPKow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 05:44:52 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id A72462162;
	Mon, 16 Jan 2006 11:44:49 +0100 (MET)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
In-Reply-To: <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14739>

On Saturday 14 January 2006 21:16, you wrote:
> Yes, I agree to the above 100%; the serious disadvantages come
> from the fact that we do not have clear separation between
> subprojects -- which new files belong to what subproject.  I
> ...
>  - Extend "commit" objects for the toplevel project to record
>    what subprojects with what head commits are contained at
>    which subdirectory.

The suggested "bind" info in commit objects has the same problem
as the original overlay: if the superproject already has a
subdirectory kernel/, and there is an additional "bind" specification
in commits also for kernel/, what should be done?

So the gitlink object seems to be the only solution if we want to
bind git versions of subprojects into a superproject.

But as this seems to make everything quite complex and not-obvious for
a user, I am with Paskys simple subproject idea.

Josef
