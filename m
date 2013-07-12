From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Microfixes to mailmap
Date: Fri, 12 Jul 2013 14:38:51 -0700
Message-ID: <1373665135-32484-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 23:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxl3d-0003aP-LZ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349Ab3GLVi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932919Ab3GLVi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:38:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9749E30311
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Lw1lOvmOOMaWB7ipx279WD2nxDE
	=; b=AY8npTAeWsRG65CGI2U7yOQN/+PDmL5i6OSTiWU1dQXg3FY/5nWDsQi/N9b
	efjVC6qYb/IWUwBa/23fgGuuPOpg7hYedh+oABSzjVki20sBWzXcv4xYLxDOcbFM
	iKGVDnE4Lozk4R1HjJ4tPosBd7Lp4aIp5QhODY63lrd5tmIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=am6DMqoN+aqvP0KUqkumttgRw4gdB
	6iNxJCsGF5507wQXDw05hU7TEl5of62l4qUQPVVwuQ0+xfKrgUJ5gGRZ1SKtXFiH
	Qhq1OMd6oKkx+D2r28EjNKRiAVLcmu+KV1m6j749kT++k3yo7wbm1Nd/1H0VgkqP
	KED271/k/9/Pj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D05830310
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:38:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0385B3030F
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:38:56 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-941-gda9c3c8
X-Pobox-Relay-ID: 74D49C64-EB3B-11E2-A64E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230258>

There were a few bugs in mailmap parsing and matching code.

Junio C Hamano (3):
  mailmap: do not lose single-letter names
  mailmap: do not downcase mailmap entries
  mailmap: style fixes

Stefan Beller (1):
  Add a testcase for checking case insensitivity of mailmap

 mailmap.c          | 37 +++++++++++++++++++------------------
 t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 18 deletions(-)

-- 
1.8.3.2-941-gda9c3c8
