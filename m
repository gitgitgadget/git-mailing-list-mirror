From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [RFC] l10n: de.po: translate 76 new messages
Date: Fri, 3 Aug 2012 12:41:12 +0200
Message-ID: <CAN0XMOLp_m4jUKv_=qfXdYx4jDJMBYQtY2-19sfC_7LzfY6uXA@mail.gmail.com>
References: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com>
	<87y5lw73m8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	worldhello.net@gmail.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 12:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxFJo-0003l5-8t
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 12:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab2HCKlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 06:41:15 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61915 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab2HCKlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 06:41:14 -0400
Received: by wgbdr13 with SMTP id dr13so527182wgb.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ri/9glGtmLzQsyHU9WoPdc/L3pQy1ovyKBua6Im9whQ=;
        b=ZTXx38z+dahlgy+UBVg7sQY1rsCwM/XDQaP+xjFIB6LsmTO01MiqCqtSZpOkPfGxLU
         I5tbBpjZwu+FBSs3QgTMgXf48Xwq5TZDVe65KnpjLSRpRS4440umwJYvZgFvOh6p2kst
         fRpAnJuW8yT2br/M9JXyPCqWhlF4Tjd5oxWFPx6RSr8wy6ZvOFWgBiU0xcxfPHOx6Ef9
         ixOW7RZRsVK6oyYE+irdP/UhvtQ9n5tptdX/oNGl55ZSgWoi6WGabRne/aDQMrlSxK7l
         nktpVCQczjitgDV9/NalhrzVD07yVM2zjAwJVjXORSIxzkCsdmcjRGjQvvpfBwBC2/k/
         Z4Fg==
Received: by 10.180.104.200 with SMTP id gg8mr3312484wib.14.1343990472761;
 Fri, 03 Aug 2012 03:41:12 -0700 (PDT)
Received: by 10.194.26.33 with HTTP; Fri, 3 Aug 2012 03:41:12 -0700 (PDT)
In-Reply-To: <87y5lw73m8.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202827>

Hi Thomas,

thanks for your review.

On Fri, Aug 3, 2012 at 10:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>>  #: merge-recursive.c:497
>> -#, fuzzy
>>  msgid "diff setup failed"
>> -msgstr "diff_setup_done fehlgeschlagen"
>> +msgstr "Einrichtung der Optionen zur Bestimmung der Unterschiede "
>> +"fehlgeschlagen"
>
> That one is really unwieldy.  Judging from a cursory look at the code=
,
> it's an internal error anyway and should probably be "BUG:
> diff_setup_done failed" to begin with.
>

You're right. There are already places where the message is
"diff_setup_done failed"

#: builtin/checkout.c:320 builtin/diff.c:302 builtin/merge.c:408
msgid "diff_setup_done failed"
msgstr "diff_setup_done fehlgeschlagen"

We could just translate it in this way. It's not really the same messag=
e,
but the same meaning.

>>  #: merge-recursive.c:627
>>  msgid "merge-recursive: disk full?"
>> -msgstr ""
>> +msgstr "merge-recursive: Speicher voll?"
>
> Maybe "Festplatte voll?" to distinguish from RAM.
>

I agree. There is also another message (#: builtin/commit.c:1590)
translated in this way. I'll change it both. Thanks

>>  msgid ": perhaps a D/F conflict?"
>> -msgstr ""
>> +msgstr ": vielleicht ein D/F-Konflikt?"
>
> What's the terminology for conflicts in German?  For D/F, the user ne=
eds
> to know the English terms.  Not that V/D would be much better.  Maybe
> just spell it out.
>

Thanks. I'll spell it out but would leave the term "Konflikt"?!

>>  #: merge-recursive.c:726
>> -#, fuzzy, c-format
>> +#, c-format
>>  msgid "refusing to lose untracked file at '%s'"
>> -msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
>> +msgstr "verweigere, da ungefolgte Dateien in '%s' verloren gehen
>> w=C3=BCrden"
>
> Your glossary[1] says we call them "unbeobachtet"?
>

Oops. I'll change. Thanks

>>  #: merge-recursive.c:1038 merge-recursive.c:1052
>>  #, c-format
>> @@ -437,6 +435,8 @@ msgid ""
>>  "CONFLICT (%s/delete): %s deleted in %s and %s in %s. Version %s of=
 %s left "
>>  "in tree."
>>  msgstr ""
>> +"KONFLIKT (%s/delete): %s gel=C3=B6scht in %s und %s in %s. Stand %=
s von %s wurde "
>> +"im Arbeitsbereich gelassen."
>
> This needs de-legoification on the first and fourth %s, which can be
> rename/renamed or modify/modified.  Furthermore, in line with the D/F
> above, perhaps you should translate "delete"?  But I see that you hav=
e
> not translated "renamed" etc. below, either.  Was that on purpose?  I=
t
> will read a bit odd as
>
>   KONFLIKT (rename/delete): foo gel=C3=B6scht in bar und renamed in q=
uux. Stand ...

Gah, I misunderstood the values of the placeholders. The reason why I h=
aven't
translate "delete" or "rename" is because they're part of the
"KONFLIKT (%s/delete)"
messages, aren't they? Translate it all would solve the problem. Thanks

>
>>  #: merge-recursive.c:1832
>>  #, c-format
>>  msgid "merging of trees %s and %s failed"
>> -msgstr ""
>> +msgstr "zusammenf=C3=BChren der B=C3=A4ume %s und %s fehlgeschlagen=
"
>
> Capital Z?
>

Would indeed be nicer, thanks.

>>  #: merge-recursive.c:1862
>>  #, c-format
>>  msgid "Unprocessed path??? %s"
>> -msgstr ""
>> +msgstr " unverarbeiteter Pfad??? %s"
>
> Stray space at the beginning.
>

I'll fix.

>>  #: merge-recursive.c:1918
>>  #, c-format
>>  msgid "found %u common ancestor(s):"
>> -msgstr ""
>> +msgstr "%u gemeinsame Vorg=C3=A4nger gefunden"
>
> "ancestor(s)" is not listed in the glossary.  I'd personally pick
> "Vorfahren" but I'm probably bikeshedding.
>

"Vorfahre(n)" sounds indeed a bit nicer. I'll change it and
update the glossary.

>> +"Wenn du das Problem aufgel=C3=B6st hast, f=C3=BChre \"git rebase -=
-continue\" aus.\n"
>
> Not what you are actually changing, but "resolve" (a merge conflict) =
is
> not in the glossary.  For me
>
>   Wenn du das Problem _gel=C3=B6st_ hast...
>
> sounds nicer.  "aufgel=C3=B6st" sounds like "resolve a domain name" o=
r such.

Thanks.

>
>>  msgid "fatal: no such branch: $branch_name"
>> -msgstr ""
>> +msgstr "fatal: kein solcher Zweig: $branch_name"
>
> kein Zweig $branch_name gefunden?
>

what about "Zweig $branch_name nicht gefunden"?

Thanks
Ralf
