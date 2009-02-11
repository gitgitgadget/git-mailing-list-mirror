From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Tue, 10 Feb 2009 17:04:11 -0800
Message-ID: <7vskmliy2c.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <20090130023040.GR21473@genesis.frugalware.org>
 <alpine.DEB.1.00.0901301426150.3586@pacific.mpi-cbg.de>
 <20090211001138.GU21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 02:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX3Y3-0000gR-JJ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 02:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbZBKBEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349AbZBKBEW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 20:04:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbZBKBEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 20:04:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E80F2ADC8;
	Tue, 10 Feb 2009 20:04:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17A842ADF6; Tue,
 10 Feb 2009 20:04:12 -0500 (EST)
In-Reply-To: <20090211001138.GU21473@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 11 Feb 2009 01:11:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E9BB8300-F7D7-11DD-A2B0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@frugalware.org> writes:

> [ Sorry for the late reply, I did not read my mail recently. ]
>
> On Fri, Jan 30, 2009 at 02:28:39PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > Shouldn't this be
>> > 
>> > git config receive.denyCurrentBranch ignore
>> > 
>> > instead of "true"?
>> 
>> Right.
>> 
>> However, as Junio pointed out, we do not want to give this resolution in 
>> the error message.  I am now leaning more to something like
>> 
>> 	refusing to update checked out branch '%s' in non-bare repository
>> 
>> Hmm?
>> 
>> Old-timers will know "oh, what the hell, I did not mark my repository as 
>> bare!", and new-timers will no longer be confused.
>
> So in an "I know what I'm doing" mode, is "git config core.bare true" in
> a non-bare repo considered as a better workaround than using "git config
> receive.denyCurrentBranch ignore"?

If you have to ask, you do not know what you're doing ;-)
