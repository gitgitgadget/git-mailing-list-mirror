From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 28 Feb 2011 09:28:07 +1100
Message-ID: <AANLkTinphmVJe8XW6BhjoyHgA38aopgEk=o=qEp4UT+4@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110227084317.GB3356@sigill.intra.peff.net>
	<87bp1xest7.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 27 23:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptp66-00080L-Cs
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 23:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab1B0W2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 17:28:10 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59203 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1B0W2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 17:28:09 -0500
Received: by wwb22 with SMTP id 22so2382528wwb.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 14:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vAsvp4ZkpGO0+pCHmJOXB7Xo7boV55NdmC51BO8dSi4=;
        b=OTFlLhoXavwiZBC5XveChW7zjnI4Qx9zDXaa7tEWxnOc4lM4EV936h1Xg6GtHEgpuk
         iFTSzjKqDuMEQNyouXR/W7ZubtS+sR0VzRAFecF67Kv6577MWAjGEd6oYgeRxFpNYQTF
         AMIeqDsZWBMRf334jZySmMSpnrwiCuGmrY1W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BwPGEKRHNDpRJx8V6Sd4NI6rhQE7oZlRgqL9XcpVkp0PusgmZCErFkamkLKuakhRSO
         bxvPISM6DSulJ7PWs6U6DDVZmlz9lBrsyI+vDYk3Ofv19gJuaT/gTh2ylhk5Oby1P0JY
         IrGYau3zsSny+5iqFgqg+kgTGpgDoxE+uFX1s=
Received: by 10.227.138.15 with SMTP id y15mr4254643wbt.186.1298845687610;
 Sun, 27 Feb 2011 14:28:07 -0800 (PST)
Received: by 10.227.64.66 with HTTP; Sun, 27 Feb 2011 14:28:07 -0800 (PST)
In-Reply-To: <87bp1xest7.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168056>

On Sun, Feb 27, 2011 at 8:21 PM, Miles Bader <miles@gnu.org> wrote:
> Jeff King <peff@peff.net> writes:
>> So the term "staging area" makes perfect sense to me; it is where we
>> collect changes to make a commit. I am willing to accept that does n=
ot
>> to others (native English speakers or no), and that we may need to c=
ome
>> up with a better term. But I think just calling it "the stage" is ev=
en
>> worse; it loses the concept that it is a place for collecting and
>> organizing.
>
> Agreed.
>
> "Staging area" is a good noun (phrase) for this. =C2=A0"Stage" is a g=
ood verb
> (for "move into the staging area"), but isn't intuitive as a noun.
>

When used to describe a pre-production environment, the noun in my expe=
rience
is inevitably 'staging' (short for staging environment) rather than
'stage' which
is consistent with the origin Jeff posits.

I guess the noun 'stage' does have a use in git-speak to refer to the
different arms of
an unresolved merge.

jon.
