From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Tue, 03 Dec 2013 15:58:39 +0100
Message-ID: <1386082719.2208.17.camel@localhost.localdomain>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
	 <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
	 <1385985997.2054.27.camel@localhost.localdomain>
	 <529CC48C.5080902@gmail.com>
	 <1386068026.2208.16.camel@localhost.localdomain>
	 <CANQwDwcBx-rbiLwVY6zAmixr=93vyvpVWcCZMLuSEBgjTJ4-tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 15:58:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnrR1-0007Wp-6x
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 15:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab3LCO6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 09:58:43 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:60412 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab3LCO6m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 09:58:42 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so6105665bkh.31
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 06:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=XP57NfIdcNdfNdr6py0gKMPyxAHw/cap1TG99TWrUwg=;
        b=bxIfccCba2jVGYUieVqD9HnyUrmoFumXf3JOZrolBMnh8LuvY6qiMqtXjvdVPjxxsG
         Qd4du62NybhIiIEF0sR7fseVUQzh9lvvNMRKHWoic3o8NNknNghVNvm9dt9589M9oTz6
         kxX+ygedsvFgxOcX4KZ9HtH8ZuVrXRxtIb0hhf3IWzg3DJfxw96fnZMsEztX+Rml8yCI
         4fERj54X1arGGxgZsaAhl0fLzVIMsgFDEKEr4vMZgrBWgP7u2AqhINSkHcxOvm+LGSHX
         JeO8plDcASOA3XrBPLKOOxLJ96XbAz/GRp54UuA3jYhKP5DAqSbctMNlh/vYGNm/zPW6
         kuJg==
X-Gm-Message-State: ALoCoQkHsfjKd7oFL3BuZzYclDFBWsXXB4OmfmluYrd8lXziRDRp20ayiDMFQAP1ixroYLH29J4d
X-Received: by 10.205.74.4 with SMTP id yu4mr423476bkb.104.1386082721368;
        Tue, 03 Dec 2013 06:58:41 -0800 (PST)
Received: from [192.168.178.31] (p5792264C.dip0.t-ipconnect.de. [87.146.38.76])
        by mx.google.com with ESMTPSA id no2sm78839913bkb.15.2013.12.03.06.58.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 06:58:40 -0800 (PST)
In-Reply-To: <CANQwDwcBx-rbiLwVY6zAmixr=93vyvpVWcCZMLuSEBgjTJ4-tg@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238697>

On Tue, 2013-12-03 at 14:02 +0100, Jakub Nar=C4=99bski wrote:
> On Tue, Dec 3, 2013 at 11:53 AM, Krzesimir Nowak <krzesimir@endocode.=
com> wrote:
> > On Mon, 2013-12-02 at 18:34 +0100, Jakub Nar=C4=99bski wrote:
> >> W dniu 2013-12-02 13:06, Krzesimir Nowak pisze:
> >>> On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
> >>>> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
> >>>> <krzesimir@endocode.com>  wrote:
> >>>>
> >>>>> Allow @additional_branch_refs configuration variable to tell gi=
tweb to
> >>>>> show refs from additional hierarchies in addition to branches i=
n the
> >>>>> list-of-branches view.
> >>>>>
> >>>>> Signed-off-by: Krzesimir Nowak<krzesimir@endocode.com>
> >>>>
> >>>> Why not use %feature hash instead of adding new configuration va=
riable?
> >>>> I think that this option is similar enough to 'remote_heads' fea=
ture
> >>>> (which BTW should be 'remote-heads'), and could conceivably enab=
led
> >>>> on a per-repository basis, i.e. with repository configuration ov=
erride,
> >>>> isn't it?
> >>>
> >>> I'd like to see some consensus on it before I start changing the =
patch
> >>> again.
> >>
> >> %feature hash is mainly (but not only) about options that can be
> >> configured on per-repository basis.  Configuration variables are
> >> about options that are per-instance (per gitweb).
> >
> > Well, I am mostly interested in per-instance configuration in this =
case,
> > but if that is also possible with %feature hash, then ok, I'll try =
to
> > make it work.
>=20
> Yes, it is possible to have per-instance configuration (you can even
> forbid per-repository configuration).
>=20
> > From what I've seen (correct me please if I got it wrong) feature
> > settings is taken from per-repository config file from [gitweb] sec=
tion.
> > If there's nothing then some default value is taken. That default v=
alue
> > can be overriden with per-instance perl config file.
>=20
> %feature settings are taken from gitweb configuration (the 'default'
> key), and if given feature is overrideable and per-repository configu=
ration
> in the form of appropriate key in [gitweb] section of repository conf=
ig
> file exists, it is used instead.
>=20
> > So it is easy to override it from per-instance perl config by typin=
g:
> > $feature{'additional-branch-refs'}{'default'} =3D ['wip', 'no|tf"un=
,ny'];
> > $feature{'additional-branch-refs'}{'override'} =3D 1;
>=20
> Yes.  The 'override' is about checking (which imposes a bit of
> performance penalty) and respecting per-repository configuration.
>=20
> > (Note the edge case of refs/no|tf"un,ny, which passes the git
> > check-ref-format scrutiny.)
> >
> > But for now, most of features are quite simple - either booleans,
> > integers or list of simple strings (in snapshot feature). What I ne=
ed
> > here is a list of strings, like CSV in following example:
> > [gitweb]
> >         additional_branch_refs =3D wip,"no|tf""un,ny"
> >
> > Is dependency on external module like Text::CSV or Text::CSV_XS ok?=
 If
> > not, I can hack some CSV reading code.
>=20
> Why not use space, which is forbidden in refnames, to separate
> entries?  Similar to feature_snapshot(), which is about comma separat=
ed
> list, without escaping.
>=20

Thanks for explanations and a hint. Following patches are in "Show extr=
a
branch refs in gitweb".

Cheers,
--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
