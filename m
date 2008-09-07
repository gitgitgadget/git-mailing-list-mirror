From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: release the lockfile in
 try_merge_strategy()
Date: Sat, 06 Sep 2008 22:44:19 -0700
Message-ID: <7vod30pl1o.fsf@gitster.siamese.dyndns.org>
References: <20080906021222.GY16514@genesis.frugalware.org>
 <1220718589-12424-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 07:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcD5d-0000Qc-Vr
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 07:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYIGFo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 01:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbYIGFo2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 01:44:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYIGFo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 01:44:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59E4E76B4F;
	Sun,  7 Sep 2008 01:44:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 926F976B4D; Sun,  7 Sep 2008 01:44:21 -0400 (EDT)
In-Reply-To: <1220718589-12424-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 6 Sep 2008 18:29:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07826CEA-7CA0-11DD-B73E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95114>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Once we committed the locked index, we should release the lockfile. In
> most cases this is done automatically when the process ends, but this is
> not true in this case.

Thanks.
