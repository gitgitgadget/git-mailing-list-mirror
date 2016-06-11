From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Sat, 11 Jun 2016 09:02:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606110849340.3039@virtualbox>
References: <20160511131745.2914-1-chriscool@tuxfamily.org> <5734B805.8020504@kdbg.org> <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com> <5759DB31.2000106@kdbg.org> <alpine.DEB.2.20.1606100852550.3039@virtualbox>
 <CAP8UFD1zSAxyHfZgBbfoF=th0waZWEhvHP+4jUxxVO+rU9N9RA@mail.gmail.com> <alpine.DEB.2.20.1606101307080.3039@virtualbox> <575AF304.8070407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 09:02:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBcwY-0004bq-8y
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 09:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbcFKHCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 03:02:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:52711 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbcFKHCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 03:02:49 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LsTjw-1bZjNC07uy-0120ou; Sat, 11 Jun 2016 09:02:26
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <575AF304.8070407@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Ge8ZgvWl2Asz+Mxz/mPI/NVwrbe1SnBHVMolhBqksMhXiOA4g5w
 yW4N17f19HR0LC7LhjI4mscW0a0TzSJHxxAcVywDh+2PcGRCKlSnhg2jT5oKhK6KhBeTlH1
 jMFNo5uhPHyfH8slEeQrhgk7eLxTTv1Eagl4omfukbC6hOBM4GL3twkWs+G7n6kvVXJUnga
 7dfF9mbR+K9p92WLv7Kcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JEZTm1ynVD8=:6CaskwKKDUElIbRqY31UWU
 Q+7sA6izpZ8DLlbUUY2f9MBNIHSBUVmhky3TKZdbhUtu3e9f+T3WtZJfBcvVw2qc3Mm3Dx3sK
 +5o0j+SHGy5wLbkUtd43VJ9pmz17T+EZShIExfOwhCwBV7xdg1MQCV4J8UTihZnkRCtht0sug
 /Is8+iWxBr1rnMnvD4cFh6Snq1RsxNxn19DeClxh1uajnID9phN3MRSJc6nV3MhgUeMsvsP/w
 M3xXNC3k4Oc+EwELb/uhGKca31/jjPuF9qThUIvu0YU7IvefZonIB2gmCBCC2byyDFHjYIV6d
 7g+eKe/mhRXFc+yf/p5IRYoNkhg6M8/HB0HP3yR2l99/aVVPB26aefLlljPa3XKmOSuvaHtKu
 AetfJRw29uuuwkQvGjIMcaEThRz+jprERll0zX1BwRTxnCZSzwajMR/hQpiM26j2NjuR/ugb0
 wcpbEGL1btLJbd3kgAdc5DhcOhwrzeS31Wppci12K2HX+tJiBFuqKTaWoGWmJZPQVXKecn2bQ
 NanHGZTExpakn3TwhG/bbkp4vhKd/Y4wgMATGKiCgUhoDUflpHYnD+3JRoGgEa7VBmVlZw6hl
 Y2y0v5MkB8CrdVM30I+84lDI6m832oNFhhk9UsbSQ5VysbLdrCyieeBp8MpH/ANIDg9V0BWGh
 AtGoZ1096rcJ4VCtq3EdeI6Y7+ldRWN+5tKHMzm51SAl6ZKUO0qOaPNvf6DtjYMG4lwwBNCzr
 iNTJ5ZvWMQckZnk6dsUE4Va0J9lQAgUytCxM2oAu4KUbejAP0T0EmNS1DLEUKGZLEEk2gVfE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297090>

Hi Hannes,

On Fri, 10 Jun 2016, Johannes Sixt wrote:

> Am 10.06.2016 um 13:11 schrieb Johannes Schindelin:
> > On Fri, 10 Jun 2016, Christian Couder wrote:
> >
> > > I fixed this by moving the "close(fd)" call just after the
> > > "apply_patch()" call.
> 
> This bug in v1 was discovered by the test suite and fixed in v2.

Maybe it would be a good idea to fix test failures before sending out an
80-strong patch series.

Just sayin'.

> > and this:
> >
> > > I will have another look at the 2 other places where there are
> > > open()/close() or fopen()/fclose() calls.
> >
> > but nothing about a careful, systematic investigation of all error code
> > paths. As a consequence, I fully expect to encounter test failures as soon
> > as I test your patch series again, simply because resources are still in
> > use when they should no longer be used. In other words, my expectations
> > are now lower than they have been before, my concerns are not at all
> > addressed.
> 
> Do you trust the test suite to some degree?

Yes. To *some* degree.

For comparison, my rebase--helper patches pass the test suite for more
than a month now. I still discovered two minor problems and fixed them
yesterday.

Our test suite (and *any* test suite, really) is in *no way* a substitute
for proper review. And the first review needs to be performed by the
developer herself.

Just compare the two options: to add tests for each and every corner case,
especially error code paths, or alternatively just going through the patch
manually, inspecting every error code path from the used-resource point of
view?

I am sure you agree that the latter is a much better use of everybody's
time, and also that that review will be most effective when performed by
the person most familiar with the patches.

> It passes after the above bug was fixed in v2. In addition, haven't
> found any problems so far during daily use.

I put much more stock into the latter than the former. The former is
required, to be sure, but by far not sufficient.

TBH I was quite disappointed when I tried to run v1 and found such a
simple bug right away, which made me wonder how many more not-so-simple
bugs were to be found. All that, while I really wanted this patch series
to be good enough to enter core Git's code base.

> > > This is the newest iteration:
> > >
> > > https://github.com/chriscool/git/commits/libify-apply-use-in-am65
> >
> > And that cute 65 in the name is the revision.
> 
> Yeah, that number is painful. I would appreciate an unversioned branch
> name, too.

To be frank, I think that a version number in a branch name is incorrect
Git usage. Version numbers are something for tags, not for branches (I
would understand partial version numbers in maintenance branches, of
course, because then they would not version the *branch* but convey the
purpose of the branch, as names should).

Ciao,
Johannes
