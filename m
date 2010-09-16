From: Peter Krefting <peter@softwolves.pp.se>
Subject: RE: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 11:41:41 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009161134390.18826@ds9.cixit.se>
References: <20100912202111.B11522FC00@perkele> <A612847CFE53224C91B23E3A5B48BAC749BF60444B@xmail3.se.axis.com> <alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se> <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 12:42:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwBuk-0005WW-Ta
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 12:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab0IPKl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 06:41:57 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:41472 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752832Ab0IPKl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 06:41:56 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8GAfgeu027660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Sep 2010 12:41:42 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8GAffO6027656;
	Thu, 16 Sep 2010 12:41:41 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 16 Sep 2010 12:41:42 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156315>

Peter Kjellerstedt:

>>>> +#: builtin/commit.c:380
>>>> +msgid "cannot do a partial commit during a merge."
>>>> +msgstr "kan inte utf=F6ra en delvis incheckning under en sammansl=
agning."
>>> "delvis" -> "partiell"
>> Is that better? Sounds a bit to technical to me.
> Well, "en delvis incheckning" doesn't sound like correct Swedish...

"Partiell" is something I connect with solar eclipses, can't say I can=20
remember hearing it much elsewhere. But any ideas for better wording ar=
e of=20
course appreciated.

>>>> +#: builtin/commit.c:737
>>>> +msgid "Error building trees"
>>>> +msgstr "Fel vid byggande av tr=E4d"
>>> "byggande av tr=E4d" -> "tr=E4dbygge" ?
>> That sounds even weirder to me.
> Hmm, you may be right. Alternatives for "byggande" is
> "konstruktion" and "skapande", don't know if either of those
> make it sound better.

Changing to "skapande", that sounds better IMHO.

>>> "dekorerade" -> "annoterade"
>> Is that a word?
> Yes. At least it is in SAOL which I think should be indicative of its=
=20
> existence ;)

I take your word (no pun intended) for it. Changing everywhere.

>>>> +#: builtin/log.c:825
>>>> +#, c-format
>>>> +msgid "insane in-reply-to: %s"
>>>> +msgstr "tokigt in-reply-to: %s"
>>> "tokigt" -> "tokig"
>> My sense of language says that it should be "neutrum", so "tokigt".
> Well, I read it with an implicit "header" (i.e., as "insane in-reply-=
to=20
> header: %s")...

Exactly. And "header" is "huvud", which is neuter.

>>>> +#: builtin/merge.c:651
>>>> +#, c-format
>>>> +msgid "Unknown option for merge-recursive: -X%s"
>>>> +msgstr "Felaktig flagga f=F6r merge-recursive: -X%s"
>>> "merge-recursive" -> "rekursiv ihopslagning" ?
>> No, merge-recursive is a name of a merge strategy.
> Maybe add quotes around it then do indicate that?

Added.

>>> "t.ex" -> "t ex"
>> I think it looks clearer with the full stop.
> Then it should be "t. ex." according to SAOL.

Yes, but then I overflow an 80 character line... :-/

>>>> +#: builtin/revert.c:270
>>>> +#, c-format
>>>> +msgid "Error wrapping up %s"
>>>> +msgstr "Fel vid ombrytning av %s"
>>> I do not think this "wrapping up" refers to reformatting of the com=
mit=20
>>> message. I think it refers to finishing writing the message (a=20
>>> rephrasing of the English message is advisable). Thus the Swedish=20
>>> translation should probably be:
>>>
>>> "Fel vid avslutandet av %s"
>> Are you sure about that? I was unable to figure it out when I looked=
 at
>> it.
> I am pretty sure. That error message is output in case a file called=20
> "somefile.lock" cannot be closed and renamed to "somefile" (see=20
> lockfile.c:commit_lock_file().)

Indeed. Fixed. Thanks for clarifying it.

>>>> +#: builtin/tag.c:196
>>>> +msgid "gpg did not accept the tag data"
>>>> +msgstr "gpg godtog inte taggdata"
>>> "taggdata" -> "taggdatan"
>> "taggdatana" in that case. "data" is always plural.
> Maybe better to use "tagginformationen"?

Yes. Much better! Thanks.

--=20
\\// Peter - http://www.softwolves.pp.se/
