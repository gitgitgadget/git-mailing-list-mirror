From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with cg-clone
Date: Sat, 29 Oct 2005 13:19:25 -0700
Message-ID: <7vslukyt2q.fsf@assigned-by-dhcp.cox.net>
References: <1130605726.5396.39.camel@blade>
	<7vwtjwytzw.fsf@assigned-by-dhcp.cox.net>
	<1130616653.5396.56.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 22:21:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVxAp-00049c-Fw
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 22:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVJ2UT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 16:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVJ2UT2
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 16:19:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60873 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751199AbVJ2UT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 16:19:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029201910.SZBY1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Oct 2005 16:19:10 -0400
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1130616653.5396.56.camel@blade> (Marcel Holtmann's message of
	"Sat, 29 Oct 2005 22:10:53 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10807>

Marcel Holtmann <marcel@holtmann.org> writes:

>> The attached patch should fix git-local-fetch which I think the
>> above problem is.  git-clone -l -s would be much faster if you
>> are doing a local clone, however.
>
> I can confirm that with this patch everything is back to normal.

Thanks.  What Linus separately done (funny we did that
two-minutes apart) amounts to the same thing.
