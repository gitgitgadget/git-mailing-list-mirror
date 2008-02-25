From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] daemon: Verify base-path and interpolated-path early
Date: Mon, 25 Feb 2008 11:39:56 -0800
Message-ID: <7vejb0j04z.fsf@gitster.siamese.dyndns.org>
References: <47C2C23D.1030609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:41:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjBx-0001HM-Aq
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbYBYTkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbYBYTkK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:40:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbYBYTkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:40:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E7812D63;
	Mon, 25 Feb 2008 14:40:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 694532D60; Mon, 25 Feb 2008 14:40:04 -0500 (EST)
In-Reply-To: <47C2C23D.1030609@viscovery.net> (Johannes Sixt's message of
 "Mon, 25 Feb 2008 14:27:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75054>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Any request to the daemon would fail if either interpolated-path or
> base-path (if specified) would not be absolute. Hence, we can check those
> paths for validity upfront and not start the daemon at all if the paths are
> invalid.
>
> Additionally, we now check that the base-path is an existing directory.

Looks good.  Thanks.
