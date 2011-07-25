From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Surprise at git stash pop
Date: Mon, 25 Jul 2011 12:55:52 -0500
Message-ID: <5fuhYLPOf07EnF5c5gyqAvbP3UZl6m72FicTS5tZnr3K8vTH5UoLkA@cipher.nrlssc.navy.mil>
References: <CAG3eYYRdvi-JdPfZmH_1EhEpjdweZFc6NS54btEz0nWy=O3+vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?UMOpdGVyIEFuZHLDoXMgRmVsdsOpZ2k=?= <petschy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 19:56:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlPNv-0005Zy-Qp
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 19:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab1GYR4C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jul 2011 13:56:02 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37439 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1GYR4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 13:56:01 -0400
Received: by mail.nrlssc.navy.mil id p6PHtkCE027529; Mon, 25 Jul 2011 12:55:46 -0500
In-Reply-To: <CAG3eYYRdvi-JdPfZmH_1EhEpjdweZFc6NS54btEz0nWy=O3+vA@mail.gmail.com>
X-OriginalArrivalTime: 25 Jul 2011 17:55:52.0919 (UTC) FILETIME=[186D3E70:01CC4AF4]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177804>

On 07/25/2011 10:45 AM, P=C3=A9ter Andr=C3=A1s Felv=C3=A9gi wrote:
> Hello,
>=20
> 'git stash pop' erased my local modifications, but not all of them.

Hi,

I cannot reproduce this.  What version of git are you using?

Can you produce a test case?  This could be a test repo that
you can share or a sequence of commands to produce such a
repo like:

   git init &&
   echo 'Some content' >build-configs.def &&
   mkdir -p 'server/plugins-src/ads' &&
   echo 'Some other content' >server/plugins-src/ads/AdsPlugin.hpp &&
   ...
   git add . &&
   git commit -m 'initial commit' &&
   echo 'Some new content for build-configs' >>build-configs.def &&
   ...
   git stash pop
   # Error situation

Thanks,
-Brandon
