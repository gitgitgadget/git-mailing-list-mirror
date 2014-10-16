From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v4] completion: ignore =?utf-8?b?Y2hwd2RfZnVuY3Rpb25z?= when cding on zsh
Date: Thu, 16 Oct 2014 18:10:14 +0000 (UTC)
Message-ID: <loom.20141016T200635-928@post.gmane.org>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com> <1412881298-64117-1-git-send-email-bt@brandonturner.net> <xmqqk34955we.fsf@gitster.dls.corp.google.com> <CAMUzdX=SmeEFmxd_LPPaB9qkwqXfkiC=CU7DnMf_gR=007xcbQ@mail.gmail.com> <xmqqbnpk6ggl.fsf@gitster.dls.corp.google.com> <CAMUzdXkWNxW8Py6ATwtvqJ7s75dsP8vz6gMjk6tQa6gTGvcdWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 20:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XepVZ-0000V6-SF
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 20:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbaJPSKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Oct 2014 14:10:37 -0400
Received: from plane.gmane.org ([80.91.229.3]:47700 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaJPSKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 14:10:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XepVS-0000RF-IA
	for git@vger.kernel.org; Thu, 16 Oct 2014 20:10:34 +0200
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 20:10:34 +0200
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 20:10:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:32.0) Gecko/20100101 Firefox/32.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Turner <bt <at> brandonturner.net> writes:

>=20
> On Thu, Oct 9, 2014 at 5:11 PM, Junio C Hamano <gitster <at> pobox.co=
m> wrote:
> > Actually the patch was slightly wrong.  It did not quite matter as
> > "cd ''" is a no-op, but "git -C '' cmd" is not that lenient (which
> > may be something we may want to fix) and breaks t9902 by exposing
> > an existing breakage in the callchain.
> >
> > Here is a replacement.
>=20
> I did some more testing on this iteration as well - looks good.=20
>=20

Sorry, for the late reply, guys...

I've tested it too and it seems to work just fine.

As for my comments about using $=3D2 instead of $2: When zsh runs throu=
gh
this code it does so while emulating ksh. Thus the reliance on splittin=
g
unquoted expansions is not a problem. I was unaware of this until ten
minutes ago.=20

=C3=98sse
