From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 14:36:54 +0000
Message-ID: <80wsf9ovsp.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 15:38:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0GrF-0004TD-B1
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 15:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYKLOg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYKLOg5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 09:36:57 -0500
Received: from rufus.isode.com ([62.3.217.251]:50157 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbYKLOg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 09:36:57 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SRrqBgAJxW9y@rufus.isode.com> for <git@vger.kernel.org>;
          Wed, 12 Nov 2008 14:36:54 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 12 Nov 2008 14:36:54 +0000
X-Hashcash: 1:20:081112:git@vger.kernel.org::bErVRW6xAm1aCPKk:0000000000000000000000000000000000000000004QH8
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100755>

The following works fine with 1.6.0.2 and before, but not 1.6.0.3 or
later:

	git clone -n git git-test
        cd git-test
        git checkout -b work v1.6.0.2

When it breaks, the error is:

	error: Entry '.gitignore' would be overwritten by merge. Cannot merge.

I'm guessing it's a bug rather than a deliberate change?
