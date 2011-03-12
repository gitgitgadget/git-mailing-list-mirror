From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Sat, 12 Mar 2011 11:52:23 +0200
Message-ID: <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
	<1299590170-30799-3-git-send-email-alcosholik@gmail.com>
	<4D773570.4010803@drmicha.warpmail.net>
	<7voc5k9hfy.fsf@alter.siamese.dyndns.org>
	<20110310223732.GE15828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 12 10:53:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyLVQ-0002EA-En
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 10:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab1CLJwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 04:52:49 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49835 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1CLJws (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 04:52:48 -0500
Received: by wwa36 with SMTP id 36so4039273wwa.1
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3GubrJ5BYduxeKvFjO7i52fiDYP4JBr//IYoHRoASqg=;
        b=DJwwSqhHeJFZeDN6X/ghDDTbfLyfyz2W7ykfhbJALiS6b6jee9qyCRg6wFV2zPnXh5
         6LR803DS8BgwytRCinnPiyySaK6RVtRsAv2SxPtdw6e+uePR5VMAOj+O2jNQRo1+dF64
         TY2XswF64NGDzGuyu+8Vc77jncRsXvGGHqjw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pXZ5alReeId4UN485GqN3ojWyZ9lbIW30lt3uZK58KYBBum3dQ2BM8aqsnzKWi8Jvi
         ExFLIkQu5WzkgIjlaZlqhMLGshAMxV0AnUyV8BbNoIvUnyC5BK2kK/oxjTyMhYw++64Y
         l5EX99mAWHVLCyP2iCarAyPdHsOO4RysnKhBs=
Received: by 10.216.140.154 with SMTP id e26mr8733691wej.79.1299923544025;
 Sat, 12 Mar 2011 01:52:24 -0800 (PST)
Received: by 10.216.1.142 with HTTP; Sat, 12 Mar 2011 01:52:23 -0800 (PST)
In-Reply-To: <20110310223732.GE15828@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168939>

On 11 March 2011 00:37, Jeff King <peff@peff.net> wrote:
> -The documentation for git suite was started by David Greaves
> -<david@dgreaves.com>, and later enhanced greatly by the
> -contributors on the git-list <git@vger.kernel.org>.
> +Git was started by Linus Torvalds, and is currently maintained by Junio
> +C Hamano. Numerous contributions have come from the git mailing list
> +<git@vger.kernel.org>. For a complete list of contributors, see
> +linkgit:git-shortlog[1] and linkgit:git-blame[1].

The last sentence could be a little bit more informative for casual
git-users, something like
  For a complete list of contributors, see http://git-scm.com/about,
or (if you are a true geek) linkgit:git-shortlog[1] and
linkgit:git-blame[1].

Other than that, I totally agree with the idea.

-- 
Best regards,
Alexei Sholik
