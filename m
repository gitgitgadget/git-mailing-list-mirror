From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] web--browse: use custom commands defined at config time
Date: Tue, 18 Mar 2008 05:56:51 +0100
Message-ID: <200803180556.51930.chriscool@tuxfamily.org>
References: <20080314055649.0bd59b47.chriscool@tuxfamily.org> <200803151300.m2FD0XWh003243@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, normalperson@yhbt.net, git@vger.kernel.org,
	jaysoffian@gmail.com
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbTnt-0005Dy-8N
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 05:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbYCREvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2008 00:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYCREvU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 00:51:20 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37144 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbYCREvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Mar 2008 00:51:19 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 750B41AB2AD;
	Tue, 18 Mar 2008 05:51:17 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2DECD1AB2AC;
	Tue, 18 Mar 2008 05:51:17 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803151300.m2FD0XWh003243@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77488>

Le samedi 15 mars 2008, Xavier Maillard a =E9crit :
>    This patch adds a git config variable "browser.<tool>.cmd" which
>    allows a more flexible browser choice.
>
> Well done ! Now we need it in help.c too :)

I started by "man.<tool>.path" (patches should follow soon), and I will=
 work=20
on "man.<tool>.cmd" really soon now.

>    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Tested-by: Xavier Maillard <xma@gnu.org>

Thanks again for your tests. They are very much appreciated.

> Please update the header file as well (copyright header, it is
> year 2008 here :)).

Is it so important ? Some files like "help.c" don't even have copyright=
=20
notice. Isn't it ok as long as they come with the license file (COPYING=
) ?

Thanks,
Christian.
