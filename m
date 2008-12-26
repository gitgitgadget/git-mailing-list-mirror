From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitrepository-layout: No longer first two letters. Also
 add "down".
Date: Fri, 26 Dec 2008 13:30:40 -0800
Message-ID: <7vmyeilj3z.fsf@gitster.siamese.dyndns.org>
References: <7veizuog2z.fsf@gitster.siamese.dyndns.org>
 <87skoau1su.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 26 22:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGKI4-0003Rs-1n
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 22:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbYLZVaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 16:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYLZVav
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 16:30:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYLZVau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 16:30:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E212D1B25F;
	Fri, 26 Dec 2008 16:30:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B62E41B25D; Fri,
 26 Dec 2008 16:30:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75649E7C-D394-11DD-94A1-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103951>

jidanni@jidanni.org writes:

>>>>>> "JCH" == Junio C Hamano <gitster@pobox.com> writes:
>
> JCH> If that is the case, please justify why you think it is better not to say
> JCH> "first two letters" the documentation.
> OK, I saw
> $ ls 3d
> 05a66c3..
> 189066f..
> If it were the first to letters, it would be
> $ ls 3d
> 3d05a66c3..
> 3d189066f..
> Ah, you mean it snaps them off to form the directory name?! OK, please
> note that.

If you read the description again, you will notice that the entry explains
what these directories are; it is not a description about the files in
these directories.

> As far as all your other points and messed up To:, OK, next time I will do better.

When sending the fixed-up patch, please send it in an applicable form.  I
do not know how you stripped "Documentation/" from the front, but your
patch was against {a,b}/gitrepository-layout.txt.

Thanks.
