From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2 resend] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Tue, 11 Mar 2008 06:48:15 +0100
Message-ID: <200803110648.16117.chriscool@tuxfamily.org>
References: <20080307084628.0b311793.chriscool@tuxfamily.org> <200803110100.m2B102k9007026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 06:43:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYxGi-0007kH-Rk
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 06:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYCKFmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2008 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYCKFmk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 01:42:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55288 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbYCKFmj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2008 01:42:39 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5F0F01AB2B4;
	Tue, 11 Mar 2008 06:42:35 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E713A1AB2A9;
	Tue, 11 Mar 2008 06:42:34 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803110100.m2B102k9007026@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76798>

Le mardi 11 mars 2008, Xavier Maillard a =E9crit :
>    This patch makes it possible to view man pages using other tools
>    than the "man" program. It also implements support for emacs'
>    "woman" and konqueror with the man KIO slave to view man pages.
>
>    Note that "emacsclient" is used with option "-e" to launch "woman"
>    on emacs and this works only on versions >=3D 22.
>
>    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Acked-off-by: Xavier Maillard <xma@gnu.org>

Thanks. ("Tested-by:" may be better though.)=20

> There is something wrong though. git cmd --help should wait for
> the server to return in my opinion.

When I try something like the following on the command line:

$ emacsclient -e '(woman "fork")'

emacsclient doesn't wait for the server to return.

So I don't see how and why we should wait.

Thanks,
Christian.
