From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix misdetection of relative pathnames
Date: Thu, 05 Feb 2009 09:19:31 -0800
Message-ID: <7v1vucg5ss.fsf@gitster.siamese.dyndns.org>
References: <4985E8E1.90303@gmail.com>
 <7vhc39guv2.fsf@gitster.siamese.dyndns.org> <498ADB1B.7030300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7ua-0000J1-4Y
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZBERTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbZBERTo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:19:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZBERTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:19:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C5EB977F0;
	Thu,  5 Feb 2009 12:19:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 854EB977EE; Thu,
  5 Feb 2009 12:19:33 -0500 (EST)
In-Reply-To: <498ADB1B.7030300@viscovery.net> (Johannes Sixt's message of
 "Thu, 05 Feb 2009 13:27:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C0DAA72-F3A9-11DD-B8E1-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108584>

Johannes Sixt <j.sixt@viscovery.net> writes:

> That said, I don't think it's worth to cater for this use-case, precisely
> because we want to *avoid* absolute paths on Windows anyway, and apply the
> change that you proposed here.
>
> [*] The reason it does not work is that we cannot use MSYS-style absolute
> paths /c/Foo/Bar because the paths will be interpreted by git, which does
> not understand them; the user must specify drive-letter absolute paths
> c:/Foo/Bar, but the check does not catch them.

Hmm, not c:\Program Files\Git?

In any case, thanks for an Ack.  It clears one remaining issue for -rc0
(and there are certainly others I have forgot).
