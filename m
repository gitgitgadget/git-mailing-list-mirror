From: Pascal Obry <pascal@obry.net>
Subject: Re: problem with git gui on cygwin.
Date: Thu, 13 Nov 2008 22:06:15 +0100
Organization: Home - http://www.obry.net
Message-ID: <491C96C7.6090904@obry.net>
References: <loom.20081111T155614-227@post.gmane.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jim Jensen <jhjjhjjhj@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0jPo-0008GO-5Q
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 22:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYKMVGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 16:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYKMVGc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 16:06:32 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:39191 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYKMVGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 16:06:32 -0500
Received: by gv-out-0910.google.com with SMTP id e6so245340gvc.37
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 13:06:24 -0800 (PST)
Received: by 10.103.11.7 with SMTP id o7mr57036mui.103.1226610383329;
        Thu, 13 Nov 2008 13:06:23 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-22-141.w82-124.abo.wanadoo.fr [82.124.78.141])
        by mx.google.com with ESMTPS id e10sm18847232muf.14.2008.11.13.13.06.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 13:06:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.17) Gecko/20080914 Thunderbird/2.0.0.17 Mnenhy/0.7.5.0
In-Reply-To: <loom.20081111T155614-227@post.gmane.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100916>

Jim Jensen a =E9crit :
> I have been trying to use git for a small project using cygwin.  I co=
pied my
> repository from one windows XP system to a Vista system using a usb d=
rive.  On
> the new system when I use "git gui" I get a pop up that says "Git dir=
ectory not
> found: .git"

I had some problems with Git UI and Tk. It does not look like the
problem you have but we never know. Can you try:

   $ CYGWIN=3D"" gitk

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
