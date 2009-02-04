From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/1] git-tag: Add --regex option
Date: Tue, 03 Feb 2009 23:47:43 -0800
Message-ID: <7vljsm3aow.fsf@gitster.siamese.dyndns.org>
References: <1233677512-1846-1-git-send-email-goulding@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 08:49:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUcVZ-0003Jr-UB
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 08:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbZBDHrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 02:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZBDHrt
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 02:47:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZBDHrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 02:47:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FF492A67F;
	Wed,  4 Feb 2009 02:47:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4ADD82A67B; Wed, 
 4 Feb 2009 02:47:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1DCB6090-F290-11DD-BB8D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108307>

Jake Goulding <goulding@vivisimo.com> writes:

> Allows the tag pattern to be expressed as a regular expression.

We use shell globs for refname throughout the system (not just tags).  Why
is this a good thing, other than "because we can"?
