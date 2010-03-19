From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 14:57:59 +0000
Message-ID: <3f4fd2641003190757y39050691y3dc0ca08bd5196fb@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4BA338C1.7030803@alum.mit.edu>
	 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
	 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
	 <20100319115445.GA12986@glandium.org>
	 <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
	 <b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, david@lang.hm, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 16:03:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsdjD-0001rQ-4L
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab0CSO6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 10:58:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63546 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0CSO6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:58:01 -0400
Received: by wyb38 with SMTP id 38so1554762wyb.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EbD0C454tEk+6GbHiFVdNkwLhqV3YvSNFtTSaShPV5A=;
        b=uXSTX4tnQ9Yw9T6IiCkJp8OolVnWvR+vaY/r4BF47ZskDkxdJ9G+TK4Ofsx9eRzR8W
         O1/ftg2WekqRhGh1/VgYAuZzkQsSJ/VFO4MY4HyN/Z+YRMwUgrIgNMatBUos/6BYG2hX
         DioI9ljtL0AYo6Wgj/DYv1lSSdrsRkKv88D/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bp1DTKaLVJNy7XXEZ6u8AgWcINaS8w06KBQ+35CZ9Sp4K9aNUZcNLp4+FnOsFOn6ZJ
         OS80DUyO4PCYa10niLW9XEaPvoKI54mTcjUWOtbtSDy8S2iU9p9Ya+tVuzpBy/EmsBdw
         P4ESBJZtw/SSnX2xOfwjKUmEVA9oaQgt3aQA8=
Received: by 10.216.90.196 with SMTP id e46mr2623458wef.138.1269010679851; 
	Fri, 19 Mar 2010 07:57:59 -0700 (PDT)
In-Reply-To: <b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142609>

On 19 March 2010 12:16, Michael Witten <mfwitten@gmail.com> wrote:
> On Fri, Mar 19, 2010 at 06:09, Reece Dunn <msclrhd@googlemail.com> wr=
ote:
>> On 19 March 2010 11:54, Mike Hommey <mh@glandium.org> wrote:
>>> On Fri, Mar 19, 2010 at 04:45:38AM -0700, david@lang.hm wrote:
>>>> here is where you are missing the point.
>>>>
>>>> no, there is not 'much less chance' of it getting messed up.
>>>>
>>>> you seem to assume that people would never need to set the UUID on
>>>> multiple machines.
>>>>
>>>> if they don't need to set it on multiple machines, then the
>>>> e-mail/userid is going to be reliable anyway
>>>>
>>>> if they do need to set it on multiple machines and can't be bother=
ed
>>>> to keep their e-mail consistant, why would they bother keeping thi=
s
>>>> additional thing considtant? Linus is pointing out that people don=
't
>>>> care now about their e-mail and name, and will care even less abou=
t
>>>> some abstract UUID
>>>>
>>>> people who care will already make their e-mail consistant.
>>>
>>> While I don't agree with the need for that uuid thing, I'd like to
>>> pinpoint that people who care can't necessarily make their e-mail
>>> consistant. For example, Linus used to use an @osdl.org address, an=
d
>>> he now uses an @linux-foundation.org address. It's still the same L=
inus,
>>> but the (name, email) pair has legitimately changed.
>>
>> So create an aliases list that maps one (name,email) to another that
>> is from the same person. There is no need for an additional item (a
>> uuid) to solve this problem. It also means that searching on any
>> (name,email) pair will find the others, so you only need to
>> remember/find one of the identities for the person you are intereste=
d
>> in finding the commits for.
>>
>> AFAICS, mailmap is about correcting mistakes (primarily in the
>> reported name for a given email address). In this case, mailmap and
>> this aliases-map will work in conjunction with each other to give wh=
at
>> the original poster wanted. However, I haven't seen any of his repli=
es
>> that answer this (or sufficiently address why mailmap does not solve
>> his problem).
>
> See:
>
> =A0 =A0http://marc.info/?l=3Dgit&m=3D126900051102958&w=3D2
>
> The idea is to distribute the responsibility for maintaining a
> consistent identity AND to make that responsibility EASY.
>
> The extra uuid `field' can only suffer from typos, while the
> name/email pair can suffer from typos, changing email accounts, and
> changing real life names. If the uuid `field' does get bungled by a
> typo or is not used, then we're no worse off than we were before.

What specific problem(s) are you trying to solve?

The main issue is identifying who made what changes to a repository
(e.g. by a script, or database/statistics algorithms). The mailmap
file allows for corrections to a canonical (name,email) pair for a
specified repository.

=46or identifying the same person working across multiple projects,
ideally they should keep the canonical (name,email) pair consistent
across all projects, with mailmap files in the respective projects to
keep the canonical form correct.

This canonical (name,email) pair is then a unique identifier for that
person and then effectively becomes a uuid. There is no need to add an
extra uuid field that needs *more* work fixing up errors and making
consistent.

If you change email address or name, *and* care enough about it being
consistent, there is no reason why you cannot update the mailmap file
to use the new canonical (name,email) pair.

Oh, and you are expressing it wrong (if I understand you correctly)...

What you are after is a string U (the uuid) that is used to identify a
person irrespective of their name and email. At the moment
   U =3D (name,email)
is used to achieve that, with mailmap to normalise the variations.

What you are trying to express is:
    U <=3D> (name,email)
where U can be any unique string. This is different from using a
(name,email,uuid) triple to identify someone.

So, lets say that I choose U=3Dabc to identify myself uniquely, so that=
:
    "abc" <=3D> "Reece Dunn <msclrhd@gmail.com>"
    "abc" <=3D> "Reece Dunn <msclrhd@googlemail.com>"
    "abc" <=3D> "Reece Dunn <msclrhd@hotmail.com>"
    "abc" <=3D> "Reece H. Dunn <msclrhd@gmail.com>"
    "abc" <=3D> "Reece H Dunn <msclrhd@gmail.com>"

I would still need to define all these variations when and as they
occur in a repository to fixup any typos and email address changes
that occur, so why not just pick U =3D "Reece H. Dunn
<msclrhd@gmail.com>" as the canonical form instead of "abc" or some
other string?

As has been said, mailmap supports name variations ("Reece Dunn",
"Reece H Dunn", "Reece H. Dunn") and email variations
(msclrhd@hotmail.com, msclrhd@gmail.com, msclrhd@googlemail.com), so
how does a string that I need to set on the git client in addition to
name and email help me define a canonical form *in the git
repository*?

So, I'll ask again: what problems are you trying to solve that cannot
be solved by mailmap?

- Reece
