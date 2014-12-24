From: Christoph Junghans <ottxor@gentoo.org>
Subject: Re: [PATCH] git-log: added --invert-grep option
Date: Tue, 23 Dec 2014 20:03:15 -0700
Message-ID: <1419390196-17222-1-git-send-email-ottxor@gentoo.org>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 24 04:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3cEk-0001Iy-8z
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 04:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbaLXDDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 22:03:42 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:48215 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbaLXDDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 22:03:41 -0500
Received: from dev.gentoo.org:587 (unknown [50.130.223.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C5C053405C3;
	Wed, 24 Dec 2014 03:03:39 +0000 (UTC)
Received: by dev.gentoo.org:587 (sSMTP sendmail emulation); Tue, 23 Dec 2014 20:03:37 -0700
X-Mailer: git-send-email 2.0.5
In-Reply-To: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261791>

Ok, I drafted a first version of the suggest --grep-begin ...
--grep-end syntax.

However, I could not find a good ways to invert the match on a commit
basis instead of the normal line-wise version. Any suggestions?
