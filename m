From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 2/3] builtin/checkout: change -b from an OPTION_STRING to 
	a OPTION_SET_INT
Date: Wed, 23 Jun 2010 18:37:02 -0300
Message-ID: <AANLkTik0-XHGbmCwO9AvETn8bmMIXdHtXLsH45ppkSCK@mail.gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org> <1277140782-4064-1-git-send-email-rctay89@gmail.com> 
	<1277140782-4064-2-git-send-email-rctay89@gmail.com> <1277140782-4064-3-git-send-email-rctay89@gmail.com> 
	<AANLkTikyugBxwyCu0GY4dTLW6n_OQhIPNnPfd0_i6k0t@mail.gmail.com> 
	<AANLkTikYgbVlyLlaba2G2CTFc0wFgylPRvhm-BX0igFz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 23:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORXdQ-0001X3-Bh
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab0FWVhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 17:37:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52535 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0FWVhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 17:37:22 -0400
Received: by gye5 with SMTP id 5so3983515gye.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=BkMdpHNotNlvtZYHK4c9Z2KM6ApCgsavIHBqXwTb9kA=;
        b=Na1SFy2iGeeLboDw0b6Vb+P0Ifp6daJBfa/6g/ZRdVsAQc1pQ5MA+4sckCom1dNklI
         CXnMK/BlglQp8Cb82bWipIHIjcETF4ueAYM3sNVxUXGHkKVW5/B/VJDIGE4YT2BSuvHy
         4QK60JcuVR20IHjsL057tiN/lxktbwJknb/CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ISu1ZMUDNQlC8YApfO2UHhqWWcbktFzBS0Lu6IForRVkB9JPN3anljETYLZyyW1s+T
         oZRs3FLmpeV8dkZ7n0HrmGCe3aM8pBhLP2/9aX9GOuiPhkfk48nN1IjeoEVwPxua5XbJ
         AMS68zUtily5zsNRoY4+ixSJVOp/RlcRc9pyk=
Received: by 10.150.160.12 with SMTP id i12mr8339409ybe.8.1277329042272; Wed, 
	23 Jun 2010 14:37:22 -0700 (PDT)
Received: by 10.150.178.7 with HTTP; Wed, 23 Jun 2010 14:37:02 -0700 (PDT)
In-Reply-To: <AANLkTikYgbVlyLlaba2G2CTFc0wFgylPRvhm-BX0igFz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149551>

Hi,

2010/6/23 Tay Ray Chuan <rctay89@gmail.com>:
> Erick, thanks for the suggestion - I've a new iteration that takes
> some of your points.
>
> --
> Cheers,
> Ray Chuan

You are welcome.  Good luck then.  As I heard here once: thank you for
making Git better!.

Regards
