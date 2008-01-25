From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: docu. concerning push and remotes
Date: Fri, 25 Jan 2008 16:09:26 +0100
Message-ID: <1JIQBK-1ueKMy0@fwd35.aul.t-online.de>
Reply-To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 16:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIQCH-0007Xa-Jw
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 16:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYAYPJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 10:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYAYPJt
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 10:09:49 -0500
Received: from mailout11.sul.t-online.de ([194.25.134.85]:37082 "EHLO
	mailout11.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753664AbYAYPJs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 10:09:48 -0500
Received: from fwd35.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1JIQBe-0004w8-00; Fri, 25 Jan 2008 16:09:46 +0100
Received: from localhost (TiS8r8ZArhhtHTE8rq6vLfXKwnk6nqPFL6OEHNgCeRGoJHENgKz7dfvrCecGip-Z79@[172.20.101.250]) by fwd35.aul.t-online.de
	with esmtp id 1JIQBK-1ueKMy0; Fri, 25 Jan 2008 16:09:26 +0100
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-1-3
X-ID: TiS8r8ZArhhtHTE8rq6vLfXKwnk6nqPFL6OEHNgCeRGoJHENgKz7dfvrCecGip-Z79@t-dialin.net
X-TOI-MSGID: f72b8cff-9a72-46cc-bebf-4858ef07aa11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71713>

Hi,

the man page of git-config explains that branch.<name>.remote has an
influence on
the default behavior of fetch. It looks like it also has an influence on
the default of push. 
This is what I was looking for. But I could not find that influence on
push documented.  

I found that I had to setup branch.<name>.remote (and
branch.<name>.merge)
entries for my branches in order to have only the current branch pushed
when I use git push without arguments.
That's what I want. If I don't have these settings all branches get
pushed.
In addition a separate remote has to exist for every branch.

Somehow I feel this should be mentioned in the man page of git-config or

git-push.

Cheers,
Michael
