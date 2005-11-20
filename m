From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: non-trivial merge failures
Date: Mon, 21 Nov 2005 00:39:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511210037320.24681@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051120.134945.104623647.davem@davemloft.net>
 <200511202351.42320.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1853156163-1132529941=:24681"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 00:41:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edym3-0003XM-CM
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 00:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVKTXjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 18:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKTXjE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 18:39:04 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22411 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750934AbVKTXjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 18:39:02 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C42B613FFB0; Mon, 21 Nov 2005 00:39:01 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AB8BE9F39C; Mon, 21 Nov 2005 00:39:01 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 980959C8E8; Mon, 21 Nov 2005 00:39:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4850E13FFAE; Mon, 21 Nov 2005 00:39:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ismail Donmez <ismail@uludag.org.tr>
In-Reply-To: <200511202351.42320.ismail@uludag.org.tr>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12411>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1853156163-1132529941=:24681
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 20 Nov 2005, Ismail Donmez wrote:

> Sunday 20 November 2005 23:49 tarihinde =FF=FFunlar=FF=FF yazm=FF=FF=FF=
=FFt=FF=FFn=FF=FFz:
> > ImportError: No module named subprocess
>=20
> You need Python 2.4.x, subprocess is a new module in Python 2.4

No, you don't need 2.4, but at least 2.3. If you don't install git, but=20
run it from where you compile it, be sure to set GIT_PYTHON_PATH in your=20
config.mak. In any case, you need to set WITH_OWN_SUBPROCESS_PY for 2.3

Hth,
Dscho

---1148973799-1853156163-1132529941=:24681--
