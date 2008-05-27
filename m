From: Thomas Volpini <tvolpini@gmx.net>
Subject: git grep and word boundaries
Date: Tue, 27 May 2008 10:35:46 +0200
Message-ID: <483BC7E2.6090804@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 10:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ufz-00026y-UE
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbYE0Ifu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbYE0Ifu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:35:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:53912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756055AbYE0Ift (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:35:49 -0400
Received: (qmail invoked by alias); 27 May 2008 08:35:46 -0000
Received: from unknown (EHLO tvolpini.local) [86.59.122.178]
  by mail.gmx.net (mp007) with SMTP; 27 May 2008 10:35:47 +0200
X-Authenticated: #628067
X-Provags-ID: V01U2FsdGVkX1/qFdlOXi/quWTsuNa7m97WQWZ1/8K4A5ok8lHBON
	1nvwq2Nhic/gp5
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82991>

Hello,

it seems that git grep doesn't do word boundaries as described:

$ cat bar
foo bar baz
$ grep "\<bar\>" *
foo bar baz
$ git grep "\<bar\>" *
$ git grep -w "\<bar\>" *
$ git grep -w "bar" *
bar:foo bar baz
$ git grep -E "\<bar\>" *
$ git grep -E "\bbar\b" *
$

thanks,
Thomas
