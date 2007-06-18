From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [ANNOUNCE] GIT 1.5.2.2
Date: Mon, 18 Jun 2007 08:21:59 +0200
Organization: SelfOrganizing
Message-ID: <200706180821.59582.arekm@maven.pl>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com> <200706171230.37659.arekm@maven.pl> <20070618034322.GI18491@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 08:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Act-00046a-SI
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 08:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbXFRGWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 18 Jun 2007 02:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbXFRGWI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 02:22:08 -0400
Received: from main.carme.maven.pl ([193.239.45.138]:4174 "EHLO
	main.carme.maven.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbXFRGWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2007 02:22:07 -0400
Received: from [83.238.65.58] (helo=[192.168.1.157] ident=matrix157)
	by main.carme.maven.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <arekm@maven.pl>)
	id 1I0Acj-0002aa-1i; Mon, 18 Jun 2007 08:22:01 +0200
User-Agent: PLD Linux KMail/1.9.7
In-Reply-To: <20070618034322.GI18491@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50381>

On Monday 18 of June 2007, Shawn O. Pearce wrote:
> Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> > On Sunday 17 of June 2007, Junio C Hamano wrote:
> > > The latest maintenance release GIT 1.5.2.2 is available at the
> > > usual places:

[...]

> > Should git testsuite (make test) go without any problem? (I'm askin=
g
> > because some projects have test suites where some tests are expecte=
d to
> > fail).
>
[...]=20

>
> > * FAIL 16: corrupt a pack and see if verify catches
> >         cat test-1-${packname_1}.idx >test-3.idx &&
> >              cat test-2-${packname_2}.pack >test-3.pack &&
>
> Hmm.  That is t5300-pack-objects.sh.  Something is really fishy
> if that test failed.  We destroy a packfile and then look to see
> if the SHA-1 hash detects the change.  It always does.  So uh,
> what's up with your hardware that it doesn't fail?

There is no problems known with this hardware (kernel builds are freque=
ntly=20
done on it and no problem occured so far). Test suite fails in the same=
 place=20
each time I'm running it.

> I just built 1.5.2.2 on one of my Gentoo Linux amd64 systems and I'm
> not seeing any failures from the test suite.  Not that I expected
> to find any; Linux amd64 is popular enough that a number of people
> run it.

Not all have the same enviroment.=20

coreutils-6.9-2.x86_64
curl-7.16.2-1.x86_64
diffutils-2.8.7-4.x86_64
expat-2.0.0-3.x86_64
findutils-4.2.31-1.x86_64
gcc-4.2.0-6.x86_64
glibc-2.6-1.i686
glibc-2.6-1.x86_64
grep-2.5.1a-2.x86_64
openssl-0.9.8e-4.x86_64
perl-5.8.8-11.x86_64
python-2.5.1-2.x86_64
sed-4.1.5-2.x86_64
zlib-1.2.3-4.x86_64


If anyone is interested in debugging that problem then I can give ssh a=
ccess=20
to this machine.

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
