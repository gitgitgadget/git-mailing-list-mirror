From: "Yann Dirson" <ydirson@linagora.com>
Subject: "git svn reset" only resets current branch ?
Date: Mon, 6 Jul 2009 12:07:37 +0200 (CEST)
Message-ID: <43948.10.0.0.1.1246874857.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 06 12:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNl7a-0001C6-Hm
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 12:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbZGFKH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 06:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZGFKH1
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 06:07:27 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:44329 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbZGFKH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 06:07:27 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id A1F9F429F08;
	Mon,  6 Jul 2009 12:07:28 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Mon, 6 Jul 2009 12:07:37 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122781>

I just tried the new "git svn reset" from master, and got puzzled that
only the svn branch which is an ancestor of current git HEAD got rolled
back.  Is that the expected behaviour ?  It would not make it very easy to
fixup imports from svn trees with lots of branches/tags.
