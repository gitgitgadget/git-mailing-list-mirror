From: Bill Lear <rael@zopyra.com>
Subject: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 13:38:02 -0600
Message-ID: <17875.25882.784307.731860@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 20:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPxO-0008Cy-IC
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXBNTiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXBNTiH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:38:07 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60005 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932493AbXBNTiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:38:06 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EJc4311189;
	Wed, 14 Feb 2007 13:38:04 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39730>

I have not yet figured this one out: I have not tagged anything, but
know that I checked in something lame sometime between now and two days
ago.  How do I get my working repo to be that as it was, say, yesterday?

Do I do:

% git log --since="2 days ago"

parse, the output for the commit I want, and then do

% git reset <SHA>

or would I do

% git reset --soft <SHA>

or something else?


Bill
