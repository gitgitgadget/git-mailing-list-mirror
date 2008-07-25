From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Avoid warning when From: is encoded
Date: Fri, 25 Jul 2008 11:39:20 -0500
Message-ID: <488A01B8.2010405@freescale.com>
References: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>	 <20080725131625.GA11221@toroid.org> <bd6139dc0807250901n7408a8e6w5dead238e897fc03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Abhijit Menon-Sen <ams@toroid.org>,
	=?ISO-8859-1?Q?Peter_Valdemar_?= =?ISO-8859-1?Q?M=F8rch?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jul 25 18:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQLe-0006Zd-Mo
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYGYQji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYGYQji
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:39:38 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:38770 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYGYQjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:39:37 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m6PGdQCX024538;
	Fri, 25 Jul 2008 09:39:26 -0700 (MST)
Received: from [10.214.73.128] (mvp-10-214-73-128.am.freescale.net [10.214.73.128])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6PGdPe3013315;
	Fri, 25 Jul 2008 11:39:25 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <bd6139dc0807250901n7408a8e6w5dead238e897fc03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90069>

Sverre Rabbelier wrote:

> Acked-by is reserved for people who are "owners" of the area the patch
> touches.

I love pronouncements like this.  While that may be exactly true
for the Git project, it is not, in general, always true.  Within
parts of the Kernel development process, anyone who wants to may
ACK a patch if they have done some level of work to confirm that
it "is good", for some measure of "good", even if that is just
applying the patch and testing it.  It is re-assurance that other
people consider the patch acceptable.

Of course, if there are, say, multiple functional areas with
different maintainers, and the patch should go in via one repository
but crosses into a second or third functional area, getting the
ACK from the other maintainers may be considered essential for
its ultimate acceptance.  In that regard, yes, the maintainer's
ACK carries more weight.

> So for example, a patch to git-gui could be Acked-by Shawn O.
> Pierce, or one related to pack format by Nico (I think?). So you
> should Ack it if you have done (a lot of) work in the same area as the
> patch before and if the patch looks good.

Agreed.

jdl
