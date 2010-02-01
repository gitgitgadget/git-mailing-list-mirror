From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Mon,  1 Feb 2010 14:02:05 +0530
Message-ID: <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
Cc: ford_prefect@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 09:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbrhb-0000FZ-F9
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 09:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab0BAIcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 03:32:05 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:60109 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab0BAIcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 03:32:04 -0500
Received: from localhost.localdomain (unknown [122.171.0.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id C2C1C1B41A8;
	Mon,  1 Feb 2010 08:32:00 +0000 (UTC)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138593>

Hello!
This patch set reintroduces the post-upload-pack hook and adds a
pre-upload-pack hook. These are now only built if 'ALLOW_INSECURE_HOOKS' is set
at build time. The idea is that only system administrators who need this
functionality and are sure the potential insecurity is not relevant to their
system will enable it.

At some point if the future, if needed, this could also be made a part of the
negotiation between the client and server.

Cheers,
Arun
