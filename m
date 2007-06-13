From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: /usr/bin/cg-log: line 361: echo: write error: Broken pipe
Date: Wed, 13 Jun 2007 10:29:08 +0200
Message-ID: <1HyOE0-04QQoC0@fwd29.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 10:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyObk-0000um-NW
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 10:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbXFMIxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 04:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbXFMIxj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 04:53:39 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:58916 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167AbXFMIxi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 04:53:38 -0400
X-Greylist: delayed 1447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2007 04:53:38 EDT
Received: from fwd29.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1HyOEM-0002f1-0A; Wed, 13 Jun 2007 10:29:30 +0200
Received: from localhost (TvTVp8ZH8ezSGh6LYw+p-7K8rhtLD-7v--CnOx7V4jsuGCi5As+kkS@[172.20.101.250]) by fwd29.aul.t-online.de
	with esmtp id 1HyOE0-04QQoC0; Wed, 13 Jun 2007 10:29:08 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V7-7-2
X-ID: TvTVp8ZH8ezSGh6LYw+p-7K8rhtLD-7v--CnOx7V4jsuGCi5As+kkS@t-dialin.net
X-TOI-MSGID: 9d44c118-0c49-4063-9438-e6852f5a6bf5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50034>

Hi,

I'm using git version 1.5.2.1 and cogito-0.18.1.
Running cg-log gives a different list of logs than running git log.
After quitting cg-log the following error appears:
/usr/bin/cg-log: line 361: echo: write error: Broken pipe.

The lists are:

cg-log:
Commit: 0ca0ed8941002db1d1c241311b144a52f6c36547 
...
Commit: 68ba6cbe612f302aab41aab9ac224cce815d0449 
...
Commit: 62b3728663ed8ab46700adeb6b23624ec7fac405 
...

git log:
commit 0ca0ed8941002db1d1c241311b144a52f6c36547
...
commit dd41b67c15eccaf3e8b0db84bdd67f37cee67d3d
Merge: acd940c... 68ba6cb...
...
commit 68ba6cbe612f302aab41aab9ac224cce815d0449
...


On the previous commit (dd41b67c15eccaf3e8b0db84bdd67f37cee67d3d)
cg-log didn't show that one as first commit but the one before 
(68ba6cbe612f302aab41aab9ac224cce815d0449).
While cg-status showed dd41b67c15eccaf3e8b0db84bdd67f37cee67d3d.

Is this due to the merge?

Best regards,
Michael
