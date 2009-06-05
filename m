From: "Yann Dirson" <ydirson@linagora.com>
Subject: [BUG] "gitk -- ." shows nothing in file pane
Date: Fri, 5 Jun 2009 13:00:31 +0200 (CEST)
Message-ID: <60399.10.0.0.1.1244199631.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Jun 05 13:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCXA9-0002Vm-IE
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 13:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbZFELAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 07:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZFELAX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 07:00:23 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:59374 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbZFELAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 07:00:23 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 4F634429F0F;
	Fri,  5 Jun 2009 13:00:23 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 82.127.2.119)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Fri, 5 Jun 2009 13:00:31 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120767>

When using 1.6.3.1, whereas "gitk -- src" does list the paths in the
rightmost pane, "(cd src && gitk -- .)" lists nothing there, whereas the
diff pane contains the expected diffs.

It's been 6 months I noticed this issue, but then just forgot about it :)
