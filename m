From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default, was Re: What's cooking in git.git (Mar 2009, #04;
 Sat, 14)
Date: Tue, 17 Mar 2009 18:05:25 -0700
Message-ID: <7vwsanod2i.fsf@gitster.siamese.dyndns.org>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903171125420.6393@intel-tinevez-2-302>
 <20090318063053.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0903172350270.10279@pacific.mpi-cbg.de>
 <7vab7jpv93.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903180138210.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:07:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkFP-0004qj-KN
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbZCRBFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbZCRBFf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:05:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZCRBFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:05:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B48B727C;
	Tue, 17 Mar 2009 21:05:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC7DD727B; Tue,
 17 Mar 2009 21:05:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903180138210.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 18 Mar 2009 01:40:39 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E09F79A6-1358-11DE-9F62-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113548>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In my git.git clone on one machine, I have remote.orcz.push = master.  I 
> cloned it.  There, "git push" does something different.
>
> Inconsistent right there, correct?  Without any change to git.git.

You must be smoking something potent.  It's a nonsense argument and you
know it.

In your git.git clone on one machine, you have some setting.

You cloned it to one machine some time ago.  It behave differently and
that is something that has always been true, and you know it.  Repository
configuration is private.

You clone it to another today.  Now the new clone, without any
configuration, will behave differently from the other clone, that you
haven't done any funny configuration.

That's inconsistent.
