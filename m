From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 12:43:48 +0000
Message-ID: <AANLkTikAT7AE_7Ln1fCaSQN5Ankm0BusZRBmNrHpPx7N@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<alpine.DEB.2.00.1008311205280.28446@ds9.cixit.se>
	<AANLkTikuQZpOjddgHtpSpw-P4AeL1swsrzJzd5cE7e8F@mail.gmail.com>
	<vpqk4n7rnvo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 31 14:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqQBv-0005MC-If
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 14:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265Ab0HaMnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 08:43:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56583 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab0HaMnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 08:43:49 -0400
Received: by iwn5 with SMTP id 5so5855466iwn.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qgA1lOVuQXvf0FOuyQOZVk7isb1zRgDvWKJUmInBjps=;
        b=ZGQPiusNHKiJtXl6Uom9LfYY4iU58xuzQnTSp7cavx3s7ENy+mzpRF6LDzq/Kae5MI
         amkAVmtGG6ZTJtc/JuNfoDYc561CdpACOrihZLqAw3KKhOIAopFunt4b8EWSRR5mbyFI
         4HhUXm0hzTQpVDlRAkcOsP8qjfC8PqgIsgEBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g9LwGkRFKXUxVhteya6dYc0EJbw6iRrlpDx4AVFhXNvLLfK+5w8O2KCfOPK/MQamww
         IHOjkes0/RMth9zEO9C9YbiNMyPAy1U6NhEb4Gr0Pv4jf/tQJJZSzHctXezwUHEQCeQp
         gcvgYqOMeItD3JWQGvDWCxOwspZJU4b/R3X8I=
Received: by 10.231.34.139 with SMTP id l11mr6720238ibd.141.1283258628845;
 Tue, 31 Aug 2010 05:43:48 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 05:43:48 -0700 (PDT)
In-Reply-To: <vpqk4n7rnvo.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154897>

On Tue, Aug 31, 2010 at 12:02, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> I've used Launchpad somewhat for translating and it's friendly to
>> contributors & has an active community, but it seems to require that
>> we BSD-license our translations[1], which would be a showstopper sin=
ce
>> we'd have to contact everyone who's been submitting GPL-2-only strin=
gs
>> to Git for the last 5 years.
>
> I don't think so:
>
> ,----[ https://help.launchpad.net/Translations/LicensingFAQ ]
> | I have no problem with BSD myself, but I also uploaded translations
> | from upstream. What do I do?
> |
> | As long as the uploads were marked as translations that were publis=
hed
> | elsewhere, they fall under a separate copyright regime: those impor=
ts
> | will retain their original copyright license. The BSD licence only
> | applies to translations that are (as far as the system knows) origi=
nal
> | to Launchpad.
> `----
>
> So, my understanding is: Git's code, and strings, would remain what
> they are, but things contributed _through launchpad_ would be BSD.

Ah yes. It seems as if Git's strings and derived works would be marked
GPL-2. That sounds good. Like I said I hadn't looked in any of this in
detail, or the legal issues involved.

Anyway, the main issue with Launchpad that I've had as a
user/translator is getting translations back out of the system. To
download a *.po file you have to log in and submit a request for a
*.po file download. Sometimes it can take hours for you to get a mail
back.

Downloading a large amount of translations through this system in
Launchpad would be very painful. But maybe they have a better API now
that we could use.
