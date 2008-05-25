From: Jan Krueger <jk@jk.gs>
Subject: Re: Which msysGit version corresponds to which official Git
 version?
Date: Sun, 25 May 2008 17:38:59 +0200
Message-ID: <20080525173859.6d55ccc3@neuron>
References: <48380E05.9020103@dirk.my1.cc>
	<3F512BCF-1D2E-46B0-84E5-4807753A2618@zib.de>
	<4839839C.2040605@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Dirk =?UTF-8?B?U8O8c3Nlcm90dA==?=" <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun May 25 17:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0IKE-0006VF-MN
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 17:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbYEYPjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYEYPjF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 11:39:05 -0400
Received: from zoidberg.org ([213.133.99.5]:59314 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbYEYPjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 May 2008 11:39:04 -0400
Received: from neuron (xdsl-87-78-135-158.netcologne.de [::ffff:87.78.135.158])
  (IDENT: unknown, AUTH: LOGIN jast, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sun, 25 May 2008 17:39:01 +0200
  id 0015B434.48398815.00002532
In-Reply-To: <4839839C.2040605@dirk.my1.cc>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82864>

Hi,

> I'd expected that "HEAD is now at 9d8318051...". Wrong?
> When I checkout "1d2375d" it says the very same:
>   > HEAD is now at 1d2375d... GIT 1.5.5

9d831 is the v1.5.5 tag object; 1d237 is the commit it points to. When
you pass a tag reference to checkout, it gets dereferenced to the
corresponding commit.

--=20
Best regards
Jan Kr=C3=BCger <jk@jk.gs>
