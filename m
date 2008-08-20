From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Wed, 20 Aug 2008 11:22:43 -0700
Message-ID: <7v3akzsg0c.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
 <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsLc-0004gb-0N
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYHTSWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYHTSWv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:22:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYHTSWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:22:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0ADD4604C6;
	Wed, 20 Aug 2008 14:22:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0608B604C5; Wed, 20 Aug 2008 14:22:44 -0400 (EDT)
In-Reply-To: <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed, 20 Aug 2008 23:58:14 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE60DE58-6EE4-11DD-A0A2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93007>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On second thought, I don't think the patch's worth it. The code in
> git-completion.bash is a hack and I replace it with another the hack.
> It won't work for custom merges and git-completion.bash will need to
> be synced manually anyway, so maybe this patch will do better:

This would be the right thing to do for the 'maint' track.  In the longer
term, especially if we are to actually make the "custom" thing official, I
think teaching "git-merge" to report what are available is the only
sensible approach, though.
