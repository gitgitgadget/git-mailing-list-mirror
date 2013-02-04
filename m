From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Mon, 4 Feb 2013 10:26:34 -0800
Message-ID: <20130204182634.GC3219@kroah.com>
References: <20130131172805.GC16593@kroah.com>
 <7vzjzpgswz.fsf@alter.siamese.dyndns.org>
 <20130131174103.GA20111@kroah.com>
 <7vr4l1gqv8.fsf@alter.siamese.dyndns.org>
 <20130204004512.GB6243@kroah.com>
 <7vvca8653g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:28:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Qlk-0007oq-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 19:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab3BDS12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 13:27:28 -0500
Received: from mail.kernel.org ([198.145.19.201]:46030 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193Ab3BDS1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 13:27:01 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 13C53204C3;
	Mon,  4 Feb 2013 18:27:01 +0000 (UTC)
Received: from localhost (li262-33.members.linode.com [173.255.252.33])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 52622204C6;
	Mon,  4 Feb 2013 18:27:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vvca8653g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215405>

On Sun, Feb 03, 2013 at 09:05:55PM -0800, Junio C Hamano wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > The number of people this affects right now is only one (me), given that
> > the offending file is not in Linus's tree right now, so he doesn't have
> > issues with uploading new releases.
> 
> As a tree grows larger over time, it may be just a matter of time
> for somebody else to be hit by another deep path, though.

I agree, and over time, everyone will have updated to a version of git
newer than 1.8.2.1 so we all will be fine again :)

thanks,

greg k-h
