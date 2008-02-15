From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] hard-code the empty tree object
Date: Fri, 15 Feb 2008 09:11:56 -0800
Message-ID: <7vabm2i1pf.fsf@gitster.siamese.dyndns.org>
References: <20080214103256.GA17951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ47N-00005s-MO
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYBORMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYBORMT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:12:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbYBORMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:12:17 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A855F23A3;
	Fri, 15 Feb 2008 12:12:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 E8DB023A1; Fri, 15 Feb 2008 12:12:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73962>

Jeff King <peff@peff.net> writes:

> We also hard-code the special ref '{}' as an alias for the
> empty tree. Users may refer to the empty tree by its
> sha1 or by '{}'.

I think the users of hard coded empty tree are oddballs.  Let's
not be too cute and instead leave it in the add -i patch.  {} is
already too cute.
