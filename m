From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: feature request: git svn dommit --preserve-timestamps
Date: Mon, 06 Jun 2016 21:21:05 +0200
Message-ID: <87a8iy6s4e.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 21:35:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0Iv-0007XH-4D
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcFFTfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 15:35:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:32790 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbcFFTfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 15:35:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bA0Ih-0007Og-Kz
	for git@vger.kernel.org; Mon, 06 Jun 2016 21:35:03 +0200
Received: from arennes-651-1-298-135.w2-12.abo.wanadoo.fr ([2.12.1.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 21:35:03 +0200
Received: from pmlists by arennes-651-1-298-135.w2-12.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 21:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-651-1-298-135.w2-12.abo.wanadoo.fr
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:XICDq0xviwohhdez3TWq84joJis=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296556>

Hi,

It would be nice, if timestamps could be preserved when rewriting the
git-log.

Use case: I often make a dcommit after several days of development
(20 or 30 commits), because
- the users of the svn-server don't need it more often;
- and for the dcommit I need a VPN-connection to a server, that is not
  always available.

Today, after a dcommit, it's no more possible to match a special commit
by time and date (for example the time of some email exchange).

TIA for your attention and perhaps the implementation of such a feature.

Kind regards,
-- 
           Peter
