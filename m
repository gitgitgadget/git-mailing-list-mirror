From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/6] revert: Free memory after get_message call
Date: Fri, 12 Aug 2011 07:37:43 +0530
Message-ID: <CALkWK0nf0ScbKdykVzp3s+gK9nTPLA3xUOWzLNwVEO83YiLkvg@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-3-git-send-email-artagnon@gmail.com> <20110811192403.GF2277@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 04:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrhAb-0004r8-AU
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 04:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab1HLCIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 22:08:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55330 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab1HLCIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 22:08:05 -0400
Received: by wyg24 with SMTP id 24so1813978wyg.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 19:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dpZET8Jv1tx2uyj+qW9dEfaQG8AC8GwEmV2FLqdHVeU=;
        b=xwGbeTU1YR+3M9PUoYw2B2jhQ2i0E5JTspDA+EZSn91IMmtlcBVx26/SW5VAU/zNtm
         hZh/p1fOng5uUHvt7xg3pa1MTqUrr5FU6VuqpL3/KkKUZQ1JlZljyeVD3TVNlFs5laSQ
         ZVE1qEYgrBA9zYoyiLxVHN6dyH3FRMVbiOFPE=
Received: by 10.216.37.16 with SMTP id x16mr233854wea.93.1313114884071; Thu,
 11 Aug 2011 19:08:04 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Thu, 11 Aug 2011 19:07:43 -0700 (PDT)
In-Reply-To: <20110811192403.GF2277@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179158>

Hi Jonathan,

Jonathan Nieder writes:
> I don't see how this could work. =C2=A0Since there an xmalloc() in ea=
ch
> loop iteration, I would have expected the free() to be in the loop
> body, too.

Oops, fixed.  Thanks.

-- Ram
