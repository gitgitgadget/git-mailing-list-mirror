From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 16:11:15 +0100
Message-ID: <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com> <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com> <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-656967463-1372950675=:26246"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 17:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UulBp-0004IJ-Rt
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 17:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622Ab3GDPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 11:11:17 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:47679 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab3GDPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 11:11:16 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:43302)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1UulBj-00044Z-DH (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 16:11:15 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1UulBj-0007ZJ-10 (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 16:11:15 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229592>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-656967463-1372950675=:26246
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>
> It would be better to improve documentation, than follow current bad
> practice... ;-P

The v2 patch does just that :-)

> Perhaps even make ( [ $home_link_str, $home_link ] ) to be default
> value for @extra_breadcrumbs, making new feature generalization
> of $home_link*, similarly to how it was done for $stylesheet -> @styleshe=
ets
> transition.

I don't think that's a win. There's a lot of existing gitweb.conf out
there which sets $home_link_str, so the code would have to either print
the last element of @extra_breadcrumbs or the $home_link variables
depending on whether the variables were modified. And the documentation
would have to explain this complicated arrangement.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first=
=2E
Rough, becoming slight or moderate. Showers, rain at first. Moderate or goo=
d,
occasionally poor at first.
--1870870024-656967463-1372950675=:26246--
