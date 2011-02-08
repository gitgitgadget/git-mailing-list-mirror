From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP] checkout: introduce --detach synonym for "git
 checkout foo^{commit}"
Date: Mon, 7 Feb 2011 18:55:55 -0600
Message-ID: <20110208005555.GC24340@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
 <20110208005238.GB24340@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:56:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmbsI-00016B-Ex
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab1BHA4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:56:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55213 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab1BHA4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:56:03 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3797240qwa.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 16:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+yd2Y/KtB8Ieu0/iIsfEsTAkWYbhyivr/tFfRWkxWXE=;
        b=gpSv8HyF56l2QvBC7wBqZLK+2qVXoiMkMCyrKfrHFkRgcqFuva8BHMHoEFYI/0d0UD
         urXJq3RENOb7bhZvCYT8ZzwS8x9xqm+tavzFdABZlUTlSzQTgm9H2F8dYzyLP0fcP/V1
         0cjcbZFSim/G2ipv5TfZkYR9DJtlOhSC6KbVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ukrgbAdXMEolOsQ95+g9RH9eS2YYOAMQXKIzYCOn4YW0hfiJc5NRfHK8q339U2Obkx
         qMsy9kzskkr1FahAjwhTLvfxfwFDPCdkxejumjMVVdjektUXSLmUyDG6OH14h8aiAGsP
         zIWgZrjWyPIKrXx5bG9LuTvHxv8q40ptZUk/4=
Received: by 10.224.19.145 with SMTP id a17mr14644710qab.208.1297126559465;
        Mon, 07 Feb 2011 16:55:59 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id p13sm3172962qcu.41.2011.02.07.16.55.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 16:55:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208005238.GB24340@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166320>

Jonathan Nieder wrote:

> Jeff King wrote:
>
>> Jonathan, do you want to roll all of these up into a single patch?
>
> Okay, here it is.

Ah, should have mentioned: this applies on top of a merge of
en/and-cascade-tests~25 (aka v1.7.4-rc0~65^2~19, test-lib: make
test_expect_code a test command, 2010-10-03) and
uk/checkout-ambiguous-ref.
