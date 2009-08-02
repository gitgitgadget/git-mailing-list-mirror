From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5] Add Gitweb support for XZ compressed snapshots
Date: Mon, 3 Aug 2009 01:25:51 +0200
Message-ID: <200908030125.53534.jnareb@gmail.com>
References: <B05AF655-7430-420A-A22E-389601558B0D@uwaterloo.ca> <m3vdl7rjev.fsf@localhost.localdomain> <9b18b3110908010313x38991dffx3e4a2f2a5c5fff9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 01:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXkRO-0005MP-Mn
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 01:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZHBXZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Aug 2009 19:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbZHBXZ4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 19:25:56 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37946 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbZHBXZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 19:25:55 -0400
Received: by ewy10 with SMTP id 10so2683498ewy.37
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 16:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=53y93SIpz+vAlC9FwYDFe+6oYQYrWtdV+G+5bV3QhVw=;
        b=Tg2vcnEyp4I1qxdmv46UvazbKVM1Pl7dpDukkWhx9gRoE9flfM6yevlvxANhUUzjsD
         751tEOAydyJyMrY3uoZfkY7X0xb8xjkZJ69rOtqgaXZiL49bIIiyvpx9gy0QX2K9lA64
         ho3o77RTseUVq+cTMru7Z8MFAzQ+MbGPD+fqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HAagmPIbd4lSSJCMFhEKK6px+BcYZ/LHJl3JR2mXpIyXsfDz1vTECUrjrJK8LXivKr
         vKlzqi2R0Nf6YoTfb89SNb5d3+gqSckMP1lMxLwec/rW+bt02HskzbnIkW78i3XQV748
         R5uGmB4QP+OTvG9xgIL5I0JDokMA7fz7DoV/o=
Received: by 10.210.19.7 with SMTP id 7mr4242464ebs.52.1249255554919;
        Sun, 02 Aug 2009 16:25:54 -0700 (PDT)
Received: from ?192.168.1.13? (abwm214.neoplus.adsl.tpnet.pl [83.8.236.214])
        by mx.google.com with ESMTPS id 24sm9032729eyx.3.2009.08.02.16.25.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Aug 2009 16:25:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <9b18b3110908010313x38991dffx3e4a2f2a5c5fff9f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124677>

On Sat, 1 Aug 2009, demerphq wrote:
> 2009/8/1 Jakub Narebski <jnareb@gmail.com>:
>> demerphq <demerphq@gmail.com> writes:
>>
>>> FWIW the perl project ripped out all the snapshot generation logic
>>> from gitweb, and replaced it with a tool that generates snapshots
>>> correctly for our requirements (if the build process needs addition=
al
>>> files /currently/ git-archive does not support adding them), this
>>> includes a disk level cache for the snapshots since creating the ta=
r,
>>> adding the additional files, then gziping is quite slow.
>>>
>>> If its interesting to people I can post it and the other changes he=
re,
>>> although its not a "nice" change, as I literally ripped out the
>>> existing code.
>>
>> Do you mean gitweb serving http://perl5.git.perl.org/ ?
>=20
> Yes. I updated it to a relatively recent version just the other week.

By the way, if you don't mind, how do you keep your changes on top
of changing target, i.e. on top of updating baseline to recent=20
versions?

>=20
>> Well, at least publish this version of gitweb somewhere (snapshot or
>> better git repository), and add it to the list of gitweb forks at
>> http://git.or.cz/gitwiki/Gitweb wiki page.
>=20
> Sure, we have been discussing doing that recently.
>=20
> I need to cleanup how I set up the repository for it tho.

O.K.

>=20
> Also probably there are one or two patches that should be pushed back
> to you.=20

What do those patches consist of?
=20
>> Sidenote: snapshot support appeared, as far as I know, first at fork=
 of
>> gitweb that had been used by XMMS2, but the snapshot was generated b=
y
>> a separate snapshot.cgi script... written in Python. =A0(Now they us=
e
>> stock (if old) gitweb, I think.)
>=20
> Ah, I'm not generating it with a separate cgi script, I just replaced
> the call to git-archive to be a call to my own tool.

O.K. =20

By the way, this is one of the only two places where we have to
use quote_command and 3-argument form of open, instead of list for of
magic open.  It is because of pipeline, piping git-archive output
into compressor.  The other such place is git_object, to redirect error
stream to /dev/null (to discard stderr).

I thought about replacing it by list form of open somewhat (you can
find it in git mailing list archive), but it is not easy.  And IPC::Run
is IMVHO a bit of overkill, especially for "minimal dependencies"
gitweb (perhaps for Git::Web?).

>=20
>> P.S. Perhaps you or other Perl Mongers would be interested in creati=
ng
>> yet another git web interface, in Perl, but contrary to (current)
>> gitweb modular and using more of CPAN modules? =A0For example conver=
t
>> SVN::Web or Insurrection (or other Perl module) from Subversion (or
>> other SCM) to Git (and rename it to Git::Web, or ???).
>=20
> I think that there is some interest in doing that and likely over tim=
e
> there will be more. It has come up at least a few times in our
> discussion forums. I think you could easily make a public call for
> support on places like Perlmonks to get more action tho.

Thanks in advance.

>=20
> A better git api toolset for perl would make things a lot easier.
> Especially an XS one.

Well, in the beginnings of Git.pm there was XS interface (to=20
git-hash-object or git-cat-file), but it was dropped because it
used -fPIC, which is not portable enough for Git (this is not present
in perl/Git.pm history in git.git repository).  Git.pm was created
by Petr 'Pasky' Baudis, author of Cogito porcelain, and creator and
admin of repo.or.cz (and also creator of first Git homepage). =20
But he is not a Perl hacker (correct me if I am wrong, Pasky); both
Cogito and repo.or.cz duct tape (under name of Girocco) are written
in bash, not in Perl.  Which can be seen for example by using=20
Error::Simple in Git.pm...

Also I don't think that Pasky has time for maintaining Git.pm,=20
nevermind modernizing it / adding new features.

There was another attempt to make Perl interface for Git, more=20
object-oriented, by Lea Wiemann during GSoC 2008 project 'gitweb cachin=
g'.
You can see results in Lea repository at repo.or.cz[1], and also in=20
git.kernel.org gitweb code[2].

[1]: http://repo.or.cz/w/git/gitweb-caching.git
[2]: http://git.kernel.org/?p=3Dgit/warthog9/gitweb.git
=20
>>
>> P.P.S. Could you per chance post announcement of Git User's Survey 2=
009
>> on http://perl5.git.perl.org, just like it is done on http://repo.or=
=2Ecz
>> and http://git.kernel.org? =A0TIA.
>=20
> Sure.

Hmmm... I don't see "Git User's Survey 2009" announcement at=20
http://perl5.git.perl.org/.  Neither at Planet Perl Iron Man, nor at
Perlsphere

--=20
Jakub Narebski

Git User's Survey 2009:
http://tinyurl.com/GitSurvey2009
