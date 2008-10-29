From: Teemu Likonen <tlikonen@iki.fi>
Subject: A typesetting problem with git man pages
Date: Wed, 29 Oct 2008 21:16:52 +0200
Message-ID: <87skqfus7v.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 20:18:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvGYZ-0004Hi-AL
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbYJ2TQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 15:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYJ2TQ4
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 15:16:56 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:53884 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723AbYJ2TQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 15:16:54 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8900858C94 for git@vger.kernel.org; Wed, 29 Oct 2008 21:16:53 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99392>

I compile git and its man pages myself and I just noticed that the man
pages (invoked with "git help log", for example) have a typesetting
problem. There are ".ft" commands here and there, like this:

    .ft C
    [i18n]
            commitencoding = ISO-8859-1
    .ft

Does anybody know why "man" prints those ".ft" commands? The
corresponding code in git-log.1 file is this:

    \&.ft C
    [i18n]
            commitencoding = ISO\-8859\-1
    \&.ft

Recently I upgraded my system from Debian 4.0 (Etch) to 5.0 (Lenny) and
it is possible that some tools which are related to compiling the man
pages are now newer versions.
