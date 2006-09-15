From: Gerrit Pape <pape@smarden.org>
Subject: cg-commit -p -m ignores -p
Date: Fri, 15 Sep 2006 13:23:19 +0000
Message-ID: <20060915132319.12117.qmail@7d60384c102e6d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 15 15:23:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GODel-00013g-Sz
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 15:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWIONW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 09:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIONW6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 09:22:58 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41146 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751413AbWIONW6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 09:22:58 -0400
Received: (qmail 12118 invoked by uid 1000); 15 Sep 2006 13:23:19 -0000
To: git@vger.kernel.org, 387515@bugs.debian.org
Mail-Followup-To: git@vger.kernel.org, 387515@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27087>

Hi, please see http:/bugs.debian.org/387515 or below.  I agree that
ideally cg-commit should behave differently.

Thanks, Gerrit.

----- Forwarded message from Andrew Suffield <asuffield@suffields.me.uk> -----

cg-commit -p -m ignores the -p argument and silently commits. Yes,
this is documented, but it's still stupid behaviour; if the user had
meant that, they would have just used -m alone.

At the very least, it should abort with an error (on the basis that
the command makes no sense); more sensibly, it should create a log
message with the given string and then spawn an editor (and then since
the user will probably exit without changing the file, the "Abort or
commit?" message would appear as per usual, which seems to me to be
appropriate behaviour).


----- End forwarded message -----
