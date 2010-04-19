From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] remote add: add a --no-tags (-n) option
Date: Mon, 19 Apr 2010 18:19:15 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2010-04-19-18-19-15+trackit+sam@rfc1149.net>
References: <20100419135014.1077.28627.stgit@localhost.localdomain>
	<4BCC8073.80109@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 19 18:19:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3th1-00084N-Py
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 18:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab0DSQTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 12:19:20 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:60248 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab0DSQTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 12:19:19 -0400
Received: from localhost (unknown [IPv6:2001:6f8:37a:2:211:2fff:fe8a:af74])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 38C4070C5;
	Mon, 19 Apr 2010 18:19:16 +0200 (CEST)
In-Reply-To: <4BCC8073.80109@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 19 Apr 2010 18:10:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145310>

>>>>> "Michael" == Michael J Gruber <git@drmicha.warpmail.net> writes:

Michael> Samuel Tardieu venit, vidit, dixit 19.04.2010 15:50:
>> Add a '--no-tags' option to 'git remote add' which adds a
>> 'remote.REMOTE.tagopt = --no-tags' to the configuration file.
>> 
>> 'git add -f -n REMOTE' will create a new remote and fetch from it

Michael> I guess you mean 'git remote add' here.

Yes, indeed.

Michael> Is this buf freed again?

Absolutely, there is a "strbuf_release(&buf)" a few lines down (the
buffer may be reused in the meantime).

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
