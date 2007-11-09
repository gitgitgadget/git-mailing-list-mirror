From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 06:13:17 +0100
Message-ID: <200711090613.17566.chriscool@tuxfamily.org>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com> <458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com> <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Yossi Leybovich" <sleybo@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Nov 09 06:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqM4v-000389-LI
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 06:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbXKIFGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 00:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbXKIFGc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 00:06:32 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:33545 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbXKIFGc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 00:06:32 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DA6911AB2C5;
	Fri,  9 Nov 2007 06:06:29 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BEB311AB2A9;
	Fri,  9 Nov 2007 06:06:29 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64129>

Le vendredi 9 novembre 2007, Yossi Leybovich a =E9crit :
>
> Unfortunately I can't get this object from backup directories as advi=
se
> in the FAQ.
> Can this object manually fixed by any tool? (the object is attached) =
I
> don't even know to which file/tree/commit it belong how can I know th=
at
> ?

Could you try something like:

git-cat-file -p 4b9458b3786228369c63936db65827de3cc06200

in your repository ?

Thanks,
Christian.
