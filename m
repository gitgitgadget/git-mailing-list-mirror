From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix naming scheme for configure cache variables.
Date: Wed, 21 Jan 2009 02:26:47 -0800
Message-ID: <7v7i4peyzc.fsf@gitster.siamese.dyndns.org>
References: <20090119203436.GB3539@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 11:28:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaJp-0000v6-DN
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbZAUK0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 05:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbZAUK0y
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:26:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbZAUK0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:26:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8391923EA;
	Wed, 21 Jan 2009 05:26:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AAE36923E9; Wed,
 21 Jan 2009 05:26:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0527FFAC-E7A6-11DD-A64E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106590>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> In order to be cached, configure variables need to contain the
> string '_cv_', and they should begin with a package-specific
> prefix in order to avoid interfering with third-party macros.
> Rename ld_dashr, ld_wl_rpath, ld_rpath to git_cv_ld_dashr etc.
>
> Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>

Thanks.
