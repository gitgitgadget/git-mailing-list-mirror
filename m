From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:10:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707171809190.29062@reaper.quantumfyre.co.uk>
References: <469CE836.6010508@arcom.com> <469CF2E6.1020104@lsrfire.ath.cx>
 <469CF52D.10407@arcom.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1065897683-1184692244=:29062"
Cc: git@vger.kernel.org
To: Amit Walambe <awalambe@arcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqZX-0007Yt-0M
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbXGQRKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbXGQRKs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:10:48 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43475 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754308AbXGQRKr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 13:10:47 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id AD572C6117
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 18:10:45 +0100 (BST)
Received: (qmail 6460 invoked by uid 103); 17 Jul 2007 18:10:44 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3630. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03231 secs); 17 Jul 2007 17:10:44 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 17 Jul 2007 18:10:44 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <469CF52D.10407@arcom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52778>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1065897683-1184692244=:29062
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Jul 2007, Amit Walambe wrote:

> But telling good/bad points to git bisect still fails, whether I pass the=
=20
> commit-id or the tags I created with commands given by Ren=E9 :
>
> root@amit:/usr/src/linux-git # git bisect good=20
> 8f41958bdd577731f7411c9605cfaa9db6766809
> cat: .git/BISECT_NAMES: No such file or directory
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git # git tag v2.6.22-git6=20
> 8f41958bdd577731f7411c9605cfaa9db6766809
> root@amit:/usr/src/linux-git # git tag v2.6.22-git8=20
> a5fcaa210626a79465321e344c91a6a7dc3881fa
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
> cat: .git/BISECT_NAMES: No such file or directory
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git #
> root@amit:/usr/src/linux-git # git bisect bad v2.6.22-git8
> cat: .git/BISECT_NAMES: No such file or directory
>
> Thanks and Regards,
>

you seem to be missing a "git bisect start" from that sequence ... see the=
=20
man page for more details.

--=20
Julian

  ---
Peter Griffin:  You wanna talk about awkward moments? Once, during sex, I c=
alled Lois "Frank". Your move, Sherlock.
---1463811584-1065897683-1184692244=:29062--
