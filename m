From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Configuring (future) committags support in gitweb
Date: Sun, 9 Nov 2008 01:25:11 +0100
Message-ID: <200811090125.12625.jnareb@gmail.com>
References: <200811082007.55045.jnareb@gmail.com> <200811082335.49505.jnareb@gmail.com> <200811090027.14343.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 01:36:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyyIE-0005Hd-03
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 01:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbYKIAZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 19:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbYKIAZX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 19:25:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:17306 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbYKIAZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 19:25:22 -0500
Received: by ug-out-1314.google.com with SMTP id 39so135164ugf.37
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=D3mWsw4hJ1jZp8TczFADz3LjVx5zcuLJKsEVJv7FsvA=;
        b=OFkXy3hPGjekcOsHTnm8oU8JrOHBeDwRXSSc6rC41kLirQgD3Ab5cXVF2XLYGMAFtp
         CG3olZF7GjFqtjz4xQci9+3ESvGAj1G8qyorWs9qg8q0fZNQZJtNZ4Gnl9bYwgIe2QbK
         AGRjH6xM2g7F1rDkeJBSIIrwKfMIQBaKJckn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MKP27dUyvm4VlJ/SfFy/kqDJKczPGfPjGZwY+HcUwKsx4wkVqEN8zq8+MIYlU/fydZ
         KyZKa0u8RdCPgNo7CI1y14MBGAsNxLRFM7eu77zqhqSy0b+EenapJez/krtSotli3/UJ
         YXFI1hlFW1Glnz9ORxKZL+6iqEFIYpsn0rXY8=
Received: by 10.210.16.10 with SMTP id 10mr5122839ebp.48.1226190319987;
        Sat, 08 Nov 2008 16:25:19 -0800 (PST)
Received: from ?192.168.1.11? (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id 5sm6764535eyh.2.2008.11.08.16.25.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 16:25:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811090027.14343.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100431>

Dnia niedziela 9. listopada 2008 00:27, Francis Galiegue napisa=C5=82:
> Le Saturday 08 November 2008 23:35:48 Jakub Narebski, vous avez =C3=A9=
crit=C2=A0:

>>> I don't understand what the "signoff" builtin is : is that a link t=
o see
>>> only commits "Signed-off-by:" a particular person?
>>
>> Committags doesn't need to be replaced by links. In this case I mean=
t
>> here using 'signoff' class for Signed-off-by: (and the like) lines, =
by
>> wrapping it in '<span class=3D"signoff">' ... '</a>'.
>=20
> Well, this would also mean to update gitweb.css, wouldn't it?

Not necessary. Please remember that you can configure gitweb to either
use _alternate_ stylesheet (instead of provided gitweb.css), or use
_additional_ stylesheet (for example gitweb-commit.css in addition to
gitweb.css)
=20
>>> And also, what about the sha1 builtin? AFAIK, a SHA1 can point to a
>>> commit, a tree, and others... In fact, it points to any of these ri=
ght
>>> now, but how would you tell apart these different SHA1s in a commit
>>> message? The only obvious use I see for it is the builtin "Revert .=
=2E."
>>> commit message, that the commiter _can_ override...
>>
>> SHA1 (or shortened SHA1 from 8 charasters to 40 characters, or to be
>> even more exact something that looks like SHA1) is replaced by link
>> to 'object' view, which in turn finds type of object and _redirect_
>> to proper view, be it 'commit' (most frequent), 'tag', 'blob' or 'tr=
ee'.
>>
>> We could have used instead gitweb link with 'h' (hash) parameter, bu=
t
>> without 'a' (action) parameter, which currently finds type of object
>> and _uses_ correct view...
>=20
> OK, you lost me somewhat.

I'm sorry about that. Perhaps I should use only one mechanism.
=20
> What I understand is that right now, the SHA1 links are "pre-processe=
d" by=20
> gitweb so that the 'a' parameter is correct, right?

No, they are 'post-processed': finding correct action is left to
_after_ you click on the link (it is more natural, and helps
performance).

If you don't know action for given SHA-1 you can use either

  http://example.com/gitweb.cgi?a=3Dobject;h=3Ddeadbeef

which finds correct type (for example 'commit') and redirects using
HTTP 302 Found redirection to

  http://example.com/gitweb.cgi?a=3Dcommit;h=3Ddeadbeef

This way is used bu SHA-1 committag in commit messages.


Alternate solution (meant for bugtrackers), done by another author,
is to simply skip action ('a') parameter:

  http://example.com/gitweb.cgi?h=3Ddeadbeef

and then gitweb finds type of object and act accordingly (without
redirect to correct view).

[...]
>>> Finally, is there any reason to think that a sha1 or signoff commit=
tag
>>> will ever need to be overriden in some way?
>>
>> One might not want to link SHA1, for example if there are lots of fa=
lse
>> positives because of commit message conventions or something, or ref=
ine
>> 'signoff' committag to use different styles for different types of
>> signoff: Signed-off-by, Acked-by, Tested-by, other.  Having explicit
>> 'signoff' committag allows us also to put some committags _after_ it=
,
>> for example SPAM-protection of emails, or add some committag before
>> 'sha1' to filter out some SHA1 match false positives.
>=20
> Hmmm, so this means you'd want to make styles customizable somewhat (=
signoff).=20
> In fact, what you really want is span for CSS! Then why not, just, ma=
king a=20
> document to say "This is what you can do with CSS for gitweb", and sa=
y "these=20
> are the available CSS tags", and then be done with it?
>=20
> I mean, when comes the day that someone will WANT other spans to be d=
efined,=20
> badly, it's not like it will be unheard of, won't it?=20

Errr... I don't understand.

The examples perhaps are not the best. One would be for example to use
different class (different style) for Signed-off-by signoff (which
denotes signing Certificate of Origin), and the rest of (informative)
signoff:

  [gitweb]
  	committags =3D sha1 signoff_signed signoff

Another example would be to add SPAM-protection of emails, for example
replacing 'user@example.com' by 'user AT example DOT com', or something
more advanced. This have to be used _after_ signoff, because otherwise
regexp could have difficulties matching mangled email

  [gitweb]
  	committags =3D sha1 signoff mailto

>>
>>> And I don't see what you '_a_' and '_b_' are about...
>>
>> For example in link match, the text of the link can be further refin=
ed
>> by committags later in sequence.
>=20
> I still don't get it. Can you give an example?

=46or example signoff line

  Signed-off-by: A U Thor <author@example.com>

would be replaced by

  {<span class=3D"signoff">}Signed-off-by: A U Thor <author@example.com=
>{</a>}
=20
where parts inside {...} is HTML code, and should be not expanded
further, and parts outside it could be expanded further by following
lower priority committags (like anti-SPAM for emails), and have to be
finally HTML escaped (like '<' and '>' in email in signoff).


=2E....................................................................

> [personal thoughts: it would be really, really nice if, somewhat, git=
web.perl=20
> were splitted somewhat into different modules, and ideally use more=20
> of "what's out there on CPAN". I'm convinced that some CPAN modules w=
ould be=20
> of GREAT help to gitweb, as well as I'm convinced that not many peopl=
e out=20
> there use Windows to run gitweb anyway :p]

=46irst, having gitweb in (almost) one piece makes for easier installat=
ion.
But there are plans to have gitweb use Git.pm or future Got::Repo and
friends. I'm not sure about further splitting...

Second, we cannot in good faith use CPAN modules which cannot be found
in standard Perl distributions, or at least in some trusted extras
package (application) repositories, as gitweb is sometimes run on
machines with tight security (think kernel.org for example) where you
cannot simply ask admin to install some third-party alpha-version CPAN
module.

--=20
Jakub Narebski
Poland
