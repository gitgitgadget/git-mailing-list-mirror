From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sun, 15 Feb 2009 20:16:47 -0800
Message-ID: <7v1vtzf234.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 05:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuw8-0007Zx-Qc
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbZBPERA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbZBPERA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:17:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948AbZBPEQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:16:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BE3DA2B397;
	Sun, 15 Feb 2009 23:16:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 02FA82B38D; Sun,
 15 Feb 2009 23:16:53 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 15 Feb 2009 12:21:44 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A69E7034-FBE0-11DD-B0C4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110135>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In the name of consistency, I'd rather leave show-branch as it is.

Yes, Nana explained why I was wrong on this one.

> However, IMO there is a much worse issue lurking: people might want to 
> _know_ what "@{-2}" would expand to, _without_ switching branches.

"git branch --history" anyone?
