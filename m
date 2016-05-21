From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 14/21] i18n: rebase-interactive: mark strings for
 translation
Date: Sat, 21 May 2016 14:05:34 +0000
Message-ID: <57406B2E.7060206@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-15-git-send-email-vascomalmeida@sapo.pt>
 <CACBZZX7T7b9xMM_mDcH6JBnuCap7RtKvSYoFNDrN5mLdmLLYHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Jiang Xin <worldhello.net@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 16:06:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b47XZ-0004ke-40
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 16:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbcEUOFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2016 10:05:43 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:51848 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752260AbcEUOFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 10:05:42 -0400
Received: (qmail 1832 invoked from network); 21 May 2016 14:05:39 -0000
Received: (qmail 11582 invoked from network); 21 May 2016 14:05:39 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <worldhello.net@gmail.com>; 21 May 2016 14:05:34 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <CACBZZX7T7b9xMM_mDcH6JBnuCap7RtKvSYoFNDrN5mLdmLLYHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295230>

=C3=80s 12:57 de 21-05-2016, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason esc=
reveu:
> On Wed, May 18, 2016 at 5:27 PM, Vasco Almeida <vascomalmeida@sapo.pt=
> wrote:
>> > Mark strings in git-rebase--interactive.sh for translation. There =
is no
>> > need to source git-sh-i18n since git-rebase.sh already does so.
> Cool, thanks for working on this.
>=20
>> > --- a/git-rebase--interactive.sh
>> > +++ b/git-rebase--interactive.sh
>> > @@ -128,7 +128,7 @@ mark_action_done () {
>> >         if test "$last_count" !=3D "$new_count"
>> >         then
>> >                 last_count=3D$new_count
>> > -               printf "Rebasing (%d/%d)\r" $new_count $total
>> > +               printf "$(gettext Rebasing) (%d/%d)\r" $new_count =
$total
>> >                 test -z "$verbose" || echo
>> >         fi
>> >  }
> Things like these should be converted into something you can pass to
> eval_gettext. I.e. For any message the translator needs to be able to
> translate the whole message. Consider e.g. RTL languages where the
> (%d/%d) will be on the right-hand-side of the message.
>=20
One more thing I haven't anticipated. Thank you for pointing it out.

I'll take this and the other comments in consideration for the next re-=
roll.
