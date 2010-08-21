From: Jean Delvare <khali@linux-fr.org>
Subject: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 09:26:16 +0200
Message-ID: <20100821092616.5e57135b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 09:26:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmiTK-0002Mb-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 09:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab0HUH0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 03:26:30 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:37058 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab0HUH02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 03:26:28 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1OmiSA-00049Z-0V
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	for git@vger.kernel.org; Sat, 21 Aug 2010 09:25:22 +0200
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154118>

Hi there,

I have a feature request for gitweb. In the history view, I would like
to be (optionally) able to see the tags, interlaced with the actual
commits. The idea is to get an immediate view of all commits that
happened between specific tags.

The actual format for displaying the tags can certainly be discussed, I
have no strong opinion on this myself. We may want to let the admin
filter which tags should show up that way, maybe even letting him/her
define primary and secondary tag formats (think main releases vs.
release candidates) for nicer output. Then we may want to group (or
hide) tags when a file hasn't been modified in a long time. But these
are implementation details, even the raw functionality would be quite
useful IMHO, and hopefully not too difficult to implement.

At the moment I am using a custom tool when I need to answer this kind
of question, but being backed-up by quilt, it's quite slow and
disk-consuming. I would love to be able to get rid of it and use only
gitweb.

Thanks,
-- 
Jean Delvare
