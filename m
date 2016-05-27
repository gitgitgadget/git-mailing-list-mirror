From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 16/22] i18n: rebase-interactive: mark comments of
 squash for translation
Date: Fri, 27 May 2016 10:36:11 +0000
Message-ID: <5748231B.8080609@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <1464031661-18988-17-git-send-email-vascomalmeida@sapo.pt>
 <xmqqwpmgtpli.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 12:36:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6F81-0007Fx-NP
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 12:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbcE0KgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 06:36:20 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:44014 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751148AbcE0KgU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 06:36:20 -0400
Received: (qmail 32118 invoked from network); 27 May 2016 10:36:17 -0000
Received: (qmail 31423 invoked from network); 27 May 2016 10:36:17 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 27 May 2016 10:36:12 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqwpmgtpli.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295747>

=C0s 22:35 de 26-05-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> Helper functions this_nth_commit_message and skip_nth_commit_message
>> replace the previous method of making the comment messages (such as
>> "This is the 2nd commit message:") aided by nth_string helper functi=
on.
>> This step was taken as a workaround to enabled translation of entire
>> sentences. However, doesn't change any text seen in English by the u=
ser,
>> except for string "The first commit's message is:" which was changed=
 to
>> match the style of other instances.
>=20
> If only the original were written as "This is the commit message
> $N", you didn't have to do a lot of work like this, but such is
> life.  Thanks for working on this.
>=20
I did that work, assuming it was important and we wanted to keep the
existing messages as much as possible. Unless they are out of place, as
it felt about the message I changed. I've assumed that based on the use=
r
being used to those messages and eventual scripts that expected those
messages.
Is my assumption right? Anyway, the work is already done.
