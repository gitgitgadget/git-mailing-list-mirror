From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 10:48:58 +0100
Message-ID: <201102131048.58111.j6t@kdbg.org>
References: <4D565D3B.7060808@gmail.com> <20110213075337.GA12112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: xiaozhu <xiaozhu@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 10:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYZo-0003uA-2o
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 10:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab1BMJtC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 04:49:02 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:52221 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753555Ab1BMJtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 04:49:00 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 56D3B130054;
	Sun, 13 Feb 2011 10:48:58 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 37EE119F6D3;
	Sun, 13 Feb 2011 10:48:58 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20110213075337.GA12112@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166651>

On Sonntag, 13. Februar 2011, Jeff King wrote:
> On Sat, Feb 12, 2011 at 07:13:15PM +0900, xiaozhu wrote:
> > Subject: [PATCH]
> > =3D?UTF-8?q?=3DE6=3D97=3DA5=3DE6=3D9C=3DAC=3DE8=3DAA=3D9E=3DE3=3D81=
=3D8C=3DE5=3DA4=3DA7=3DE4=3DB8=3D88=3DE5=3DA4=3DAB
> > =3D20=3DE6=3D94=3DB9=3DE8=3DA1=3D8C=3DE3=3D81=3D99=3DE3=3D82=3D8B?=3D
>
> Yeah, this is wrong. There should be a whitespace indentation in a
> multi-line header, or the whole thing should be on one line. The newl=
ine
> in your commit subject is apparently leaking through, and it should b=
e
> qp-encoded.

Isn't it wrong that format-patch (and --pretty=3Demail) does any quotin=
g in the=20
first place? Isn't it the task of the MUA (git-send-email) to do the qu=
oting?

=46or example, when I import a format-patch generated patch into a mail=
 message,=20
I don't want to see:

 From: =3D?UTF-8?q?Joh=3DC3=3DA4nnes=3D20S=3DC3=3DBCxt?=3D <me@localhos=
t>

but rather:

 From: Joh=C3=A4nnes S=C3=BCxt <me@localhost>

I know this is a bit late, but this really comes as a surprise. (I've n=
ever=20
had to pay attention to this behavior in the past...)

-- Hannes
