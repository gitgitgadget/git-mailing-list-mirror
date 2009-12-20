From: Pascal Obry <pascal@obry.net>
Subject: Re: Delete a commit
Date: Sun, 20 Dec 2009 09:37:30 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B2DE24A.7040402@obry.net>
References: <20091219233957.GC29111@marge.bs.l> <hgjpqu$dos$1@ger.gmane.org> <20091220004340.GA30440@marge.bs.l>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 09:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMHIL-0005qu-I0
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 09:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbZLTIhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 03:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZLTIhh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 03:37:37 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:38561 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZLTIhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 03:37:37 -0500
Received: by ewy1 with SMTP id 1so5177211ewy.28
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 00:37:35 -0800 (PST)
Received: by 10.213.96.207 with SMTP id i15mr7158675ebn.69.1261298254443;
        Sun, 20 Dec 2009 00:37:34 -0800 (PST)
Received: from ?192.168.1.11? (ARouen-552-1-71-154.w92-152.abo.wanadoo.fr [92.152.150.154])
        by mx.google.com with ESMTPS id 28sm8469669eyg.28.2009.12.20.00.37.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Dec 2009 00:37:33 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091220004340.GA30440@marge.bs.l>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135525>

Le 20/12/2009 01:43, Bertram Scharpf a =E9crit :
>   % git fsck --lost-found
>   dangling commit 6abc221327e896c850c56dafae92277bcfe68e2b
>=20
> It is still there. This is the one I want to delete.

Well, it is deleted (not accessible from any ref). It will be purged
from the repository at some point after a "git gc".

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
