From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 9 Apr 2011 18:24:44 +0700
Message-ID: <BANLkTik32jvmJOtFRB9+vCnd_NWC2ft1fA@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com> <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org> <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org> <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org> <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 13:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8WI8-00026c-HU
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 13:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab1DILZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 07:25:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37918 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab1DILZP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 07:25:15 -0400
Received: by bwz15 with SMTP id 15so3428626bwz.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=LAsnyoY2JgDpQ4UUIcYE1cp0UcUaE1RwUy5TP9w60ls=;
        b=VDhb4AR4Gtlxr01jg6+YlthSghW1qY4RXq7ZrKplsf8yGGbYxq4npmL+p7+5DTBhqf
         xCI1gmKk6h8iktZwwxs9nrGBiD4YqR4IQSBAmXtsevU0WEvXat1P7pVnnLnXV3aHSsS8
         8kyxp2JAfyeo1nXNfvGK4JTwGRSqpkQHU9q0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=daHZUtqLTnuMEq2Xw/SfVv35G4cj6nVsAWdJ+uMMHbYVsDiay5u+vYT6KAYdG1n2VM
         aJ1tMfH2kP3yQG1dh2U9c8WghiRc3YdoYrBktTRh7F3GuiR+x3ww3D1RAeF2HLZJLwKn
         vhjRyaAlcLzpR+GQNo1YQLF/wGNGRnR7eJRz0=
Received: by 10.204.17.11 with SMTP id q11mr2812608bka.131.1302348314137; Sat,
 09 Apr 2011 04:25:14 -0700 (PDT)
Received: by 10.204.139.210 with HTTP; Sat, 9 Apr 2011 04:24:44 -0700 (PDT)
In-Reply-To: <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171190>

On Sat, Apr 9, 2011 at 11:58 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Sat, Apr 9, 2011 at 6:18 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Also make ':' without anything else to mean "there is no pathspec". =
=C2=A0This
>> would allow differences between "git log" and "git log ." run from t=
he top
>> level of the working tree (the latter simplifies no-op commits away =
from
>> the history) to be expressed from a subdirectory by saying "git log =
:".
>
> The intention is good, but reality may need more work.

Wait, what if I say "git grep -- : foo : bar"? I take it we should
reject on this case?
--=20
Duy
