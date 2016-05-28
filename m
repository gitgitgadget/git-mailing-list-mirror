From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 00/22] i18n and test updates
Date: Sat, 28 May 2016 08:18:59 +0000
Message-ID: <57495473.2010903@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <xmqq8tyvs9xf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 28 10:19:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6ZSi-0007vc-36
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 10:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbcE1ITG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2016 04:19:06 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:49852 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750972AbcE1ITE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 04:19:04 -0400
Received: (qmail 427 invoked from network); 28 May 2016 08:19:01 -0000
Received: (qmail 1937 invoked from network); 28 May 2016 08:19:01 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 28 May 2016 08:18:59 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqq8tyvs9xf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295806>

=C0s 17:11 de 27-05-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> Marks several messages for translation and updates tests to pass und=
er
>> GETTEXT_POISON. Some tests were updated to fit previous i18n marks, =
others
>> were updated to fit marks made by these patches. Patches that only t=
ouch
>> test file refer to marks done in commits previous to these ones.
>=20
> Whew, this series is quite a lot of work.
>=20
Do you mean review work?
Submitting patches is still a new thing for me.
I don't know how to organize or split well the patch series, if they're
too long, in order to make other's work easier and the patches
themselves more appealing.

I have got other patches that I've made on top of these ones, but
don't know whether I should 1) rebase them on top of master, if they
apply cleanly, and send them in a new patch series, or just 2) send the=
m
together in the next re-roll. New patches are also about i18n.

I've tried scavenging mailing list and documentation (not too hard, I
confess) for a explicit hint on this and eventually other best/desired
practices but found nothing so far, beside the content of
Documentation/SubmittingPatches of course.
If somebody could point me to something like that, that would be great.

I also naturally expect that, if I'm doing something wrong or lesser,
someone will bring it to my attention so I can correct.

(The first time I've sent patches here, I then sent 2 more patches alon=
e
in their own series [1], but Junio Hamano put them together in one
va/i18n-misc-updates branch, reasonable decision since that and the
previous series were all i18n patches, hence all related. That made me
suspect that option 2) is better.
After that, I've sent a re-roll of first series, and Junio Hamano
thought for a moment that I had dropped the 2 patches from the second
one [2]. So it seems that, at least in this case, option 1) can
confuse people.)

[1] http://thread.gmane.org/gmane.comp.version-control.git/291386
[2]
http://thread.gmane.org/gmane.comp.version-control.git/291860/focus=3D2=
91914
