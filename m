From: Vampire <Vampire@Masters-of-Disaster.de>
Subject: Re: git svn clone failing
Date: Thu, 2 Jun 2011 19:48:08 +0200
Message-ID: <BANLkTimoDBr+ikZ4XoW1y=1=_JNOtp_jfg@mail.gmail.com>
References: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
 <1298033812.10893.23.camel@drew-northup.unet.maine.edu> <AANLkTim9obiU2H_PLb=O1=YxTr1nZ0v-zXC7mxUORVAH@mail.gmail.com>
 <1298587459.22431.19.camel@drew-northup.unet.maine.edu> <AANLkTikA2iRWH8Bh16CmpFpACSOjCiqc3c9cU69Jduv3@mail.gmail.com>
 <BANLkTine4g7LyiXmE6zYpNs7aa2FfXYGUg@mail.gmail.com> <BANLkTin7bxu_XZVYaVy+eXuhcJR83hXSew@mail.gmail.com>
 <1307019308.28941.4.camel@drew-northup.unet.maine.edu> <BANLkTikkXG95WxaDaFcJnCsQ_B5qHKUJwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:48:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSC0g-0007rA-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 19:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab1FBRsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 13:48:37 -0400
Received: from masters-of-disaster.de ([85.214.103.232]:58475 "EHLO
	masters-of-disaster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab1FBRsg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 13:48:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.69)
	(envelope-from <Vampire@masters-of-disaster.de>)
	id 1QSC0Y-0008Sq-O0
	for git@vger.kernel.org; Thu, 02 Jun 2011 19:48:34 +0200
Received: by bwz15 with SMTP id 15so1124017bwz.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 10:48:28 -0700 (PDT)
Received: by 10.204.83.129 with SMTP id f1mr1040683bkl.29.1307036908142; Thu,
 02 Jun 2011 10:48:28 -0700 (PDT)
Received: by 10.204.122.68 with HTTP; Thu, 2 Jun 2011 10:48:08 -0700 (PDT)
In-Reply-To: <BANLkTikkXG95WxaDaFcJnCsQ_B5qHKUJwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174964>

Hm, actually I found a workaround.
If I use https instead of http, it works fine.
But I think it should also work with http.

2011/6/2 Vampire <Vampire@masters-of-disaster.de>:
> It seems to me that this happens while git-svn is searching for histo=
ry.
> As far as I have understood git-svn searches hierarchical higher path=
s
> for history in other places than specified.
> I guess while trying to access all those paths some path is tried tha=
t
> returns 403 Forbidden.
> My assumption is that git-svn takes this as cause to abort instead of
> ignoring this return state what would be appropriate in this case I
> think.
>
> 2011/6/2 Drew Northup <drew.northup@maine.edu>
>>
>> On Thu, 2011-06-02 at 14:22 +0200, Vampire wrote:
>> > Drew?
>> >
>> I have no idea. If anybody else on the list does I'd welcome it, but=
 I
>> don't have any more time I can spend on this.
>>
>> > 2011/4/3 Vampire <Vampire@masters-of-disaster.de>
>> > =A0 =A0 =A0 =A0 Any news on this one?
>> >
>> >
>> > =A0 =A0 =A0 =A0 2011/2/25 Vampire <Vampire@masters-of-disaster.de>
>> > =A0 =A0 =A0 =A0 >
>> > =A0 =A0 =A0 =A0 > I tried it with 1.6.3.3 and with a self-compiled=
 version
>> > =A0 =A0 =A0 =A0 from latest git code.
>> > =A0 =A0 =A0 =A0 >
>> > =A0 =A0 =A0 =A0 > 2011/2/24 Drew Northup <drew.northup@maine.edu>
>> > =A0 =A0 =A0 =A0 > >
>> > =A0 =A0 =A0 =A0 > > On Fri, 2011-02-18 at 15:21 +0100, Vampire wro=
te:
>> > =A0 =A0 =A0 =A0 > > > Hi Drew,
>> > =A0 =A0 =A0 =A0 > > >
>> > =A0 =A0 =A0 =A0 > > > SVN client is in version 1.6.5.
>> > =A0 =A0 =A0 =A0 > > > svn co http://svn.apache.org/repos/asf/ant/c=
ore/trunk .
>> > =A0 =A0 =A0 =A0 > > > works fine and without problem.
>> > =A0 =A0 =A0 =A0 > > > I guess it is in the phase of searching for =
history in
>> > =A0 =A0 =A0 =A0 other places in
>> > =A0 =A0 =A0 =A0 > > > the repository and there some place is acces=
sed that is
>> > =A0 =A0 =A0 =A0 password
>> > =A0 =A0 =A0 =A0 > > > protected.
>> > =A0 =A0 =A0 =A0 > > > I did not contact the server admin as the no=
rmal svn
>> > =A0 =A0 =A0 =A0 client works fine
>> > =A0 =A0 =A0 =A0 > > > and so it seems to be a problem of git-svn, =
not of the
>> > =A0 =A0 =A0 =A0 SVN server.
>> > =A0 =A0 =A0 =A0 > > > Did you try the command I gave you and does =
it succeed
>> > =A0 =A0 =A0 =A0 for you? It is
>> > =A0 =A0 =A0 =A0 > > > a publicly available repository so you shoul=
d be able to
>> > =A0 =A0 =A0 =A0 reproduce the
>> > =A0 =A0 =A0 =A0 > > > problem.
>> > =A0 =A0 =A0 =A0 > > >
>> > =A0 =A0 =A0 =A0 > > > Regards
>> > =A0 =A0 =A0 =A0 > > > Bj=F6rn
>> > =A0 =A0 =A0 =A0 > >
>> > =A0 =A0 =A0 =A0 > > The error is reproducible, and I'm running a n=
ewer
>> > =A0 =A0 =A0 =A0 subversion client
>> > =A0 =A0 =A0 =A0 > > than you are. It definitely isn't making it th=
rough all of
>> > =A0 =A0 =A0 =A0 the revisions
>> > =A0 =A0 =A0 =A0 > > available before dying.
>> > =A0 =A0 =A0 =A0 > >
>> > =A0 =A0 =A0 =A0 > > .....
>> > =A0 =A0 =A0 =A0 > > Checked through r161300
>> > =A0 =A0 =A0 =A0 > > Checked through r161400
>> > =A0 =A0 =A0 =A0 > > RA layer request failed: Server sent unexpecte=
d return
>> > =A0 =A0 =A0 =A0 value (403 Forbidden) in response to REPORT reques=
t for
>> > =A0 =A0 =A0 =A0 '/repos/asf/!svn/vcc
>> > =A0 =A0 =A0 =A0 > > /default' at /usr/libexec/git-core/git-svn lin=
e 5131
>> > =A0 =A0 =A0 =A0 > >
>> > =A0 =A0 =A0 =A0 > > I forgot to ask, which version git are you run=
ning? I am
>> > =A0 =A0 =A0 =A0 running 1.7.4
>> > =A0 =A0 =A0 =A0 > > on the machine I tried this (RHEL5 RPM, compil=
ed locally).
>> > =A0 =A0 =A0 =A0 > >
>> > =A0 =A0 =A0 =A0 > > > 2011/2/18 Drew Northup <drew.northup@maine.e=
du>:
>> > =A0 =A0 =A0 =A0 > > > >
>> > =A0 =A0 =A0 =A0 > > > > On Mon, 2011-02-14 at 18:24 +0100, Vampire=
 wrote:
>> > =A0 =A0 =A0 =A0 > > > >> Hi,
>> > =A0 =A0 =A0 =A0 > > > >>
>> > =A0 =A0 =A0 =A0 > > > >> I'm trying to issue the following command=
:
>> > =A0 =A0 =A0 =A0 > > > >>
>> > =A0 =A0 =A0 =A0 > > > >> git svn clone --stdlayout
>> > =A0 =A0 =A0 =A0 http://svn.apache.org/repos/asf/ant/core/ .
>> > =A0 =A0 =A0 =A0 > > > >>
>> > =A0 =A0 =A0 =A0 > > > >> But unfortunately this fails after some t=
ime with the
>> > =A0 =A0 =A0 =A0 message:
>> > =A0 =A0 =A0 =A0 > > > >>
>> > =A0 =A0 =A0 =A0 > > > >> RA layer request failed: Server sent unex=
pected
>> > =A0 =A0 =A0 =A0 return value (403
>> > =A0 =A0 =A0 =A0 > > > >> Forbidden) in response to REPORT request =
for
>> > =A0 =A0 =A0 =A0 > > > >> '/repos/asf/!svn/vcc/default'
>> > =A0 =A0 =A0 =A0 at /usr/lib/git-core/git-svn line 4354
>> > =A0 =A0 =A0 =A0 > > > >>
>> > =A0 =A0 =A0 =A0 > > > >> Regards
>> > =A0 =A0 =A0 =A0 > > > >> Bj=F6rn
>> > =A0 =A0 =A0 =A0 > > > >
>> > =A0 =A0 =A0 =A0 > > > > Bj=F6rn,
>> > =A0 =A0 =A0 =A0 > > > > Have you made sure your subversion client =
is
>> > =A0 =A0 =A0 =A0 up-to-date? Does this work
>> > =A0 =A0 =A0 =A0 > > > > as a plain svn clone? Have you contacted t=
he server
>> > =A0 =A0 =A0 =A0 admin?
>> > =A0 =A0 =A0 =A0 > > > > Without context we cannot act on this.
>> > =A0 =A0 =A0 =A0 > > > >
>> > =A0 =A0 =A0 =A0 > >
>> > =A0 =A0 =A0 =A0 > > --
>> > =A0 =A0 =A0 =A0 > > -Drew Northup
>> > =A0 =A0 =A0 =A0 > > ______________________________________________=
__
>> > =A0 =A0 =A0 =A0 > > "As opposed to vegetable or mineral error?"
>> > =A0 =A0 =A0 =A0 > > -John Pescatore, SANS NewsBites Vol. 12 Num. 5=
9
>> > =A0 =A0 =A0 =A0 > >
>> >
>>
>> --
>> -Drew Northup
>> ________________________________________________
>> "As opposed to vegetable or mineral error?"
>> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>>
>
