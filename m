From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to update git on Mac OS X Mountain Lion 10.8.4
Date: Fri, 28 Jun 2013 13:12:22 -0700
Message-ID: <7v4ncingex.fsf@alter.siamese.dyndns.org>
References: <CAN_-5Z94-OV7rHYf+mUuf_xanxu0+odwovv0mpB4GRHVsjccDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olivier de Broqueville <olivier.debroqueville@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 22:12:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usf1x-0005BZ-Lf
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 22:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab3F1UM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 16:12:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926Ab3F1UMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 16:12:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C52682CAF9;
	Fri, 28 Jun 2013 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eQkltpqS7L2UIDr3AOykm4erSxQ=; b=jT3FPT
	JyWye7XCuefosKp9kVpFz2OqaeYfR7IobZSuB4bZasSfVaFOywwNbyN3ZCvj4M58
	ooX0s4cgb+6tVKrAuMEabiRAPpQYcGlitSo4bJai6kCM00MMfzjpM5K1L5WLywzW
	rVJQx+41PUg5qOvmQxb9FW/wYSHdnZdXkCe6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AJTQxfKTDmUGNbxZ/ZvhwecZL3mqZrEF
	acqY2egMASU2/6ks9QYAAoPaI89fWrP00Szwa6hYhlWtVqSjUK7OANmm7IXZhuLt
	Ar2GWPnjVf1jStvcrF0tffFwELndRVhlsemMMUGw7zzC5L97b8n6EuibW4VaHbOw
	bV4U5dM2BYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB88B2CAF8;
	Fri, 28 Jun 2013 20:12:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F15B2CAF7;
	Fri, 28 Jun 2013 20:12:24 +0000 (UTC)
In-Reply-To: <CAN_-5Z94-OV7rHYf+mUuf_xanxu0+odwovv0mpB4GRHVsjccDw@mail.gmail.com>
	(Olivier de Broqueville's message of "Fri, 28 Jun 2013 21:31:38
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BD8AF8C-E02F-11E2-A1F9-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229230>

Olivier de Broqueville <olivier.debroqueville@gmail.com> writes:

> Hello,
>
> I've learnt that Xcode installs git by default on the Mac. My current
> version of git is 1.7.12.4 and it's located in /usr/bin/git.
>
> I wanted to update git to the latest stable version available:
> 1.8.3.1. I proceeded with the instructions on:
> http://git-scm.com/downloads and typed:
>
> git clone https://github.com/git/git.git
>
> (rather than using the .dmg file because I don't want to install a new
> version of git in addition to the existing one used by Xcode.
> Furthermore, I have no idea where the new version would end up being
> installed and I've read that users have had trouble doing this!)
>
> This rendered the following results:
> Oliviers-iMac:~ odebroqueville$ git clone https://github.com/git/git.git
> Cloning into 'git'...
> remote: Counting objects: 157697, done.
> remote: Compressing objects: 100% (53116/53116), done.
> remote: Total 157697 (delta 114700), reused 143715 (delta 102625)
> Receiving objects: 100% (157697/157697), 39.56 MiB | 2.01 MiB/s, done.
> Resolving deltas: 100% (114700/114700), done.
> Oliviers-iMac:~ odebroqueville$ which git
> /usr/bin/git
> Oliviers-iMac:~ odebroqueville$ git --version
> git version 1.7.12.4 (Apple Git-37)
>
> As you can see, nothing seems to have changed!
>
> Would you have any explanations?

You seem to have successfully downloaded the source, but I do not
see the steps you built and installed the downloaded source.

I think that would be a sufficient explanation?
