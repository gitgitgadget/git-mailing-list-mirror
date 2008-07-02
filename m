From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Making remote tracking statistics available to other
 tools
Date: Wed, 02 Jul 2008 00:50:38 -0700
Message-ID: <7v3amsg1wx.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 02 09:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDx83-0004FS-SE
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 09:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYGBHuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 03:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbYGBHuz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 03:50:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbYGBHuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 03:50:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 27AD1284A6;
	Wed,  2 Jul 2008 03:50:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A5C0284A2; Wed,  2 Jul 2008 03:50:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 975129D4-480B-11DD-9F12-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87094>

The one I sent out was a bit hacky as the existing implementation inside
git-checkout was not designed to be cleanly reusable.

Here is a cleaned up series that could be applied.

[PATCH 1/3] Refactor "tracking statistics" code used by "git checkout"
[PATCH 2/3] git-status: show the remote tracking statistics
[PATCH 3/3] git-branch -v: show the remote tracking statistics
