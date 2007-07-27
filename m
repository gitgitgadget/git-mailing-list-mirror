From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: incremental fast-import
Date: Fri, 27 Jul 2007 09:44:19 +0200
Message-ID: <46A9A253.8000602@fs.ei.tum.de>
References: <Pine.LNX.4.64.0707262242460.14017@beast.quantumfyre.co.uk> <20070727005103.GC20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 09:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEKUr-0002Cq-8W
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 09:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763034AbXG0HoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Jul 2007 03:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762715AbXG0HoW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 03:44:22 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42523 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761316AbXG0HoV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 03:44:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 6C206280C5;
	Fri, 27 Jul 2007 09:44:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1PI09sSYFpq4; Fri, 27 Jul 2007 09:44:20 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-188.dclient.lsne.ch [85.218.11.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 0D326280A9;
	Fri, 27 Jul 2007 09:44:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <20070727005103.GC20052@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53906>

Shawn O. Pearce wrote:
> fast-import doesn't assume the local branches already exist.
> It actually assumes its importing from scratch every time.  The
> frontend tool needs to restart the branch if that is what it wants.

Is there a compelling reason for this behavior?  Shouldn't be so compli=
cated to get an overview on which branches already exist?

Right now I have to do this with a side channel to fast-import, asking =
the git repo directly, and then "recreating" the branch, etc.  Works, b=
ut could be nicer, I guess.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
