From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] rebase simplifications
Date: Tue, 27 Jan 2009 14:50:54 -0800
Message-ID: <7vab9c1hyp.fsf@gitster.siamese.dyndns.org>
References: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901272323530.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwo1-0000cY-El
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbZA0WvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbZA0WvF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:51:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZA0WvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:51:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77A35949F6;
	Tue, 27 Jan 2009 17:51:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 43A06949F3; Tue,
 27 Jan 2009 17:50:55 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901272323530.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 27 Jan 2009 23:34:15 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7B81E14-ECC4-11DD-8A4E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107413>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes vs  v1:
>
> removed the "rnyn" blurt (which probably marsk me as Alpine user...)
>
> removed the SHELL_PATH handling; it is a miracle to me why it works, but 
> I'd rather not meddle with the magic now that you pointed it out
>
> Moved test_commit and test_merge into test-lib.sh
>
> Fixed the quoting in test_commit and test_merge
>
> AFAIR that's all...

Thanks; looks much nicer (not just relative to v1 but compared to the
original).
