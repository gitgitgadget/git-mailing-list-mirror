From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and GENERIC_KERNEL_EXECVE
Date: Wed, 24 Oct 2012 05:14:07 +0300
Message-ID: <CA+55aFzg6cNFCCucwgFnJpgokwM=wkkXPMtd2XbtQB5m9UHOSA@mail.gmail.com>
References: <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos> <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos> <CA+55aFyYD2jvD3+TSe=GhBgg5UQt2RNFdYf6HGiKRX-xWzFmdw@mail.gmail.com>
 <20121024015613.GB2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, Jeff King <peff@peff.net>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Al Viro <viro@zeniv.linux.org.uk>
X-From: linux-arch-owner@vger.kernel.org Wed Oct 24 04:14:43 2012
Return-path: <linux-arch-owner@vger.kernel.org>
Envelope-to: glka-linux-arch@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arch-owner@vger.kernel.org>)
	id 1TQqUP-0000nQ-Id
	for glka-linux-arch@plane.gmane.org; Wed, 24 Oct 2012 04:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564Ab2JXCO3 (ORCPT <rfc822;glka-linux-arch@m.gmane.org>);
	Tue, 23 Oct 2012 22:14:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56229 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab2JXCO2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 22:14:28 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so25421obb.19
        for <multiple recipients>; Tue, 23 Oct 2012 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Mo3eGuir6ELX9cKwCdksJQD/vMZiQT9xjUnFZHR+nO8=;
        b=smdFYZicu6N5rxYw0X/nIknCIa+d042/jVVigeXyAVC56ZOYXtBpXQrykuSHQT+/Fc
         g7279qwutA4IsnvV5Y7KMVpCMx7BVRholPhgOfghLOVWnCm1jTiEFQ+fHDyLt4iPkWKD
         ltkMcmUvBX06bpWXi7TjABb3Xg/hPddiX9c5UL64PFp8p/2amTrays47O7NXN3tvu4ek
         06+C9eFiBvivMzCWurnl0QcBs0HjeUmNI0wRKWbkDDOuDsrsiPdczDy6X8ISzkb4oMjd
         WymJnprHlZXA4uvLVUOx5uEcuQtm2V9fnJ0eNSzg+64Uq7/rCML6M/YiSLZ/jZC1eny5
         EgVw==
Received: by 10.60.32.135 with SMTP id j7mr12402639oei.132.1351044867309; Tue,
 23 Oct 2012 19:14:27 -0700 (PDT)
Received: by 10.76.2.242 with HTTP; Tue, 23 Oct 2012 19:14:07 -0700 (PDT)
In-Reply-To: <20121024015613.GB2616@ZenIV.linux.org.uk>
X-Google-Sender-Auth: jj0Jv4EcAA9loWtqHapB5S2w0PY
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208281>

On Wed, Oct 24, 2012 at 4:56 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How about git commit --allow-empty, with
> "belated ACK for <commit>

Don't bother. It's not that important, and it's just distracting.

It's not like this is vital information. If you pushed it out without
the ack, it's out without the ack. Big deal.

          Linus
