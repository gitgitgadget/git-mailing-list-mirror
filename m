From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 20:26:09 -0800
Message-ID: <20130211042609.GC15329@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kyb-0007oH-9c
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab3BKE0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:26:21 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:32919 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3BKE0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:26:17 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so516595pbb.6
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 20:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VQcDoWZ6GjT34lb8Ki82eAlHFB8KXNC1X4gktmYd0xw=;
        b=Q0xD6v9ka3WhpxG33qOk697tEy8xsIkGqYw7ECmS93nPK3LaeN7BEmSHkRgAoHZjWY
         sVHg7Z40F0aRrlqqQteMN2TlwZ/MAZtT8aZX7vgKxQ5WCAKswTlB1CxmTDjueIjknzRi
         cRCA/6qB0lMA9oP/En1yyfUIkIfq5koDJmXGBkdofAivgrlBAytCmgXMVakcaAOK6A1m
         RO1zFH2Q/TVnOQDDsOSKvliM1/dAv9gzF7+DGScyK79fhje4oR8baBS2v1SJpF1crwSn
         n45LONAxWBmx2tQ2Ip15+8A/YMqnX0RYnAf8juT5U3TyfMauYYlBnlk5svTAKRORPAhQ
         A7lw==
X-Received: by 10.68.32.194 with SMTP id l2mr15330848pbi.82.1360556776957;
        Sun, 10 Feb 2013 20:26:16 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a4sm65577077paw.21.2013.02.10.20.26.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 20:26:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130211041714.GA12281@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215986>

Jeff King wrote:
> On Sun, Feb 10, 2013 at 08:14:04PM -0800, Jonathan Nieder wrote:

>> Only interactive connections.  That's the existing behavior.
>
> Ah, sorry. I misread the patch. I see now that we already run help, and
> this is just making the exit value significant. In that case, yeah, I
> think it's fine.

No problem --- the description was unclear.  Would retitling the patch
to "shell: pay attention to exit status from 'help' command" work?
