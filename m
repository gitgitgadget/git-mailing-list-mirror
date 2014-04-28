From: Silvola Tuomas <tuomas.silvola@knowit.fi>
Subject: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 06:19:26 +0000
Message-ID: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 08:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weeur-0005ck-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 08:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbaD1GTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 02:19:45 -0400
Received: from mx.endero.com ([89.250.62.122]:59237 "EHLO mx.knowit.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbaD1GTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 02:19:44 -0400
Thread-Topic: git version 1.9.0 missing git-http-push?
Thread-Index: Ac9iqbSqq61hWFV8SiGHXDjF9wbcoA==
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247236>

Hello,

I installed git for windows 1.9.0 but any push operation I tried with it produced an error message saying "git: 'http-push' is not a git command". Other commands like pull, add, and commit worked just fine.
At the end of this day I noticed that C:\Program Files (x86)\Git\libexec\git-core just didn't have the file git-http-push. There were git-http-backend, git-http-fetch and git-imap-send and such but no git-http-push.

I resolved my issue by uninstalling 1.9.0, installing an older version instead (1.8.1.2; this is when push started working) and 1.9.0 right on top of the older version. Now git push command works as expected.

Br,
Tuomas Silvola
