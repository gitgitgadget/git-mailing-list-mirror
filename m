From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 11 new messages
Date: Tue, 29 Jan 2013 08:42:14 +0100
Message-ID: <CAN0XMOK6PMCC-Cr9cX9a3ng6+gijAOTQf2WmxyTXXpZ2TvR3Cg@mail.gmail.com>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
	<87sj5l38d6.fsf@pctrast.inf.ethz.ch>
	<20130128175514.GA2926@rath-ubuntu>
	<AE5DE037F2E44705AC6716EEB19948B1@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, jk@jk.gs, stimming@tuhh.de,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 08:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U05q2-0000ec-Rp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 08:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab3A2HmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 02:42:17 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:54961 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab3A2HmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2013 02:42:15 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so87134wgb.8
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 23:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=E3e5RrWE6vdFkM5sx9oofnAI8C0gIuUwGtZSWj2QvY4=;
        b=gjvpTq1NmwSGP/uzNYip98uaEVyakYuHiVmAkdFjHZzme6XZ0vAqBv02cXhBA3InnS
         hOxZTCA9AywvkpmYXiZzjW5R2XJcZAwMLjate+AbG3TUcS81hZ2+DHRvE1arnfvqXfMZ
         wxxwyicJOyWgiYM/JtzqgkKROV1ySeN98hoU3sMwwus8RY5G8JPWCdf/FyVRgASuEW8e
         H1KfYE5TSVNs0xffciiwoKeWOAJjxDKV/tOW5FB2DN0370wGThUPrf9AFtLZdEwQpV3T
         WluWJFyL+mqqqu6oRQrVOUlgz1O9YzKVNpuYkhBHe00pwW+3laIrjlRNOb2pJUmDKo7R
         vkBA==
X-Received: by 10.194.238.5 with SMTP id vg5mr301542wjc.40.1359445334546; Mon,
 28 Jan 2013 23:42:14 -0800 (PST)
Received: by 10.195.12.199 with HTTP; Mon, 28 Jan 2013 23:42:14 -0800 (PST)
In-Reply-To: <AE5DE037F2E44705AC6716EEB19948B1@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214908>

2013/1/28 Philip Oakley <philipoakley@iee.org>:
> From: "Ralf Thielow" <ralf.thielow@gmail.com>
> Sent: Monday, January 28, 2013 5:55 PM
>
>> On Mon, Jan 28, 2013 at 11:33:09AM +0100, Thomas Rast wrote:
>>>
>>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>>
>>> >  #: builtin/reset.c:275
>>> > -#, fuzzy, c-format
>>> > +#, c-format
>>> >  msgid "Failed to resolve '%s' as a valid revision."
>>> > -msgstr "Konnte '%s' nicht als g=C3=BCltige Referenz aufl=C3=B6se=
n."
>>> > +msgstr "Konnte '%s' nicht als g=C3=BCltige Revision aufl=C3=B6se=
n."
>>>
>>> You don't have "revision" in the glossary[1] yet.  Wouldn't it be
>>> appropriate to treat it as "commit", and translate as "Version" to
>>> avoid
>>> introducing yet another term?
>>>
>>> Or am I missing some subtle distinction between commit and revision=
?
>>>
>>
>> I don't think there's a distinction.
>
>
> It was a problem I had http://stackoverflow.com/a/11792712/717355
> answered as:
>
> See "SPECIFYING REVISIONS" of git rev-parse:
>
>  A revision parameter <rev> typically, but not necessarily, names a c=
ommit
> object.
>  It uses what is called an extended SHA1 syntax, [and includes] vario=
us ways
> to spell object names.
>
> It had me confused for a while.
>

Thanks. So it would be a mistake to translate "revision" and "commit"
with the same word. This would hide the special meaning of revision and
the user wouldn't see that there's a difference.

I'll amend the commit which unifys the translation of "revision" and "c=
ommit"
in the way that "revision" will be translated as "Revision" in the whol=
e file.
I'll also update the glossary.

>>                 Since we've already translated
>> "revision" as "Revision" in a couple of other messages, I'll make a
>> new "s/Revision/Version" commit on top.
>>
>>> Since it's only a single nit, feel free to add my ack when you
>>> reroll:
>>>
>>> Acked-by: Thomas Rast <trast@inf.ethz.ch>
>>>
>>>
>>> [1] https://github.com/ralfth/git-po-de/wiki/Glossary
>>>
>>> --
>>> Thomas Rast
>>> trast@{inf,student}.ethz.ch
>>
>> --
>
> Philip Oakley
