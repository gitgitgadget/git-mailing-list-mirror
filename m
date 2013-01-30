From: John Keeping <john@keeping.me.uk>
Subject: git-remote-helpers.txt: should it be gitremote-helpers.txt?
Date: Wed, 30 Jan 2013 20:11:02 +0000
Message-ID: <20130130201102.GM1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 21:11:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0e0J-0004Wk-TW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab3A3ULJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:11:09 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41550 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3A3ULH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:11:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6F1C986601F
	for <git@vger.kernel.org>; Wed, 30 Jan 2013 20:11:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11A2sIEZ9PCQ for <git@vger.kernel.org>;
	Wed, 30 Jan 2013 20:11:06 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 29F1786601C
	for <git@vger.kernel.org>; Wed, 30 Jan 2013 20:11:04 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215069>

Max Horn's email today prompted me to try reading the git-remote-helpers
man page, so I tried:

    $ git help remote-helpers
    No manual entry for gitremote-helpers

But "man git-remote-helpers" does work.

It turns out that "builtin/help.c" maps its argument to a page by
prepending "git-" if given the name of a Git command and "git"
otherwise.

Does this mean that "git-remote-helpers.txt" should lose the first
hyphen or is help.c not being clever enough in some way?


John
