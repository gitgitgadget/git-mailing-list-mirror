From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT over ssh with identity file
Date: Wed, 04 Feb 2009 01:25:06 -0800
Message-ID: <7veiyezh8t.fsf@gitster.siamese.dyndns.org>
References: <21826348.post@talk.nabble.com>
 <7vbpti1tnd.fsf@gitster.siamese.dyndns.org> <vpqhc3aa8m0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: oliverw <oliver@weichhold.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUe1z-0006d4-QQ
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZBDJZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbZBDJZP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:25:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZBDJZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:25:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B40AC2A68A;
	Wed,  4 Feb 2009 04:25:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DC53F2A667; Wed, 
 4 Feb 2009 04:25:07 -0500 (EST)
In-Reply-To: <vpqhc3aa8m0.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 04 Feb 2009 09:50:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B8E4A958-F29D-11DD-9259-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108323>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>     $ cat >>$HOME/.ssh/config <<\EOF
>>     Host homer-at-foo
>>       Hostname foo.bar.com
>>       User homer
>>       IdentityFile ~/.ssh/homer-at-foo.pub
>
> (I think you have an extra .pub here, the identity file should be the
> private key).

Yeah, you are right.  I am too tired and should have gone to bed 90
minutes ago.
