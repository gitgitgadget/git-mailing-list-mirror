From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t3404 & t3411: undo copy&paste
Date: Tue, 27 Jan 2009 14:46:33 -0800
Message-ID: <7veiyo1i5y.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
 <20090127085418.e113ad5a.stephen@exigencecorp.com>
 <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901271845380.3586@pacific.mpi-cbg.de>
 <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901272254450.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwj0-00070k-Ki
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZA0Wqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbZA0Wqm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:46:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbZA0Wql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:46:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E3161D6A0;
	Tue, 27 Jan 2009 17:46:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5F55F1D696; Tue,
 27 Jan 2009 17:46:35 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901272254450.14855@racer> (Johannes
 Schindelin's message of "Tue, 27 Jan 2009 22:57:33 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C9B6C74-ECC4-11DD-9807-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107410>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +		sed -n "${line}p" < "$1".tmp
>> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
>> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp
>
>
> Probably.  It is for debugging, anyway.  As everything you only see with 
> -v.

Exactly.  That is why I'd rather want to see what exact insn sequence is
being fed to the "rebase -i".  Because I'd be debugging my new test or
changes to "rebase -i", not debugging fake-editor's use of sed.
