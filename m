From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/6] Re: Documentation: warn prominently against merging
 with dirty trees
Date: Mon, 11 Jan 2010 02:21:23 -0600
Message-ID: <20100111082123.GA23742@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
 <20100111041318.GA9806@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 09:21:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFWt-0004Yx-9O
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0AKIV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 03:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644Ab0AKIV1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:21:27 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52913 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab0AKIV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:21:26 -0500
Received: by ywh6 with SMTP id 6so21245714ywh.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 00:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Vd206tSN3Jk7RdIpeI+hqI/p2CpnoqLbphztgEgFA00=;
        b=U263PSCvK2zhTmFFDhEr1eZWBsqAjDG/BPQGNpt27lc0/Yf1FezWGix+clo0rjTjft
         l2psVY5GaHVYRWPtz4JjTw25ONmq6uUqqmkNVGUNNZemN3xRuo+GtAXLrsIN9HDlA/sh
         eMyTESfi/platIRTL9o5eWW27b2hSKjowDxRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kwdc2zdEzsOi4z0bHm1NjkSDkJPmi9P5pLyUZ6tYCDU17NYlrt1SB21xRMGoD1tSWp
         nyTW0Yf4URBmiht26O3U3CRypyLYVI/LBkGXWvu36U0FMEaaV/nimyS7OYMV6IredFvy
         MJjboQgDBZd906nHr5JeNkNG79joggVe83ITU=
Received: by 10.151.16.13 with SMTP id t13mr5265180ybi.214.1263198084390;
        Mon, 11 Jan 2010 00:21:24 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4696007iwn.12.2010.01.11.00.21.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 00:21:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111041318.GA9806@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136617>

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> You need to be able to tell the two ways in which a "mergy" operatio=
n can
>> "fail" apart [*1*].
>
> Thanks for bringing this up.  The manual does not emphasize that
> point at all, but it should.

Maybe something like this (patch 4) could help.  This should pass
through Thomas=E2=80=99s tree to avoid conflicts with his other changes=
; but
of course, I would be glad to hear any thoughts you have before then.

Jonathan Nieder (6):
  Documentation: clarify one-line description for merge
  Documentation: merge: add an overview
  Documentation: merge: move configuration section to the end
  Documentation: emphasize when git merge terminates early
  Documentation: merge: add a section about fast-forward
  Documentation: merge: tweak HOW MERGE WORKS section

 Documentation/git-merge.txt |  149 ++++++++++++++++++++++++++---------=
-------
 1 files changed, 92 insertions(+), 57 deletions(-)
