From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Fri, 06 Jun 2008 14:00:09 -0700
Message-ID: <7vd4muth2e.fsf@gitster.siamese.dyndns.org>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
 <20080604154523.GA25747@kroah.com>
 <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
 <20080605040315.GA21798@kroah.com>
 <7vabi05xl1.fsf@gitster.siamese.dyndns.org>
 <20080605050855.GA22825@kroah.com>
 <alpine.LNX.1.00.0806051546480.19665@iabervon.org>
 <7vzlpzzi8c.fsf@gitster.siamese.dyndns.org>
 <20080606204814.GE11209@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4j3s-0006NT-WD
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306AbYFFVA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbYFFVA0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:00:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209AbYFFVAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:00:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E6262C93;
	Fri,  6 Jun 2008 17:00:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 873CC2C8F; Fri,  6 Jun 2008 17:00:12 -0400 (EDT)
In-Reply-To: <20080606204814.GE11209@kroah.com> (Greg KH's message of "Fri, 6
 Jun 2008 13:48:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 92E933FA-340B-11DD-81A7-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84114>

Greg KH <greg@kroah.com> writes:

> On Thu, Jun 05, 2008 at 02:26:11PM -0700, Junio C Hamano wrote:
>
>> However, I think /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ would
>> result in the same breakage, and that is something I consider gravely
>> broken.
>
> Yeah, especially as I never realized that /pub/ was a symlink in the
> first place :)

And it was even worse than that.  Even if you knew /pub was a symlink, you
could not have done anything about it, short of editing the alternates
file in the resulting repository by hand.

Up until now, that is.

Daniel's patch seems to fix the issue for me and it will be included in
tonight's pushout among other fixes.

Thanks.
