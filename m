From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: give a proper error message for invalid
 strategies in config
Date: Tue, 22 Jul 2008 01:24:14 -0700
Message-ID: <7v7ibenx75.fsf@gitster.siamese.dyndns.org>
References: <1216656647-16897-1-git-send-email-vmiklos@frugalware.org>
 <7vr69mpl5v.fsf@gitster.siamese.dyndns.org>
 <20080722073912.GN32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 10:25:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLDBT-0001Ya-T2
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 10:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYGVIYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 04:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYGVIYV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 04:24:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYGVIYU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 04:24:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69E8E340C6;
	Tue, 22 Jul 2008 04:24:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DB1F0340C5; Tue, 22 Jul 2008 04:24:16 -0400 (EDT)
In-Reply-To: <20080722073912.GN32057@genesis.frugalware.org> (Miklos Vajna's
 message of "Tue, 22 Jul 2008 09:39:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9499D0EE-57C7-11DD-A214-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89470>

Miklos Vajna <vmiklos@frugalware.org> writes:

> ... I
> would like to send a patch that changes the config parsing as well, so
> that pull.twohead "foo bar" would be invalid, and the user would have to
> have two pull.twohead entries: one for foo and one for bar.

Don't.  pull.* has always been defined as "list of strategies", and -s has
always been defined to take "a" strategy.

IOW, you don't need to break anything further.
