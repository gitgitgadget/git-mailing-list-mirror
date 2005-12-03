From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk does not recognizes ISO-8859-15
Date: Sat, 03 Dec 2005 11:08:18 -0800
Message-ID: <7v4q5qyp5p.fsf@assigned-by-dhcp.cox.net>
References: <4391C6B8.7010507@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:09:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EickG-0001tq-4I
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVLCTIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVLCTIY
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:08:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40595 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932156AbVLCTIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 14:08:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203190748.VXRY15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 14:07:48 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <4391C6B8.7010507@yahoo.it> (Marco Costalba's message of "Sat, 03
	Dec 2005 17:24:24 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13157>

Marco Costalba <mcostalba@yahoo.it> writes:

> So here we arrive. I see two ways to deal with this:
>
> 1) *solution* make gitk use IANA names
>
> 2) *workaround* get from somewhere the list of Tcl/Tk recognized codec names and 
> teach qgit to do the map from IANA when setting a codec with "git-repo-config 
> i18n.commitencoding"

The intent of i18n.commitencoding is to have something that is
understood by iconv there, so if gitk does not work with these
things spelled like. ISO8859-1 or ISO-8859-15, and qgit is happy
with them, I would say that we should fix gitk, which means
*workaround* should be on the tcl/tk side.

Tcl/Tk expert may have more thoughts (and I suspect experiences)
on this, but I am not one of them.
