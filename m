From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo
 with git protocol?
Date: Wed, 17 Dec 2008 01:09:15 -0800
Message-ID: <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Emily Ren" <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCsQT-00020W-R7
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbYLQJJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbYLQJJW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:09:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbYLQJJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 04:09:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 17BD98855E;
	Wed, 17 Dec 2008 04:09:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 525628855C; Wed,
 17 Dec 2008 04:09:17 -0500 (EST)
In-Reply-To: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
 (Emily Ren's message of "Wed, 17 Dec 2008 17:03:07 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 637575B4-CC1A-11DD-8202-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103325>

"Emily Ren" <lingyan.ren@gmail.com> writes:

> I created a repository, and I don't want somebody to pull some branch
> or tag from my repository with git protocol. How can I do ?

By not putting that tag or branch in that repository (note that you can
have a repository only to publish which is different from your main
working repository).
.
