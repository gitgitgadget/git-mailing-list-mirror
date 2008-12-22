From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Move-delete merge conflict is not displayed using git ls-files
 --unmerged
Date: Mon, 22 Dec 2008 12:48:09 -0800
Message-ID: <7v4p0whr7a.fsf@gitster.siamese.dyndns.org>
References: <85647ef50812220629o46134a70waf159bb6cd6d6e72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 21:49:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEria-0001VD-Ct
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 21:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbYLVUsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 15:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYLVUsS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 15:48:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYLVUsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 15:48:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB0D389096;
	Mon, 22 Dec 2008 15:48:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0BE1D89090; Mon,
 22 Dec 2008 15:48:10 -0500 (EST)
In-Reply-To: <85647ef50812220629o46134a70waf159bb6cd6d6e72@mail.gmail.com>
 (Constantine Plotnikov's message of "Mon, 22 Dec 2008 17:29:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB3F9D56-D069-11DD-9F50-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103766>

"Constantine Plotnikov" <constantine.plotnikov@gmail.com> writes:

> I think that if git merge reports the conflicts, such conflicts should
> be discoverable using git ls-files and prevent commit with resolving
> the conflict like it is done with modify-delete conflicts.

Yeah, I think so, too.
