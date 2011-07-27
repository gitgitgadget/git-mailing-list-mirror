From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/18] revert: Propogate errors upwards from do_pick_commit
Date: Wed, 27 Jul 2011 15:17:03 +0530
Message-ID: <CALkWK0=dFzVdqi3CJMBzkQO4WGe5-U1eQXwpVNZd33nLXD3+Qw@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-7-git-send-email-artagnon@gmail.com> <20110727043908.GD18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0i9-0004sn-SZ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab1G0JrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 05:47:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1G0JrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 05:47:24 -0400
Received: by wwe5 with SMTP id 5so1225815wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KxLmUxWsEIBrnEjIB3de8IcIPtpbpXgUYsURRPiQNm0=;
        b=WBGJLwR0TxIDJFyURHvAKzO7DCpUvz+QR3NRUGgyTqI82l4CFZW7myHMzS674T/Bty
         ZIrm7pKMhmhv6hvKDD09sdLfTiMX9ARIW3VXHhDVDbxxN/BYQhSRloOb9IixO/H0ZkSC
         +LzNSYi25fhQGMdDy67D7YfSEh9eHu70Y+H8c=
Received: by 10.216.9.134 with SMTP id 6mr2749456wet.111.1311760043127; Wed,
 27 Jul 2011 02:47:23 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 02:47:03 -0700 (PDT)
In-Reply-To: <20110727043908.GD18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177955>

Hi Jonathan,

Jonathan Nieder writes:
> Patch 5 is good. =C2=A0I still find patch 6 unconvincing, since it ma=
kes
> the behavior inconsistent (there are still many ways for
> revert_or_cherry_pick to exit() or die()), does not help with anythin=
g
> that comes later, and it is more of a burden than most of the rest of
> the patches to review (since one has to look at context not contained
> in the diff to see if it is safe to continue running after an error
> that previously would exit).

:sigh:

> In the long term, I really do want this
> change, though. =C2=A0If you'd like, I can rebase to put it at the en=
d of
> the series (which shouldn't be hard).

That would be awesome -- the rebase won't be easy at all though.

-- Ram
