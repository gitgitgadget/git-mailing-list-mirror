From: "Max Kirillov" <max@max630.net>
Subject: RE: Recording the current branch on each =?UTF-8?Q?commit=3F?=
Date: Sun, 27 Apr 2014 23:36:35 -0700
Message-ID: <20140427233635.96eec638b311907e2368f42b42021fd8.fa0e4193ea.wbe@email02.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Git mailing list" <git@vger.kernel.org>,
	"Jeremy Morton" <admin@game-point.net>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 08:41:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WefG4-0003kl-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 08:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbaD1Glk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 02:41:40 -0400
Received: from p3plsmtp02-02-2.prod.phx3.secureserver.net ([72.167.218.95]:55658
	"EHLO p3plwbeout02-02.prod.phx3.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbaD1Glj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 02:41:39 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Apr 2014 02:41:39 EDT
Received: from localhost ([72.167.218.118])
	by p3plwbeout02-02.prod.phx3.secureserver.net with bizsmtp
	id vJcc1n0012ZrgKL01JccCi; Sun, 27 Apr 2014 23:36:36 -0700
X-SID: vJcc1n0012ZrgKL01
Received: (qmail 11480 invoked by uid 99); 28 Apr 2014 06:36:36 -0000
X-Originating-IP: 193.64.145.29
User-Agent: Workspace Webmail 5.6.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247238>

Hi.

> Obviously, the feature would necessarily have to be optional, simply
> because Git would have to keep understanding the old commit object
> format for a LONG time (probably indefinitely), and there's nothing
> you can do to prevent others from creating old-style commit objects.

Doesn't git ignores unknown headers? I has been investigating this issue
and it looked like it does.

Could the API to add commit headers (which exists in sources) be added
to cli, so users can create the branches, phases or whatever they feel
useful?

-- 
Max
