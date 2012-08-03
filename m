From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] l10n: de.po: translate 76 new messages
Date: Fri, 3 Aug 2012 14:16:23 +0200
Message-ID: <874nok5fxk.fsf@thomas.inf.ethz.ch>
References: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com>
	<87y5lw73m8.fsf@thomas.inf.ethz.ch>
	<CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>,
	<worldhello.net@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:16:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxGnw-00005a-BD
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab2HCMQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 08:16:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:7664 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab2HCMQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 08:16:26 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:16:17 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 14:16:23 +0200
In-Reply-To: <CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
	(Ralf Thielow's message of "Fri, 3 Aug 2012 12:41:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202828>

Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>>>  msgid ": perhaps a D/F conflict?"
>>> -msgstr ""
>>> +msgstr ": vielleicht ein D/F-Konflikt?"
>>
>> What's the terminology for conflicts in German?  For D/F, the user n=
eeds
>> to know the English terms.  Not that V/D would be much better.  Mayb=
e
>> just spell it out.
>>
>
> Thanks. I'll spell it out but would leave the term "Konflikt"?!

Yes, I agree with conflict -> Konflikt.

>>>  #: merge-recursive.c:1038 merge-recursive.c:1052
>>>  #, c-format
>>> @@ -437,6 +435,8 @@ msgid ""
>>>  "CONFLICT (%s/delete): %s deleted in %s and %s in %s. Version %s o=
f %s left "
>>>  "in tree."
>>>  msgstr ""
>>> +"KONFLIKT (%s/delete): %s gel=C3=B6scht in %s und %s in %s. Stand =
%s von %s wurde "
>>> +"im Arbeitsbereich gelassen."
>>
>> This needs de-legoification on the first and fourth %s, which can be
>> rename/renamed or modify/modified.  Furthermore, in line with the D/=
=46
>> above, perhaps you should translate "delete"?  But I see that you ha=
ve
>> not translated "renamed" etc. below, either.  Was that on purpose?  =
It
>> will read a bit odd as
>>
>>   KONFLIKT (rename/delete): foo gel=C3=B6scht in bar und renamed in =
quux. Stand ...
>
> Gah, I misunderstood the values of the placeholders. The reason why I=
 haven't
> translate "delete" or "rename" is because they're part of the
> "KONFLIKT (%s/delete)"
> messages, aren't they? Translate it all would solve the problem. Than=
ks

Well, it's a bit confusing.  AFAICS the verb (rename/modify) goes into
the parens at the start, and the participle (renamed/modified) goes int=
o
the fourth %s.  So if you decided to *not* translate the
"(rename/delete)" conflict description, you would have to translate
"renamed" (to fit it into the sentence) but not "rename".

Which would be really hard to maintain.  So let's not do that.  I think
it's better if you translate them all.

>>>  msgid "fatal: no such branch: $branch_name"
>>> -msgstr ""
>>> +msgstr "fatal: kein solcher Zweig: $branch_name"
>>
>> kein Zweig $branch_name gefunden?
>>
>
> what about "Zweig $branch_name nicht gefunden"?

Sure.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
