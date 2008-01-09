From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change git-gc documentation to reflect gc.packrefs implementation.
Date: Wed, 09 Jan 2008 12:25:49 -0800
Message-ID: <7vsl16hhki.fsf@gitster.siamese.dyndns.org>
References: <20080109160516.GA31535@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian La Roche <laroche@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:26:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChVK-0003Fs-6S
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbYAIUZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbYAIUZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:25:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbYAIUZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:25:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 320873626;
	Wed,  9 Jan 2008 15:25:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7533625;
	Wed,  9 Jan 2008 15:25:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70008>

Florian La Roche <laroche@redhat.com> writes:

> Adjust git-gc documentation to reflect gc.packrefs implementation.
>
> Adjust git-gc documentation to reflect gc.packrefs implementation.
>
> Signed-off-by: Florian La Roche <laroche@redhat.com>

Thanks.

I rephrased the above (three almost identical lines) to:

    56752391a8c0c591853b276e4fa0b45c34ced181 (Make "git gc" pack all
    refs by default) changed the default of gc.packrefs to true, to
    pack all refs by default in any repository.  IOW, the users need
    to disable it explicitly if they want to by setting the config
    variable, since 1.5.3.

    However, we forgot to update the documentation.  This fixes it.

and applied.
