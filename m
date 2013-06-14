From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 15:50:32 +0200
Message-ID: <20130614135032.GA5394@goldbirke>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
 <20130614131629.GA1086@paksenarrion.iveqy.com>
 <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUOp-0000op-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab3FNNuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:50:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:57616 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab3FNNuj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:50:39 -0400
Received: from localhost6.localdomain6 (f051192048.adsl.alicedsl.de [78.51.192.48])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MdoTN-1UzLqn2ZvJ-00PeYh; Fri, 14 Jun 2013 15:50:32 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:YjWDClFioHv/RrY2fen8OEHN0e+iOXVjaFdGXdokOI3
 lW1uVd7CGyQrOBLRKc4a41dfeCOMTP/JwImj5M7NX3CxO6sFHG
 Bj+j8jJ7baL6TWmJO6HD3DLpyWtXDCS0TCMww7vdUajyjKMmoM
 6+LJaT0vns7IuMc8WhKKfe0YhyvQ8L9V67Oq8gOfB2o9e0s3Ii
 oDlwwJiHXaTu6EegW4yZix83DwC7472FWWpn04ANrcbpDicuib
 0PqfXEwvKDW1Kel5PNkUv3gsIgGj3IntDDwFqJzjoouGyFRkmX
 oqAHJTOwNM7CSMV0DWy/RC4M0qi7ws5jOjJBCQF8i7nA48N8Nk
 kKk+RDyLq9DY+TqbgYh4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227834>

On Fri, Jun 14, 2013 at 07:04:18PM +0530, Ramkumar Ramachandra wrote:
> My main itch is that completion doesn't work with my fp:
>=20
>   alias.fp =3D !rm -rf outgoing && git format-patch -M -C -o outgoing

Why not define your custom completion function for this alias in your
=2Ebashrc?

  _git_fp () { _git_format_patch ; }


Best,
G=E1bor
