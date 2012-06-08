From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] t1304: improve setfacl prerequisite setup
Date: Thu, 7 Jun 2012 18:18:31 -0700
Message-ID: <CA+sFfMd09Cp7qQdnhhQSTOp2p7jpOspf4HTEcbGihRZzMaz6Yg@mail.gmail.com>
References: <vpqk3zlhorc.fsf@bauges.imag.fr>
	<20120605140449.GA15640@sigill.intra.peff.net>
	<20120605141039.GB15640@sigill.intra.peff.net>
	<20120605142813.GA17238@sigill.intra.peff.net>
	<20120605150550.GA19843@sigill.intra.peff.net>
	<7vpq9dpvnp.fsf@alter.siamese.dyndns.org>
	<20120605164439.GA2694@sigill.intra.peff.net>
	<7v62b5pt2s.fsf@alter.siamese.dyndns.org>
	<20120606132824.GA2597@sigill.intra.peff.net>
	<7vvcj4ml6a.fsf@alter.siamese.dyndns.org>
	<20120607090200.GA6087@sigill.intra.peff.net>
	<7vlijzjdx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 03:18:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScnqW-0000XD-OO
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 03:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759661Ab2FHBSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 21:18:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60479 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab2FHBSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 21:18:31 -0400
Received: by obbtb18 with SMTP id tb18so1658890obb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 18:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xD3YFj1cWdc3C/MpJyqe0eSuA8M2YvSQRjvakcaKR9M=;
        b=RfP6VBO8v+IbM6ZI0GCDDXcvZ0a6sWyVarJXou3jczKVeTBdFZFlXMl8ni6AvzHU4v
         xb8KEenF2wBf3KbbcMRm8T5vvOJYSULQ+RHgyDln3zZIC0AQ77SCsaUY22H758RxJ2Ra
         gChYQH89Y/NRtD13KX+6iBH0NTU1teaKy2IcsWi1hXDOVZo4gQrv8nsjX3mJOmlS3dor
         m4aGlQ0/zVMb0WjsiKlOpHzO11UcKes5NK7wN6+2LI4L6FpvEPkcE6qTqD4Ipdgb+17F
         AeiR3NjE7x+Uwy5jpZpDvENLgfoSS8Ah5YX8Ybpxc8mLBq3FaECtnmnsOtVR2dIVwCIc
         p2/g==
Received: by 10.60.1.37 with SMTP id 5mr3844725oej.10.1339118311225; Thu, 07
 Jun 2012 18:18:31 -0700 (PDT)
Received: by 10.182.125.74 with HTTP; Thu, 7 Jun 2012 18:18:31 -0700 (PDT)
In-Reply-To: <7vlijzjdx6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199460>

On Thu, Jun 7, 2012 at 9:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I intentionally did not anchor it because the tests themselves did not,
>> and I worried that that there was some subtle portability issue there
>> (especially because of the magic "let there be two colons" part of the
>> pattern).
>
> OK, fair enough (the "two colons" one I think was for Solaris).

It was indeed for Solaris.  I don't recall any other differences in
the output between Solaris and Linux, so you could add the anchor and
see if anyone makes noise.  I no longer have access to Solaris to
test.

-Brandon
