From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: git add -u nonexistent-file
Date: Mon, 8 Feb 2010 19:29:29 +0100
Message-ID: <20100208182929.GB14355@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 19:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeYbM-0000YY-7e
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 19:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab0BHSoq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 13:44:46 -0500
Received: from francis.fzi.de ([141.21.7.5]:17036 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752805Ab0BHSoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 13:44:46 -0500
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2010 13:44:45 EST
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Feb 2010 19:29:30 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 08 Feb 2010 18:29:30.0332 (UTC) FILETIME=[A72309C0:01CAA8EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139304>

Hi,


$ git --version
git version 1.7.0.rc1.84.g9879
$ git add -u nonexistent-file
$ echo $?
0

No error message, no error in exit status.

Is it OK this way?  Why?


Best,
G=E1bor
