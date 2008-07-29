From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --squash isn't "marked as a merge"??
Date: Tue, 29 Jul 2008 01:53:55 -0700
Message-ID: <7vbq0hhxzw.fsf@gitster.siamese.dyndns.org>
References: <488ECB89.5060801@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 10:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkz4-0004A4-Cc
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbYG2IyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 04:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbYG2IyE
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:54:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbYG2IyE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 04:54:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84BA740D64;
	Tue, 29 Jul 2008 04:54:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7CFFB40D62; Tue, 29 Jul 2008 04:53:58 -0400 (EDT)
In-Reply-To: <488ECB89.5060801@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Tue, 29 Jul 2008 09:49:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E31B5F6A-5D4B-11DD-B899-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90606>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

> Newbie alert:
>
> I have a feature branch where I have N tiny commits with sloppy/priva=
te
> commit messages....

Probably you would want to step back and _think_ why you want to squash=
 in
the first place.  I suspect the answer would lead to a better use of th=
e
available set of tools, such as "use 'rebase -i' to clean up the origin=
al
history and then 'merge' (without squash) it or 'rebase' it".
