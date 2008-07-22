From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: give a proper error message for invalid
 strategies in config
Date: Mon, 21 Jul 2008 22:01:16 -0700
Message-ID: <7vr69mpl5v.fsf@gitster.siamese.dyndns.org>
References: <1216656647-16897-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 07:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLA10-0007vu-CE
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 07:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYGVFBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 01:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbYGVFBX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 01:01:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbYGVFBW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 01:01:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F4EE33564;
	Tue, 22 Jul 2008 01:01:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DDD4F33563; Tue, 22 Jul 2008 01:01:18 -0400 (EDT)
In-Reply-To: <1216656647-16897-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Mon, 21 Jul 2008 18:10:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 39F61DF8-57AB-11DD-A993-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89437>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Till now 'git merge -s foobar' bailed out with an error message, but
> foobar in pull.twohead or pull.octopus was just silently ignored. It's
> better to inform the user then just silently doing nothing.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

Doesn't this make "git merge -s 'recursive resolve'" to misbehave?
