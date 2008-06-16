From: Junio C Hamano <gitster@pobox.com>
Subject: Re: using git-blame with patches as input
Date: Mon, 16 Jun 2008 15:08:00 -0700
Message-ID: <7v4p7t9gov.fsf@gitster.siamese.dyndns.org>
References: <20080616213517.GE20727@redhat.com>
 <7vabhl9hap.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Msr-00058j-Tj
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411AbYFPWIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYFPWIK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:08:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbYFPWIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 18:08:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 793F6D81A;
	Mon, 16 Jun 2008 18:08:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EDF2ED819; Mon, 16 Jun 2008 18:08:02 -0400 (EDT)
In-Reply-To: <7vabhl9hap.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 16 Jun 2008 14:54:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B28E2F52-3BF0-11DD-A658-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85240>

Junio C Hamano <gitster@pobox.com> writes:

> Don Zickus <dzickus@redhat.com> writes:
> ...
>> ...  Unfortunately, I don't quite understand
>> some of the algorithms git-blame does when it splits the patch chunks into
>> smaller pieces to determine which pieces are blame-able on the parents.
>
> http://thread.gmane.org/gmane.comp.version-control.git/28826

In the article quoted, "blame" refers to a very old "git-blame" code that
does not in our codebase anymore.  It talks about "git-pickaxe" which
later took over the "git-blame" name, which happend in acca687
(git-pickaxe: retire pickaxe, 2006-11-08).

It talks about "NEEDSWORK" to hint that the implementation was incomplete,
refering to the version that eventually lead to cee7f24 (git-pickaxe:
blame rewritten., 2006-10-19).
