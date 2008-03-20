From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 17:51:45 -0700
Message-ID: <7vwsnyz07y.fsf@gitster.siamese.dyndns.org>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc91O-0003zl-Rp
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYCTAv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYCTAv7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:51:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYCTAv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:51:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 187DE13E7;
	Wed, 19 Mar 2008 20:51:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8AC5E13E6; Wed, 19 Mar 2008 20:51:54 -0400 (EDT)
In-Reply-To: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org> (John
 Goerzen's message of "Wed, 19 Mar 2008 18:21:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77605>

John Goerzen <jgoerzen@complete.org> writes:

> # Now here comes bug #1...

Please try 1.5.5-rc0 or newer.  I think Linus's unpack_trees() updates,
even though it was sort of a rocky road to get there, addresses this.

Namely, v1.5.5-rc0~25 was the commit that fixed this issue.

> # Set up bug #2

This hasn't been addressed, I think.
