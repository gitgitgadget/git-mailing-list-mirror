From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 02 Jul 2008 01:08:09 -0700
Message-ID: <7vd4lwemja.fsf@gitster.siamese.dyndns.org>
References: <20080701101114.GA6379@sigill.intra.peff.net>
 <1214912674-9443-1-git-send-email-trast@student.ethz.ch>
 <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
 <20080702080200.GA21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxP0-0001Zb-Gi
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbYGBIIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 04:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYGBIIY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:08:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbYGBIIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:08:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A784285A9;
	Wed,  2 Jul 2008 04:08:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A28AB285A8; Wed,  2 Jul 2008 04:08:16 -0400 (EDT)
In-Reply-To: <20080702080200.GA21367@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Jul 2008 04:02:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 094030BA-480E-11DD-B5E1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87099>

Jeff King <peff@peff.net> writes:

> According to Module::CoreList, File::Temp has shipped as part of core
> perl since 5.006001. "add -i" doesn't work with perl < 5.6 already due to
> things like 3-argument open.
>
> So if the problem is "old perl", I don't think it is an issue. Are there
> modern perl installations in the wild that don't have File::Temp?

The thing is, I think I heard quite similar explanation why Test::More is
safe to use when the patch to add t/t9700 was submit.  Then what happened?
