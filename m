From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 20:33:35 -0000
Organization: OPDS
Message-ID: <AE5DE037F2E44705AC6716EEB19948B1@PhilipOakley>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com> <87sj5l38d6.fsf@pctrast.inf.ethz.ch> <20130128175514.GA2926@rath-ubuntu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, "Git List" <git@vger.kernel.org>
To: "Ralf Thielow" <ralf.thielow@gmail.com>,
	"Thomas Rast" <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzvOs-0001oS-JB
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab3A1Udc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 15:33:32 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:30314 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753426Ab3A1Udb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 15:33:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhYKAIjdBlFcHKA3/2dsb2JhbABEjAOxUwN8F3OCGQUBAQQBCAEBKAEFHgEBIQUGAgMFAgEDFQECCSUUAQQIEgYHFwYBEggCAQIDAYduAwkKCLZADYlVjBCBH4MVYQOILIVShjmCcooahRKCdw
X-IronPort-AV: E=Sophos;i="4.84,554,1355097600"; 
   d="scan'208";a="60988937"
Received: from host-92-28-160-55.as13285.net (HELO PhilipOakley) ([92.28.160.55])
  by out1.ip07ir2.opaltelecom.net with SMTP; 28 Jan 2013 20:33:29 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214864>

=46rom: "Ralf Thielow" <ralf.thielow@gmail.com>
Sent: Monday, January 28, 2013 5:55 PM
> On Mon, Jan 28, 2013 at 11:33:09AM +0100, Thomas Rast wrote:
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>> >  #: builtin/reset.c:275
>> > -#, fuzzy, c-format
>> > +#, c-format
>> >  msgid "Failed to resolve '%s' as a valid revision."
>> > -msgstr "Konnte '%s' nicht als g=FCltige Referenz aufl=F6sen."
>> > +msgstr "Konnte '%s' nicht als g=FCltige Revision aufl=F6sen."
>>
>> You don't have "revision" in the glossary[1] yet.  Wouldn't it be
>> appropriate to treat it as "commit", and translate as "Version" to
>> avoid
>> introducing yet another term?
>>
>> Or am I missing some subtle distinction between commit and revision?
>>
>
> I don't think there's a distinction.

It was a problem I had http://stackoverflow.com/a/11792712/717355
answered as:

See "SPECIFYING REVISIONS" of git rev-parse:

  A revision parameter <rev> typically, but not necessarily, names a=20
commit object.
  It uses what is called an extended SHA1 syntax, [and includes] variou=
s=20
ways to spell object names.

It had me confused for a while.

>                 Since we've already translated
> "revision" as "Revision" in a couple of other messages, I'll make a
> new "s/Revision/Version" commit on top.
>
>> Since it's only a single nit, feel free to add my ack when you
>> reroll:
>>
>> Acked-by: Thomas Rast <trast@inf.ethz.ch>
>>
>>
>> [1] https://github.com/ralfth/git-po-de/wiki/Glossary
>>
>> --=20
>> Thomas Rast
>> trast@{inf,student}.ethz.ch
> --
Philip Oakley=20
