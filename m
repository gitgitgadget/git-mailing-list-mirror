From: Jeff King <peff@peff.net>
Subject: Re: git-owner, was Re: [bug] first line truncated with `git log
 --oneline --decorate --graph`
Date: Thu, 16 Apr 2015 12:26:21 -0400
Message-ID: <20150416162620.GA10573@peff.net>
References: <552F8B85.2000908@gmail.com>
 <xmqqwq1chz2s.fsf@gitster.dls.corp.google.com>
 <7139e45030c23bb642c5fe35e4074c6a@www.dscho.org>
 <20150416.115628.1228076242478955092.davem@davemloft.net>
 <6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Cc: David Miller <davem@davemloft.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 18:26:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YimcW-0006oi-W7
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 18:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbDPQ0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 12:26:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:46302 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751465AbbDPQ0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 12:26:23 -0400
Received: (qmail 8479 invoked by uid 102); 16 Apr 2015 16:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 11:26:23 -0500
Received: (qmail 26364 invoked by uid 107); 16 Apr 2015 16:26:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 12:26:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 12:26:21 -0400
Content-Disposition: inline
In-Reply-To: <6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267307>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

[retaining davem in cc in case he is curious, and hopefully does not
 see this as more spam :) ]

On Thu, Apr 16, 2015 at 06:11:47PM +0200, Johannes Schindelin wrote:

> On 2015-04-16 17:56, David Miller wrote:
> > Hey folks, please remove git-owner from the CC: list, that goes
> > to me and not the list :-)
> 
> I feared as much, but I cannot recall putting you on any Cc: myself.
> It appeared to me as if the list added git-owner@vger as sender, at
> least under *some* circumstances...

Weird. In a nearby thread with the same problem, the first email that
mentions git-owner in a cc header is yours[1]. It's in reply to a
message that does not mention git-owner at all[2], except in the
"Sender" field. Your agent header looks like:

  User-Agent: Roundcube Webmail/1.1.0

Maybe their "reply to all" function is a little over-zealous?

Messages from you from a few days ago do not show this problem, but
several starting on the 15th do. I don't see anything changing in the
messages from the list. Maybe your webmail provider changed something?
Or maybe it is a difference between replying to the version that came
through the list rather than one that came straight to you.

-Peff

[1,2] Rather than link to an archive, I'll attach full messages as I
      received them to make sure the headers are intact.

--3MwIy2ne0vdjdPXF
Content-Type: application/mbox
Content-Disposition: attachment; filename="one.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom git-owner@vger.kernel.org Thu Apr 16 07:31:43 2015=0AReturn-Path: <g=
it-owner@vger.kernel.org>=0ADelivered-To: peff@peff.net=0AReceived: (qmail =
24438 invoked by uid 107); 16 Apr 2015 11:31:43 -0000=0AReceived: from Unkn=
own (HELO cloud.peff.net) (10.0.1.3)=0A    by peff.net (qpsmtpd/0.84) with =
SMTP; Thu, 16 Apr 2015 07:31:43 -0400=0AReceived: (qmail 28500 invoked by u=
id 102); 16 Apr 2015 11:31:17 -0000=0AX-Spam-Level: *=0AX-Spam-Status: No, =
hits=3D-6.9 required=3D4.9=0A	tests=3DBAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_=
HI,T_RP_MATCHES_RCVD=0AX-Spam-Check-By: cloud.peff.net=0AReceived: from vge=
r.kernel.org (HELO vger.kernel.org) (209.132.180.67)=0A    by cloud.peff.ne=
t (qpsmtpd/0.84) with ESMTP; Thu, 16 Apr 2015 06:31:11 -0500=0AReceived: (m=
ajordomo@vger.kernel.org) by vger.kernel.org via listexpand=0A	id S1754326A=
bbDPLbH (ORCPT <rfc822;peff@peff.net>);=0A	Thu, 16 Apr 2015 07:31:07 -0400=
=0AReceived: from mout.gmx.net ([212.227.17.22]:51294 "EHLO mout.gmx.net"=
=0A	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP=0A	id S1752948Ab=
bDPLbG (ORCPT <rfc822;git@vger.kernel.org>);=0A	Thu, 16 Apr 2015 07:31:06 -=
0400=0AReceived: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx1=
03) with=0A ESMTPSA (Nemesis) id 0MTSmp-1YpgOn3Wvn-00SN13; Thu, 16 Apr 2015=
 13:31:02=0A +0200=0AMIME-Version: 1.0=0AContent-Type: text/plain; charset=
=3DUS-ASCII=0AContent-Transfer-Encoding: 7bit=0ADate:	Thu, 16 Apr 2015 13:3=
1:02 +0200=0AFrom:	Johannes Schindelin <johannes.schindelin@gmx.de>=0ATo:	T=
homas Braun <thomas.braun@virtuell-zuhause.de>=0ACc:	Andreas Mohr <andi@lis=
as.de>, git@vger.kernel.org,=0A	msysGit <msysgit@googlegroups.com>, git-own=
er@vger.kernel.org=0ASubject: Re: Issue: repack semi-frequently fails on Wi=
ndows (msysgit) -=0A suspecting file descriptor issues=0AOrganization: gmx=
=0AIn-Reply-To: <552F98AC.5030603@virtuell-zuhause.de>=0AReferences: <20150=
416100359.GA19951@rhlx01.hs-esslingen.de>=0A <552F98AC.5030603@virtuell-zuh=
ause.de>=0AMessage-ID: <27f1120c2c5231d8c7add8bdac7e3b21@www.dscho.org>=0AX=
-Sender: johannes.schindelin@gmx.de=0AUser-Agent: Roundcube Webmail/1.1.0=
=0AX-Provags-ID:  V03:K0:5LGXKi2a5ZxOTEAcxY2LiKqPuJypyImpc6vsmvcq4QJO4HktN/=
c=0A QhqtvNyBWdDtBcnuSqzDmLGJ7trEiBkNwdabnj/h5Sgtd5mQ4nxB8uepN/9cTXzst9pt9N=
X=0A eNtjbVtwmPd9GqnUlY/UryjMEQ8GqWbDoLegswUmiz0iSSEIqerbtB0mWbFisNA5el+y96=
U=0A gB7ilKXgDyhjtNCnUM/Jg=3D=3D=0AX-UI-Out-Filterresults:	notjunk:1;=0ASen=
der:	git-owner@vger.kernel.org=0APrecedence: bulk=0AList-ID: <git.vger.kern=
el.org>=0AX-Mailing-List:	git@vger.kernel.org=0AStatus: RO=0AContent-Length=
: 2358=0ALines: 49=0A=0AHi,=0A=0AOn 2015-04-16 13:10, Thomas Braun wrote:=
=0A> Am 16.04.2015 um 12:03 schrieb Andreas Mohr:=0A>>=0A>> over the years =
I've had the same phenomenon with various versions of msysgit=0A>> (now at =
1.9.5.msysgit.0, on Windows 7 64bit), so I'm now sufficiently=0A>> confiden=
t of it being a long-standing, longer-term issue and thus I'm=0A>> reportin=
g it now.=0A> =0A> (CC'ing msysgit)=0A=0AGood idea.=0A=0A>> Since I'm doing=
 development in a sufficiently rebase-heavy manner,=0A>> I seem to aggregat=
e a lot of objects.=0A>> Thus, when fetching content I'm sufficiently frequ=
ently greeted with=0A>> a git gc run.=0A>> This, however, does not work ful=
ly reliably:=0A>>=0A>>     Auto packing the repository for optimum performa=
nce. You may also=0A>>     run "git gc" manually. See "git help gc" for mor=
e information.=0A>>     Counting objects: 206527, done.=0A>>     Delta comp=
ression using up to 4 threads.=0A>>     Compressing objects: 100% (27430/27=
430), done.=0A>>     Writing objects: 100% (206527/206527), done.=0A>>     =
Total 206527 (delta 178632), reused 206527 (delta 178632)=0A>>     Unlink o=
f file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.pac=
k' failed. Should I try again? (y/n) n=0A>>     Unlink of file '.git/object=
s/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.idx' failed. Should I =
try again? (y/n) n=0A>>     Checking connectivity: 206527, done.=0A>>=0A>> =
A workable workaround for this recurring issue=0A>> (such a fetch will fail=
 repeatedly,=0A>> thereby hampering my ability to update properly)=0A>> is =
to manually do a "git gc --auto"=0A>> prior to the fetch (which will then s=
ucceed).=0A> =0A> I've never had this issue. The error message from unlinki=
ng the file=0A> means that someone is still accessing the file and thus it =
can not be=0A> deleted (due to the implicit file locking on windows).=0A=0A=
Best guess is that an antivirus is still accessing it. There is a tool call=
ed `WhoUses.exe` in msysGit (I do not remember if I included it into Git fo=
r Windows 1.x for end users) which could be used to figure out which proces=
s accesses a given file still: https://github.com/msysgit/msysgit/blob/mast=
er/mingw/bin/WhoUses.exe (maybe that would help you identify the cause of t=
he problem).=0A=0ACiao,=0AJohannes=0A--=0ATo unsubscribe from this list: se=
nd the line "unsubscribe git" in=0Athe body of a message to majordomo@vger.=
kernel.org=0AMore majordomo info at  http://vger.kernel.org/majordomo-info.=
html=0A=0A
--3MwIy2ne0vdjdPXF
Content-Type: application/mbox
Content-Disposition: attachment; filename="two.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom git-owner@vger.kernel.org Thu Apr 16 07:11:23 2015=0AReturn-Path: <g=
it-owner@vger.kernel.org>=0ADelivered-To: peff@peff.net=0AReceived: (qmail =
24359 invoked by uid 107); 16 Apr 2015 11:11:23 -0000=0AReceived: from Unkn=
own (HELO cloud.peff.net) (10.0.1.3)=0A    by peff.net (qpsmtpd/0.84) with =
SMTP; Thu, 16 Apr 2015 07:11:23 -0400=0AReceived: (qmail 27551 invoked by u=
id 102); 16 Apr 2015 11:10:58 -0000=0AX-Spam-Level: *=0AX-Spam-Status: No, =
hits=3D-6.9 required=3D4.9=0A	tests=3DBAYES_00,RCVD_IN_DNSWL_HI,T_RP_MATCHE=
S_RCVD=0AX-Spam-Check-By: cloud.peff.net=0AReceived: from vger.kernel.org (=
HELO vger.kernel.org) (209.132.180.67)=0A    by cloud.peff.net (qpsmtpd/0.8=
4) with ESMTP; Thu, 16 Apr 2015 06:10:51 -0500=0AReceived: (majordomo@vger.=
kernel.org) by vger.kernel.org via listexpand=0A	id S1754099AbbDPLKp (ORCPT=
 <rfc822;peff@peff.net>);=0A	Thu, 16 Apr 2015 07:10:45 -0400=0AReceived: fr=
om wp156.webpack.hosteurope.de ([80.237.132.163]:46383 "EHLO=0A	wp156.webpa=
ck.hosteurope.de" rhost-flags-OK-OK-OK-OK)=0A	by vger.kernel.org with ESMTP=
 id S1753439AbbDPLKn (ORCPT=0A	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2=
015 07:10:43 -0400=0AReceived: from p5ddc1deb.dip0.t-ipconnect.de ([93.220.=
29.235] helo=3D[192.168.100.43]); authenticated=0A	by wp156.webpack.hosteur=
ope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)=0A	id=
 1Yihgu-0001Bh-Tn; Thu, 16 Apr 2015 13:10:40 +0200=0AMessage-ID: <552F98AC.=
5030603@virtuell-zuhause.de>=0ADate:	Thu, 16 Apr 2015 13:10:36 +0200=0AFrom=
:	Thomas Braun <thomas.braun@virtuell-zuhause.de>=0AUser-Agent: Mozilla/5.0=
 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0=0AMIME-=
Version: 1.0=0ATo:	Andreas Mohr <andi@lisas.de>, git@vger.kernel.org=0ACC:	=
msysGit <msysgit@googlegroups.com>=0ASubject: Re: Issue: repack semi-freque=
ntly fails on Windows (msysgit) - suspecting=0A file descriptor issues=0ARe=
ferences: <20150416100359.GA19951@rhlx01.hs-esslingen.de>=0AIn-Reply-To: <2=
0150416100359.GA19951@rhlx01.hs-esslingen.de>=0AContent-Type: text/plain; c=
harset=3Dwindows-1252=0AContent-Transfer-Encoding: 7bit=0AX-bounce-key: web=
pack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1429182643;ce62c908;=0A=
Sender:	git-owner@vger.kernel.org=0APrecedence: bulk=0AList-ID: <git.vger.k=
ernel.org>=0AX-Mailing-List:	git@vger.kernel.org=0AStatus: RO=0AContent-Len=
gth: 1929=0ALines: 48=0A=0AAm 16.04.2015 um 12:03 schrieb Andreas Mohr:=0A>=
 Hi all,=0A> =0A> over the years I've had the same phenomenon with various =
versions of msysgit=0A> (now at 1.9.5.msysgit.0, on Windows 7 64bit), so I'=
m now sufficiently=0A> confident of it being a long-standing, longer-term i=
ssue and thus I'm=0A> reporting it now.=0A=0A(CC'ing msysgit)=0A=0AHi Andre=
as,=0A=0A> Since I'm doing development in a sufficiently rebase-heavy manne=
r,=0A> I seem to aggregate a lot of objects.=0A> Thus, when fetching conten=
t I'm sufficiently frequently greeted with=0A> a git gc run.=0A> This, howe=
ver, does not work fully reliably:=0A> =0A>     Auto packing the repository=
 for optimum performance. You may also=0A>     run "git gc" manually. See "=
git help gc" for more information.=0A>     Counting objects: 206527, done.=
=0A>     Delta compression using up to 4 threads.=0A>     Compressing objec=
ts: 100% (27430/27430), done.=0A>     Writing objects: 100% (206527/206527)=
, done.=0A>     Total 206527 (delta 178632), reused 206527 (delta 178632)=
=0A>     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3=
660cedc264c3c.pack' failed. Should I try again? (y/n) n=0A>     Unlink of f=
ile '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.idx' f=
ailed. Should I try again? (y/n) n=0A>     Checking connectivity: 206527, d=
one.=0A> =0A> A workable workaround for this recurring issue=0A> (such a fe=
tch will fail repeatedly,=0A> thereby hampering my ability to update proper=
ly)=0A> is to manually do a "git gc --auto"=0A> prior to the fetch (which w=
ill then succeed).=0A=0AI've never had this issue. The error message from u=
nlinking the file=0Ameans that someone is still accessing the file and thus=
 it can not be=0Adeleted (due to the implicit file locking on windows).=0A=
=0ACan you reproduce the error reliably?=0A=0AThomas=0A=0A=0A--=0ATo unsubs=
cribe from this list: send the line "unsubscribe git" in=0Athe body of a me=
ssage to majordomo@vger.kernel.org=0AMore majordomo info at  http://vger.ke=
rnel.org/majordomo-info.html=0A=0A
--3MwIy2ne0vdjdPXF--
