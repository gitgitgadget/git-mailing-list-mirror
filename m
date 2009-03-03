From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add an option for git-archive to output commit ID in
 alternative ways
Date: Tue, 03 Mar 2009 07:44:28 -0800
Message-ID: <7vtz6ad31f.fsf@gitster.siamese.dyndns.org>
References: <1236078904678-2414580.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: roylee17 <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWpJ-0004jC-0s
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756816AbZCCPoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbZCCPoi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:44:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbZCCPoh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:44:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55F709E417;
	Tue,  3 Mar 2009 10:44:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 653019E416; Tue,
  3 Mar 2009 10:44:30 -0500 (EST)
In-Reply-To: <1236078904678-2414580.post@n2.nabble.com> (roylee17@gmail.com's
 message of "Tue, 3 Mar 2009 03:15:04 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 310C80A0-080A-11DE-8D61-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112091>

roylee17 <roylee17@gmail.com> writes:

> Consider the following use case:
>   Regularly building projects which are untar'ed on-the-fly with git-archive
> without intermediate tar balls.
>
> How can I track back which commit IDs were those source code git-archive
> from?

Run "man gitattributes" and look for export-subst?
