From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/13] remote: make get_remote_ref_states() always
 populate states.tracked
Date: Mon, 23 Feb 2009 17:34:26 -0800
Message-ID: <7vvdr0pqhp.fsf@gitster.siamese.dyndns.org>
References: <cover.1235368324.git.jaysoffian@gmail.com>
 <2185ca69c518d60276ba1bc613b7699a6bca7c68.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmDT-0001gq-Lz
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbZBXBef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbZBXBef
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:34:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbZBXBef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:34:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 989099CE3A;
	Mon, 23 Feb 2009 20:34:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 973EA9CE37; Mon,
 23 Feb 2009 20:34:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 495AE8F6-0213-11DE-AE7A-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111189>

Does this series _semantically_ depend on topics other than your other
"set HEAD" topic that is still not in 'master'?

I see you made it cleanly apply on top of 'pu', but frankly, I really hate
to see a series based on 'pu' as a matter of principle and discipline.

Other topics in 'pu' may not be ready for a long time, and you do not want
this series to be taken hostage to them.  Having to fork your topic off of
many other topics not even in 'next' means it would be more cumbersome for
me to handle your series when any of the other topics that you base your
work on need to be discarded or replaced.

In other words, you make your series unworkable with if you introduce too
many dependencies.

I've rebased it on top of Peff's jk/head-lookup topic (which in turn
depends on your js/remote-set-head topic), but I suspect that you would
want this series fork from and only depend on js/remote-set-head topic.
In any case, please check the result after I push the results out to make
sure that I did not make any silly mistakes while rebasing the series.

I also suspect that you would want to reroll the entire series anyway; see
separate comments on 10/13 and 11/13.

Thanks.
