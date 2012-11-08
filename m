From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 08 Nov 2012 13:17:43 +0100
Message-ID: <509BA2E7.4080102@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com> <509B7E6B.1030407@alum.mit.edu> <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWR3a-0006XN-UC
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 13:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab2KHMRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 07:17:49 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:53272 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755390Ab2KHMRr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 07:17:47 -0500
X-AuditID: 1207440c-b7f616d00000270b-6b-509ba2eb991a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.48.09995.BE2AB905; Thu,  8 Nov 2012 07:17:47 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA8CHiwP004664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Nov 2012 07:17:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTURju3Lu549yN45zzZGK1EKOYKZgsEA0VXD8KI+jzh9306Gbbndx7
	J1sUzISSlWBgkFP7sE/TEkNLJciGaCmBnylhhR9JaWBmFhh93OtQ+3N4zvu8z/NwzvtCWtuj
	jIRWTiQ8x9oMQWqFVpWxxThbW5UV/6kXmro/jihMD6fHKJN36CJl8pQN0aaBhUalqXiKN9VP
	jqlMc6//0nuguc33TmW+/L1bae4f2GpeeBxt7hicDMpSHgtJPsmKRQet+dzOlBMhlpalK3Th
	hSjX2z/NtAeU6r0gGGKUiKeHf6oCWI/73jcGeYEaatEgwFVtnarApYvCLzqblF4AIYN24POd
	SBYoUAz2X29fFgchI669VELJOBwdwg3P/MuYQaH4VeWUQsY6lIkXf9dTsieN/BTuarq/3BSG
	0nFddSsVCCujcEPFM1omgtEB7PFWUHIwjWJx4zWtXKbRJlzSUkWXA+T7L8O31uX7r+sGoB+A
	aNbmtBvtrNUmkByjkMNyHOGNCXF2qxhHcp2PQeD/Na3gx6MoP0AQGDSMVlGVpVWyRYLb7gcb
	IGUIZ47elErrTzpy3RZWsGTzThsR/ABD2qBjYLnEMbms+zThHSvURqgwRDAxt2P3a1E+K5JT
	hBQSfoWNgtCAmW2yaShP8okrz2oT12gKBsvm6kidQLhcwrNO0ZItDzVbkKYqUxopN0uWM0Ih
	a5eqAWkP2A3ni6+NAzjw/KZ0ekprx4FWwTk4EhnB6GUBkgUWJ7cat7KCMyBCen0Ykyx3aaQF
	XXWdkQIpKVB4c1UOFNk1KtID1HkpSxcdm9l8MdVf8LRfn9Y3Eloy4kr4tTRxSxeb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209155>

On 11/08/2012 12:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]

I'm glad it's getting some use.  Thanks for the feedback.

> I'll test it out some more, the issues I've had with it so far in
> migrating from the existing script + some custom hacks we have to it
> have been:
>=20
>  * Overly verbose default templates, easy to overwrite now. Might sen=
d
>    patches for some of them.

The templating is currently not super flexible nor very well documented=
,
but simple changes should be easy enough.  I mostly carried over the
text explanations from the old post-receive-email script; it is true
that they are quite verbose.

>  * No ability to link to a custom gitweb, probably easy now.

What do you mean by "a custom gitweb"?  What are the commitmail issues
involved?

>  * If someone only pushes one commit I'd like to only have one e-mail
>    with the diff, but if they push multiple commits I'd like to have =
a
>    summary e-mail and replies to that which have the patches.
>=20
>    It only seemed to support the latter mode, so you send out two
>    e-mails for pushing one commit.

That's correct, and I've also thought about the feature that you
described.  I think it would be pretty easy to implement; it is only no=
t
quite obvious to which mailing list(s?) such emails should be sent.

>  * Ability to limit the number of lines, but not line length, that's
>    handy for some template repositories. Should be easy to add

Should too-long lines be folded or truncated?  Either way, it should be
pretty straightforward (Python even has a textwrap module that could be
used).

> But in addition to that we have our own custom E-Mail notification
> scripts for:
>=20
>  * People can subscribe to changes to certain files. I.e. if you
>    modify very_important.c we'll send an E-Mail to a more widely seen
>    review list.
>=20
>  * Invididuals can also edit a config file to watch individual files =
/
>    glob patterns of files, e.g. src/main.c or src/crypto*

I implemented something like this back when we were using Subversion,
but it didn't get much use and seemed like more configuration hassle
than it was worth.

If this were implemented and I asked for notifications about a
particular file, and a particular reference change affects the file,
what should I see?

* The summary email for the reference change (yes/no)?

* Detail emails for all commits within the reference change, or only fo=
r
the individual commits that modify the file?

* Should the detail emails include the full patch for the corresponding
commit, or only the diffs affecting the file(s) of interest?  (The
latter would start to get expensive, because the script would have to
generate individual emails per subscriber instead of letting sendmail
fan the emails out across all subscribers.)

> I think a good way to support that would be to have either a path to =
a
> config file with those watch specs, or a command so you could run "gi=
t
> show ..." on some repo users can push to.

*How* this feature would be configured depends strongly on how the repo
is hosted.  For example, gitolite has a well-developed scheme for how
the server should be configured, and it would make sense to work
together with that.  Other people might configure user access via LDAP
or Apache.

> But overall it's very nice. I'll make some time to test it in my
> organization (with lots of commits and people reading commit e-mails)=
=2E

Cool, thanks!

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
