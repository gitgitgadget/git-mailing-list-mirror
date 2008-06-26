From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REPLACEMENT PATCH] parse-opt: fake short strings for callers to
 believe in.
Date: Thu, 26 Jun 2008 01:40:16 -0700
Message-ID: <7v7iccsi6n.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <1214298732-6247-1-git-send-email-madcoder@debian.org>
 <1214298732-6247-2-git-send-email-madcoder@debian.org>
 <1214298732-6247-3-git-send-email-madcoder@debian.org>
 <1214298732-6247-4-git-send-email-madcoder@debian.org>
 <1214298732-6247-5-git-send-email-madcoder@debian.org>
 <1214298732-6247-6-git-send-email-madcoder@debian.org>
 <20080624205801.GG9189@artemis.madism.org>
 <20080626083506.GA7237@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:41:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBn2g-0000AX-TM
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYFZIk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbYFZIk1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:40:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYFZIk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:40:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E2226F7C4;
	Thu, 26 Jun 2008 04:40:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2B53BF7C3; Thu, 26 Jun 2008 04:40:19 -0400 (EDT)
In-Reply-To: <20080626083506.GA7237@artemis.madism.org> (Pierre Habouzit's
 message of "Thu, 26 Jun 2008 10:35:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8557046A-435B-11DD-9FAC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86416>

Pierre Habouzit <madcoder@debian.org> writes:

>   I saw that you merged this series into pu, for which I'm really glad,

Heh, you shouldn't be glad to have "landed" on 'pu', as being in 'pu' is
just a sign of "undecided" ;-)

And thanks for a reminder.  Every bit of help to make integration smoother
really helps.  I've been swamped and I still have your "revisions:
refactor init_revisions and setup_revisions" sitting in my inbox.
