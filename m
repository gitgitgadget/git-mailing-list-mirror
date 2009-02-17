From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] config: Cleanup editor action.
Date: Mon, 16 Feb 2009 18:28:56 -0800
Message-ID: <7vskmdaj9z.fsf@gitster.siamese.dyndns.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-5-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-6-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-7-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFjF-00058o-WE
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbZBQC3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbZBQC3G
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:29:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZBQC3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:29:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 322909A068;
	Mon, 16 Feb 2009 21:29:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E4D7A9A067; Mon,
 16 Feb 2009 21:28:58 -0500 (EST)
In-Reply-To: <1234832094-15541-8-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 17 Feb 2009 02:54:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDE187C6-FC9A-11DD-8DE2-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110298>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Copy-paste from Johannes Schindelin.

Sorry, I do not understand.  Are you saying:

 (1) This duplicated code was introduced by copy-and-paste by Dscho and I
     am cleaning up his mess?

or

 (2) This change came from Dscho and I am just sending it by copy-pasting
     what he did?

If the latter, then this is not a good way to describe what happened.  You
would use in-body From: header to give attribution, and more importantly,
you need to say what you would usually say in the commit log message (what
it does, why the original is bad, etc.)
