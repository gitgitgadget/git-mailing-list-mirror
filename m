From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Wed, 17 Apr 2013 10:09:29 +0200
Message-ID: <87a9ox1sue.fsf@linux-k42r.v.cablecom.net>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
	<1906942.3yyCMUNxTB@cs-pc>
	<CAN0XMOLmwUpwOi0xz4iOy3wfhzCeeNKNgywgS9ZfaET172vsBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:09:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USNQw-0002Rm-LW
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965943Ab3DQIJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 04:09:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:44788 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965847Ab3DQIJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 04:09:31 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 17 Apr
 2013 10:09:23 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 17 Apr 2013 10:09:29 +0200
In-Reply-To: <CAN0XMOLmwUpwOi0xz4iOy3wfhzCeeNKNgywgS9ZfaET172vsBQ@mail.gmail.com>
	(Ralf Thielow's message of "Wed, 17 Apr 2013 07:14:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221517>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Hi,
>
> Thanks for review!
>
> On Mon, Apr 15, 2013 at 9:26 PM, Christian Stimming <stimming@tuhh.de=
>wrote:
>
>> Thanks for the regular update! This is great work.
>>
>> One issue with the plural form messages, though:
>>
>> Am Montag, 15. April 2013, 18:27:40 schrieb Ralf Thielow:
>> >  #: bundle.c:186
>> > -#, fuzzy, c-format
>> > +#, c-format
>> >  msgid "The bundle contains this ref:"
>> >  msgid_plural "The bundle contains these %d refs:"
>> > -msgstr[0] "Das Paket enth=C3=A4lt %d Referenz"
>> > -msgstr[1] "Das Paket enth=C3=A4lt %d Referenzen"
>> > +msgstr[0] "Das Paket enth=C3=A4lt diese Referenz:"
>> > +msgstr[1] "Das Paket enth=C3=A4lt diese %d Referenzen:"
>>
>> The msgstr[0] must still contain a %d conversion specifier (which wi=
ll be
>> filled with the number 1) even though the translated sentence wouldn=
't need
>> the 1 anymore. The previous msgstr[0] was correct; the English singu=
lar
>> msgid
>> is not.
>>
> That made me wonder, too. I've played around a bit with this, and it =
seems
> to be OK as long as one of those strings contain at least one format
> specifier.

C printf() only knows about the number and types of arguments from the
format string, so *ignoring* arguments is not a problem for correctness=
=2E

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
