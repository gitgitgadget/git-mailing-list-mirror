From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] parse-opt: migrate builtin-ls-files.
Date: Wed, 14 Jan 2009 19:16:38 -0800
Message-ID: <7vljtdw961.fsf@gitster.siamese.dyndns.org>
References: <20090107144640.GD831@artemis.corp>
 <1231376145-32331-1-git-send-email-vmiklos@frugalware.org>
 <20090115001410.GE30710@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 04:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNIkF-0007D2-Bj
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 04:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbZAODQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 22:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbZAODQr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 22:16:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbZAODQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 22:16:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 742D01C8CF;
	Wed, 14 Jan 2009 22:16:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 190CE1C8CC; Wed,
 14 Jan 2009 22:16:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F04D4E54-E2B2-11DD-85CA-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105759>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Was this dropped on the floor by accident?

I am not fundamentally opposed to the parseopt conversion, but I was
somewhat discouraged from taking another one, after we got burned by the
one that converted git-apply without much visible gain but with a new bug.

Because ls-files is a plumbing, it has somewhat lower priority for user
friendliness than any other patches currently in-flight on the list; hence
it has been backburnered.  It still is kept in my Inbox.
