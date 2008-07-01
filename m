From: Stephan Beyer <s-beyer@gmx.net>
Subject: git sequencer prototype
Date: Tue,  1 Jul 2008 04:38:30 +0200
Message-ID: <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 04:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVmL-00053B-Tw
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbYGACil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbYGACil
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:38:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:33545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754729AbYGACik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:38:40 -0400
Received: (qmail invoked by alias); 01 Jul 2008 02:38:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp047) with SMTP; 01 Jul 2008 04:38:38 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/Cgvxg5eLC8p94NXviuZzq3Jt13WSWv4+vMes6un
	Z/QYPD9gCSKjK9
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDVlK-0004eb-6L; Tue, 01 Jul 2008 04:38:34 +0200
X-Mailer: git-send-email 1.5.6.1.130.ga8860.dirty
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86985>

Hi,

here is the patchset for the git-sequencer prototype, documentation,
test suite and a first git-am and git-rebase-i migration.
Indeed, monster patches. ;)

I'm using sequencer-based git-am and git-rebase-i and also git-sequencer
itself for around 2-3 weeks now. So, for me, it is reality-proven, but
I'm curious about your opinions/suggestions in usage and source.

The migration patches are a little hard to code-review in the diff-form,
but feel free to apply, test, and then look at the code ;)

Regards,
  Stephan
