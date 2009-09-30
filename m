From: Reto Glauser <linux@blinkeye.ch>
Subject: search branches which contain a blob id
Date: Wed, 30 Sep 2009 14:38:30 +0200
Message-ID: <8a906e45ab8e0252a0be11e4d4e9389e@blinkeye.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 30 14:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsyS4-00040x-Bk
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 14:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbZI3Mi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 08:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbZI3Mi1
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 08:38:27 -0400
Received: from mail.blinkeye.ch ([78.46.102.7]:42671 "EHLO mail.blinkeye.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbZI3Mi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 08:38:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.blinkeye.ch (Postfix) with ESMTP id 48D961A6F36
	for <git@vger.kernel.org>; Wed, 30 Sep 2009 14:38:30 +0200 (CEST)
Received: from blinkeye.ch (blinkeye.ch [78.46.102.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.blinkeye.ch (Postfix) with ESMTPSA id 31FC61A6F35
	for <git@vger.kernel.org>; Wed, 30 Sep 2009 14:38:30 +0200 (CEST)
X-Sender: linux@blinkeye.ch
User-Agent: RoundCube Webmail/0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129341>

To get a list of branches which contain a specific commit we use:

$ git branch --contains <commit id>

Is there a similar way to get a list of branches with respect to a
specific blob (e.g. the actual code change a commit introduces)? 

Obvious use-case: One isn't interested in the commit information (author,
parent, date) but merely in the set of changes a commit introduces.
