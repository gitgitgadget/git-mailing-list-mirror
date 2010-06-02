From: Roy Lee <roylee17@gmail.com>
Subject: Re: How to add daily tags for a central repo?
Date: Wed, 2 Jun 2010 15:55:11 +0800
Message-ID: <AANLkTilbhfc_lyV6C_daaDZJvN5B-jvIUYyTBMeimtJD@mail.gmail.com>
References: <1275369711233-5124575.post@n2.nabble.com>
	<4C04AC1E.7040502@drmicha.warpmail.net>
	<AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
	<4C04BF33.70300@drmicha.warpmail.net>
	<AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
	<4C04CA4F.40106@drmicha.warpmail.net>
	<AANLkTinpmkLhbBeqtdK9auG6NfqEsHqPWhrpUL18nFsG@mail.gmail.com>
	<7vaareoxmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 09:55:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJinK-00046o-HR
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 09:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654Ab0FBHzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 03:55:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47518 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab0FBHzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 03:55:12 -0400
Received: by vws11 with SMTP id 11so2221752vws.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RN3EvU3BmuwrilXFVfPrEj1YBlFYoct8AMokHVCqB6s=;
        b=LUK0IELSlk+zxIB4QxWMnh+lgptEqgXbmSEIjDY1t93+I7GwTJxjaoGWMdPA0DQ0FR
         tIH4d7dRNRYoohZvvbDMXMN5nzJnDt9n7i0jSFqR8nZwF+PaC6sUrmHPkrbG3sJuQGI1
         X+YLecWVYNLV9+oD/gMHUovs0Rzbhrh4yX2TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pKlAcnUSClZwH3/ctUDxVFs6Xe4kJ5feSN1+jY4EDn9tBSyG5AiLbx6S+osfgmQRJV
         eIy4T+GeGBinnQxzSMGl5tpz8kFToKRfJ9QSN32vIpJuSuHKu/nDK3lL6w5dMVGdQCmG
         RDHDHe4uYCwSbidmb8kLIe/nJP9NREoaZ8CQI=
Received: by 10.229.250.211 with SMTP id mp19mr1288508qcb.42.1275465311191; 
	Wed, 02 Jun 2010 00:55:11 -0700 (PDT)
Received: by 10.229.247.1 with HTTP; Wed, 2 Jun 2010 00:55:11 -0700 (PDT)
In-Reply-To: <7vaareoxmv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148225>

Hi,

On Wed, Jun 2, 2010 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Roy Lee <roylee17@gmail.com> writes:
>
>>> * Create a tag for the state of a ref (such as HEAD) on the central=
 repo
>>> at a specific date and time.
>>
>> Yes, for the daily build stuff.
>
> If this is really "the daily build", the easiest is to
>
> =A0- arrange the "daily build" environment to be kept up-to-date (eit=
her
> =A0 developers will be pushing into it, or there is another canonical
> =A0 central repository developer pushes into, and the daily build
> =A0 repository pulls from that canonical central repository via cron =
just
> =A0 before starting to build);
>
> =A0- tag the version that is being built; and
>
> =A0- do the "daily build".
>
> Even if the automated "daily build" runs an hour after midnight, I
> wouldn't imagine that you would want to grab the version that was the
> latest as of midnight, building that slightly stale one, excluding th=
e
> development that happened within an our since that version.

The daily build process for our company is still under development.

I'll feel more comfortable if the timing of tagging can be decoupled wi=
th
the target revision date. In case one day the mechanism is asked to tag
more branches on during different time interval or even backtrack to
snapshots earlier than now.

So far, the reflog mechanism seems to be able to fulfill this requireme=
nt,
since it allows us to backtrack earlier updates and do the tagging.
I'm taking it as a starting point or as a building block unless more at=
tractive
alternatives show up.

Regards,
Roy
