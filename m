From: Bill Lear <rael@zopyra.com>
Subject: When to repack?
Date: Wed, 31 Jan 2007 06:50:32 -0600
Message-ID: <17856.37016.341839.397309@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 13:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCEvA-0003X8-Va
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 13:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbXAaMuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 07:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933204AbXAaMuh
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 07:50:37 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60942 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933203AbXAaMug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 07:50:36 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0VCoZq01927;
	Wed, 31 Jan 2007 06:50:35 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38242>

We have a company repo used by many people throughout the day.  When/how
can I repack this?  I have come to adopt this approach:

% mv project project.pack
% cd project.pack
% GIT_DIR=. git repack -a -d
% cd ..
% mv project.pack project


Bill
