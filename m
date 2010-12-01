From: =?utf-8?b?Wm9sdMOhbg==?= =?utf-8?b?RsO8emVzaQ==?= 
	<zfuzesi@eaglet.hu>
Subject: msysgit clone/pull/fetch broken
Date: Wed, 1 Dec 2010 13:31:11 +0000 (UTC)
Message-ID: <loom.20101201T141924-761@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 14:31:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmmQ-00049t-O5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 14:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0LANbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 08:31:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:51210 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558Ab0LANbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 08:31:25 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNmmJ-00046o-PV
	for git@vger.kernel.org; Wed, 01 Dec 2010 14:31:23 +0100
Received: from business-80-99-238-243.business.broadband.hu ([80.99.238.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:31:23 +0100
Received: from zfuzesi by business-80-99-238-243.business.broadband.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:31:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.99.238.243 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.210 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162514>

Hi, I can't clone/pull/fetch from any of my repositories with the lates=
t stable=20
version (1.7.3.2.430.g208247) on Windows.

$ git clone --recursive git://server/user/project.git
Cloning into project...
fatal: failed to read object <sha1>: No error

After reverting commit 3ba7a065527a27f45659398e882feaa1165cbb4c ("A loo=
se object=20
is not corrupt if it cannot be read due to EMFILE") it works.

On Linux everything is fine.

BR,
Z=C3=A9
