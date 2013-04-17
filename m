From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 39 new messages
Date: Wed, 17 Apr 2013 09:50:05 +0200
Message-ID: <87wqs11tqq.fsf@linux-k42r.v.cablecom.net>
References: <1366043260-3131-1-git-send-email-ralf.thielow@gmail.com>
	<87ppxuan7i.fsf@linux-k42r.v.cablecom.net>
	<CAN0XMOLcNwOUPK2sYvvO_QMaJrMkH949_xZLtdyF+zFx1p4v+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 09:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USN8B-000162-T7
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 09:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965842Ab3DQHuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 03:50:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:43124 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965738Ab3DQHuI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 03:50:08 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 17 Apr
 2013 09:49:59 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 17 Apr 2013 09:50:05 +0200
In-Reply-To: <CAN0XMOLcNwOUPK2sYvvO_QMaJrMkH949_xZLtdyF+zFx1p4v+Q@mail.gmail.com>
	(Ralf Thielow's message of "Wed, 17 Apr 2013 07:49:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221516>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>>   #: sequencer.c:536
>>   #, c-format
>>   msgid "could not revert %s... %s"
>>   msgstr "Konnte %s nicht zur=C3=BCcksetzen... %s"
>>
>>   #: sequencer.c:1016
>>   msgid "Can't revert as initial commit"
>>   msgstr "Kann nicht zu initialer Version zur=C3=BCcksetzen."
>>
>> which I don't really like either now that you mention it -- I would
>> re-translate it as 'reset'.  But either way they should be consisten=
t.
>>
>
> I'm not sure I understand. We currently translate "reset" as "neu
> setzen/umsetzen",
> which is fine if it means a branch or HEAD ('git reset'), but for com=
mits?
> What about "zur=C3=BCcknehmen"?

Sorry for the confusion -- what I meant is: given only "zur=C3=BCcksetz=
en"
and no context, I would probably infer that the original message relate=
d
to 'reset'.  Which it doesn't, so that would be confusing.

"Zur=C3=BCcknehmen" works for me, or in the same vein you could try
"widerrufen".


You can add

  Acked-by: Thomas Rast <trast@inf.ethz.ch>

when you reroll.

Thanks for your work!

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
