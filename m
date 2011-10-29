From: Eric Raible <raible@nextest.com>
Subject: sparse checkout using exclusions
Date: Fri, 28 Oct 2011 17:17:54 -0700
Message-ID: <4EAB4632.5080101@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 02:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJwgt-0000vn-15
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 02:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808Ab1J2AR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 20:17:57 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:55074 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755931Ab1J2AR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 20:17:56 -0400
Received: from [131.101.151.102] (131.101.151.102) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Fri, 28 Oct 2011 17:17:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184444>

Hi all.

I was just about to send a long message about using exclusions
in sparse-checkout, when I did one last search and saw that all
of my problems were fixed by using '/*' instead of '*' as the
first line in .git/info/sparse-checkout.

Might it make sense for the example in git-read-tree.html to be
updated to include the leading slash?

    /*
    !unwanted

- Eric
