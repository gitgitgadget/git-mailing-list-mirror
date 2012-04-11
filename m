From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long
	options
Date: Wed, 11 Apr 2012 16:06:51 +0200
Message-ID: <20120411140651.GR2289@goldbirke>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
	<1334140165-24958-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <spearce@spearce.org>,
	<felipe.contreras@gmail.com>, <jrnieder@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:07:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHyCP-00043O-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760278Ab2DKOG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 10:06:58 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:10085 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158Ab2DKOG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 10:06:58 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Apr
 2012 16:06:48 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Apr
 2012 16:06:50 +0200
Content-Disposition: inline
In-Reply-To: <1334140165-24958-2-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195181>

Hi,


On Wed, Apr 11, 2012 at 03:29:24AM -0700, Stephen Boyd wrote:
> The bash completion script wants to know what the long options are fo=
r a
> certain command at runtime. Add a magical long option that nobody cou=
ld
> possibly ever use (--dump-raw-long-options) to get this information.
>=20
> Some example output:
>=20
>  $ git clone --dump-raw-long-options
>  --no-verbose --no-quiet --progress --no-progress --no-checkout
>  --checkout --bare --no-bare --mirror --no-mirror --local --no-local
>  --no-hardlinks --hardlinks --shared --no-shared --recursive
>  --no-recursive --recurse-submodules --no-recurse-submodules --templa=
te=3D
>  --no-template --reference=3D --no-reference --origin=3D --no-origin
>  --branch=3D --no-branch --upload-pack=3D --no-upload-pack --depth=3D
>  --no-depth --single-branch --no-single-branch --separate-git-dir=3D
>  --no-separate-git-dir --config=3D --no-config
>=20

I think this is a good idea; there are many completion functions that
fell behind and lack an option or two.

However, in the completion script we deliberately miss options like
'--force', but with your series such options will be offered, too.


Best,
G=E1bor
