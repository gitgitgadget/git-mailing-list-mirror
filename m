From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: utilize core.warnambiguousrefs for
 strict refname:short format
Date: Fri, 17 Oct 2008 16:58:56 -0700
Message-ID: <7vod1ieptr.fsf@gitster.siamese.dyndns.org>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 02:00:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzF0-0003Ro-0B
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 02:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbYJQX7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbYJQX7F
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:59:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbYJQX7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:59:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 043028B6AE;
	Fri, 17 Oct 2008 19:59:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9175E8B6AB; Fri, 17 Oct 2008 19:58:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 92F627FE-9CA7-11DD-BE37-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98508>

Shawn, was there any issue with this one?  The patch changes the function
signature for no good reason (at least, it does not have anything to do
with the stated purpose of the change), but other than that, I think what
it attempts to do makes sense.
