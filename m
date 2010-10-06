From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [TOY PATCH] test-lib: &&-chaining tester
Date: Wed, 6 Oct 2010 10:52:59 +0200
Message-ID: <AANLkTimU_OT+r8MMYHQ901r09H=Co+8dfjDD+0M0pF8s@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com> <20101006053118.GA29289@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Pkc-0004kq-NH
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab0JFIxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 04:53:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51408 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0JFIxU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 04:53:20 -0400
Received: by yxp4 with SMTP id 4so2334355yxp.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eFjArhEHR0qkbtkTL7q+AaPTEyEzTou6J+LiYfzUAzs=;
        b=UUi0tf/8DOstBuIM47EamSqLg44QOsyTMaRM4pezAb04bdtwBaSdRnSaibrpxJwjLA
         HfAFiRncKe9PPxAZY2lINLX/WrHg7xgy8XZorORgI32DA8jzKOeQplEbKEeaWSWcjS6a
         2XTRsoipK6eZpUx15Pqwb7BFF45WCPKlDe3Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d5NtOWzS/gP6aWibC1sJin7tZzNnFu872zHQM72GATgMa3csAzv0j2u3kSRVoS/i9F
         Z55ui1wD+/JeyTc3XfpbTRdFMwTFyhjK5EhsTAJfFjye1cbHsqL01I+/qLnfDgVW9QRK
         hmHwWhuPReTqEYUId/oW80mBUyGhbw+hkK0qQ=
Received: by 10.151.25.15 with SMTP id c15mr1492972ybj.386.1286355199302; Wed,
 06 Oct 2010 01:53:19 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Wed, 6 Oct 2010 01:52:59 -0700 (PDT)
In-Reply-To: <20101006053118.GA29289@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158276>

Heya,

On Wed, Oct 6, 2010 at 07:31, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Thanks again. =C2=A0Here's a little glimpse of a future without missi=
ng &&s
> to play with.

Interesting! Are there any false positives? Did you run it and find
any missing &&'s?

--=20
Cheers,

Sverre Rabbelier
