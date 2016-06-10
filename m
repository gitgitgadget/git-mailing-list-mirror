From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: svn dcommit: where happens the writing of the timestamp?
Date: Fri, 10 Jun 2016 14:18:58 +0200
Message-ID: <877fdxp77x.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:19:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLPL-0001hh-0u
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbcFJMTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 08:19:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:37059 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcFJMTV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:19:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bBLOx-0001R4-LY
	for git@vger.kernel.org; Fri, 10 Jun 2016 14:19:03 +0200
Received: from arennes-651-1-10-32.w86-215.abo.wanadoo.fr ([86.215.209.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 14:19:03 +0200
Received: from pmlists by arennes-651-1-10-32.w86-215.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 14:19:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-651-1-10-32.w86-215.abo.wanadoo.fr
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:9H/I4WOhSkV1G7Zbt1ppEANjUhg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296973>

Hi,

Could someone please show me, where the timestamp is rewritten in the
code, so that I could change it and compile a local copy of git, that
fits my needs? Perhaps I could even create a patch, that implements
"--preserve-timestamps" and send it back.

I've already searched in git-svn.perl but without success... :(

TIA for any hints,
-- 
           Peter
