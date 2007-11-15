From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clean won't read global ignore
Date: Thu, 15 Nov 2007 09:27:42 -0800
Message-ID: <7v7ikj5shd.fsf@gitster.siamese.dyndns.org>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
	<vpqbq9vlt3k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsiVc-0007uO-8D
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbXKOR1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbXKOR1w
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:27:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56433 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbXKOR1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:27:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2531B2FA;
	Thu, 15 Nov 2007 12:28:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FA0A9606F;
	Thu, 15 Nov 2007 12:28:06 -0500 (EST)
In-Reply-To: <vpqbq9vlt3k.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu,
	15 Nov 2007 11:07:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65141>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> At last, I'll be able to write
>
> $ git ls-files -o --exclude-standard >> .gitignore
> $ $EDITOR .gitignore

I think this is a good cookbook material to put somewhere in the
docs.
