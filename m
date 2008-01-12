From: Humberto Diogenes <humberto@digi.com.br>
Subject: Re: [PATCH] manpages: linking all mail-related commands
Date: Fri, 11 Jan 2008 22:44:04 -0300
Message-ID: <B4D45D5C-618B-46E4-B66A-27914EF810A7@digi.com.br>
References: <1200095286-2621-1-git-send-email-humberto@digi.com.br> <7vy7avzwx4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVQL-0003cD-O1
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbYALBoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 20:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762805AbYALBoJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:44:09 -0500
Received: from huguinho.digi.com.br ([201.76.144.70]:1025 "EHLO
	huguinho.digi.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962AbYALBoI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 20:44:08 -0500
Received: from eddie.digi.com.br (eddie.digi.com.br [201.76.154.21])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by huguinho.digi.com.br (Postfix) with ESMTP id 9421D3331D7;
	Fri, 11 Jan 2008 22:44:04 -0300 (GMT+3)
In-Reply-To: <7vy7avzwx4.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70248>


   Wow! I wasn't expecting that amount of reply for such a simple =20
patch. :-) I just found it unnecessarily hard to discover all the =20
email-related commands in git (even though I already used some of =20
them). My point-of-view is that some additional links wouldn't hurt. =20
More answers below.

On 11/01/2008, at 21:53, Junio C Hamano wrote:

> Humberto Diogenes <humberto@digi.com.br> writes:
>
>> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
>> index e4a6b3a..fd00fc1 100644
>> --- a/Documentation/git-am.txt
>> +++ b/Documentation/git-am.txt
>> @@ -144,8 +144,10 @@ names.
>>
>> SEE ALSO
>> --------
>> -gitlink:git-apply[1].
>> -
>> +gitlink:git-apply[1],
>> +gitlink:git-format-patch[1],
>> +gitlink:git-imap-send[1],
>> +gitlink:git-send-email[1]
>
> I do not see a point in this.  "am" is a tool for people who
> accept and they do not care how the sender prepared
> (format-patch) nor sent (imap-send nor send-email).

   Well, if I'm reading the docs about how a program works with some =20
input, I'll sure want to know which commands in the package generate =20
that kind of output. I think at least git-format-patch deserves a link =
=20
(am: read, format-patch: write).
   And yes, I managed to find git-am and git-send-email but couldn't =20
remember the name of git-format-patch.

> On the other hand, as am uses mailinfo and mailsplit, it may be
> worth mentioning them (although I suspect not all the readers of
> manual page of am are interested in such a low level details).

   I think it wouldn't hurt.

>> diff --git a/Documentation/git-apply.txt b/Documentation/git-=20
>> apply.txt
>> index c1c54bf..53fa937 100644
>> --- a/Documentation/git-apply.txt
>> +++ b/Documentation/git-apply.txt
>> @@ -189,6 +189,10 @@ If --index is not specified, then the =20
>> submodule commits in the patch
>> are ignored and only the absence of presence of the corresponding
>> subdirectory is checked and (if possible) updated.
>>
>> +See Also
>> +--------
>> +gitlink:git-am[1]
>
> Why?  apply is not about email at all.  am uses apply but not
> the other way around.

   Imagine you don't know git, but know there's some command to apply =20
patches from mailboxes. Which one would you try first: git-am or git-=20
apply? "git-am" just doesn't say anything (for beginners, at least).

> This feels you are going a bit overboard, as if you are adding
> "See Also: git[7]" everywhere (even though it is not that bad).

   Again: wouldn't hurt. :)

>> -See Also
>> +SEE ALSO
>> --------
>
> If you are standardizing between "SEE ALSO" and "See Also", I
> think that is a worthy thing to do independent from the
> additional links, but (1) please be consistent --- you tried to
> add "See Also" yoruself above, (2) please have a separate patch
> that does _ONLY_ the standardization to "SEE ALSO", and not
> limited to commands that has (maybe remotely) something to do
> with emailed patch workflow.
>
> Right now, I count 14 "SEE ALSO" and 17 "See Also".  127 spell
> "Author" and 5 spell "AUTHOR".  Everybody says "NAME", "SYNOPSIS",
> "DESCRIPTION", and "OPTIONS".
>
> I think we should spell these in all uppercase.

   Yes, I could see this one coming. Sorry.


--
Humberto Di=F3genes
http://humberto.digi.com.br
