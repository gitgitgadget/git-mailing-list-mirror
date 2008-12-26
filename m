From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-tree: add --full-tree option
Date: Fri, 26 Dec 2008 00:55:59 -0800
Message-ID: <7vmyejpb6o.fsf@gitster.siamese.dyndns.org>
References: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org>
 <200812260916.45401.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Deskin Miller <deskinm@umich.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Dec 26 09:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG8Vb-0007DC-JI
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 09:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbYLZI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 03:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYLZI4J
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 03:56:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbYLZI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 03:56:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 272198AFF3;
	Fri, 26 Dec 2008 03:56:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5EE198AFF2; Fri,
 26 Dec 2008 03:56:01 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 075B9DCC-D32B-11DD-92AC-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103925>

Johannes Sixt <j6t@kdbg.org> writes:

> On Freitag, 26. Dezember 2008, Junio C Hamano wrote:
>> This new option makes the command operate on the full tree object,
>> regardless of where in the work tree it is run from.  It also implies the
>> behaviour that is triggered by the existing --full-name option.
>
> What's wrong with using 'git ls-tree ${rev}:'?
>
> Except that it does not work...

Hmph... you seem to be describing the exact issue they discussed on #git,
which triggered the patch in the message you are responding to.  I am not
sure what to say to your "What's wrong with...".
