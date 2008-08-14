From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be
 cached
Date: Wed, 13 Aug 2008 23:29:06 -0700
Message-ID: <7vwsikds99.fsf@gitster.siamese.dyndns.org>
References: <489DBB8A.2060207@griep.us>
 <1218470035-13864-1-git-send-email-marcus@griep.us>
 <1218470035-13864-2-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 08:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTWLl-0006jc-6N
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 08:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYHNG3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 02:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbYHNG3P
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 02:29:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYHNG3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 02:29:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C95D058479;
	Thu, 14 Aug 2008 02:29:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E28DA58478; Thu, 14 Aug 2008 02:29:08 -0400 (EDT)
In-Reply-To: <1218470035-13864-2-git-send-email-marcus@griep.us> (Marcus
 Griep's message of "Mon, 11 Aug 2008 11:53:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F71C12E-69CA-11DD-9CF2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92325>

Marcus Griep <marcus@griep.us> writes:

> This patch offers a generic interface to allow temp files to be
> cached while using an instance of the 'Git' package....

By the way, I think your commit title has a typo: s/cul/cili/.  I've
already pulled this via Eric, so it will stay in the history forever,
though...
