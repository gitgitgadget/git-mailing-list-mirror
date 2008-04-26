From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Improve git bisect error message
Date: Sat, 26 Apr 2008 20:53:00 +0200
Message-ID: <200804262053.00709.chriscool@tuxfamily.org>
References: <20080426133937.GA27677@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 20:48:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JppS5-00086A-Oe
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 20:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256AbYDZSr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2008 14:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759255AbYDZSr6
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 14:47:58 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:43157 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759189AbYDZSr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2008 14:47:57 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D016D1AB2F8;
	Sat, 26 Apr 2008 20:47:56 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id AF7221AB2E3;
	Sat, 26 Apr 2008 20:47:56 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080426133937.GA27677@basil.nowhere.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80385>

Le samedi 26 avril 2008, Andi Kleen a =E9crit :
> It took me some time to figure out what this error message meant and
> how to fix the problem.  So let's improve it a little.

It is very much appreciated that you report a problem and moreover prov=
ide a=20
patch.

> --- git-1.5.4/git-bisect~	2008-02-09 13:37:16.000000000 +0100
> +++ git-1.5.4/git-bisect	2008-04-26 01:26:19.000000000 +0200

Unfortunately in this case it seems that your git version is too old an=
d the=20
problem may have been fixed in newer versions.

See:

http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommit;h=3D0f497e75f05cdf0c0=
c1278eaba898cda6f118d71
http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommit;h=3Db577bb925e7458451=
55c6f51eae841c339ce68f6

So I think you should upgrade to git 1.5.5.1 and if possible tell us if=
 you=20
still get the same error message.=20

Thanks,
Christian.
