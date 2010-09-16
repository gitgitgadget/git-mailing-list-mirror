From: Anton <tmp009@allproducts.info>
Subject: empty directories and git Question
Date: Thu, 16 Sep 2010 07:59:19 +0000 (UTC)
Message-ID: <loom.20100916T095344-932@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 10:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow9T6-0001Du-OW
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 10:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0IPIFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 04:05:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:34314 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab0IPIFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 04:05:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ow9Sq-000193-2j
	for git@vger.kernel.org; Thu, 16 Sep 2010 10:05:04 +0200
Received: from 81-94-55-168-xdsl-klg.xpirio.net ([81.94.55.168])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 10:05:04 +0200
Received: from tmp009 by 81-94-55-168-xdsl-klg.xpirio.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 10:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.94.55.168 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; de-de) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156291>

Hi!

I am using git for a very long time with TextMate and Ruby on Rails,
now I am working with Eclipse and Android and I have a stupid problem
(or I am stupid...). Can anybody help me?

I have directories which I do not want to track in git (like gen/* an bin/*).
They can be ignored by adding them to the .gitignore - works well.

But when I clone the project Eclipse shouts about the missing directories.
So I tried the following:

added a .ignoreme file to "bin" and "gen", ignored everything else.
Works fine, now the directory and the two .ignoreme files are added,
but Eclipse does not like to have any file in the bin directory
(can't build until I remove it).

So it there no way to manage bin folders of any kind
in git when working with IDEs?

Thank you very much in advance!

Regards,
Anton
