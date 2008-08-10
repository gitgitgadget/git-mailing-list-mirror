From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git log --check to return an appropriate error code
Date: Sun, 10 Aug 2008 11:40:18 -0700
Message-ID: <7vk5eo3e99.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
 <alpine.DEB.1.00.0808091404230.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7v8wv66l8d.fsf@gitster.siamese.dyndns.org> <489F1FE4.6090400@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 20:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFr6-0004XI-UW
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbYHJSk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 14:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYHJSk1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:40:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYHJSk0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2008 14:40:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56C8753DF0;
	Sun, 10 Aug 2008 14:40:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A17B153DEF; Sun, 10 Aug 2008 14:40:21 -0400 (EDT)
In-Reply-To: <489F1FE4.6090400@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Sun, 10 Aug 2008 19:05:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CB400C78-670B-11DD-8CFA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91871>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

>> One interesting option that might be interesting to add to the log f=
amily
>> would be to show only commits that fail the checkdiff tests.  I susp=
ect
>> necessary change for doing so would go to log_tree_diff() codepath.
>
> I'm hoping that this is meant as "aside from this current patch, one
> interesting option..." or do you mean "in order for this patch to be
> accepted, I suggest this to be added ..." ?

Sorry, not the latter.  I'll try to be clear in the future.
