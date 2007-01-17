From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce 'git-format-patch --suffix=patch'
Date: Wed, 17 Jan 2007 11:57:21 -0800
Message-ID: <7vps9dqvdq.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
	<45AE7710.40503@shadowen.org>
	<7vzm8hqws4.fsf@assigned-by-dhcp.cox.net>
	<D085A8A2-F1EC-47EC-8D96-B8A06E483BDB@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GuT-0001Gp-MU
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbXAQT5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbXAQT5Y
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:57:24 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61117 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932695AbXAQT5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:57:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117195722.IZRM97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 14:57:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CKxf1W00e1kojtg0000000; Wed, 17 Jan 2007 14:57:40 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
In-Reply-To: <D085A8A2-F1EC-47EC-8D96-B8A06E483BDB@silverinsanity.com> (Brian
	Gernhardt's message of "Wed, 17 Jan 2007 14:51:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37033>

Brian Gernhardt <benji@silverinsanity.com> writes:

> I think that the best form of DWIM is that if the suffix is "", then
> you simply skip the entire sprintf.  Then any suffix has to have the
> '.', but no suffix doesn't have it.  Additional DWIMMmery could
> remove an initial '.' from the suffix so that users expecting it to
> be there don't get ".." in their file.

I think it is generally accepted on this list that that kind of
DWIMmery is bad.
