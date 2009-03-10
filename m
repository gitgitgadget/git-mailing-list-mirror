From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-p4 workflow suggestions?
Date: Tue, 10 Mar 2009 08:15:53 +0100
Message-ID: <200903100815.53847.chriscool@tuxfamily.org>
References: <20090309142108.GK12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgwEE-0005bx-6j
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 08:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZCJHQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZCJHQu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 03:16:50 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:57858 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbZCJHQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 03:16:49 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A8ACB94014D;
	Tue, 10 Mar 2009 08:16:41 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id BC00094014E;
	Tue, 10 Mar 2009 08:16:38 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090309142108.GK12880@zoy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112787>

Hi Sam,

Le lundi 9 mars 2009, Sam Hocevar a =E9crit :
>    Dear list,
>
>    I have modified git and git-p4 to a point where they are usable in
> my work environment. I am now faced with a new problem: Perforce's
> composite workspaces. They allow you to "mount" parts of the repo ont=
o
> other directories, even nonempty ones.

It looks like SVN externals. So I think you should read about "git=20
submodule".

There is this related link on the wiki:

http://blog.alieniloquent.com/2008/03/08/git-svn-with-svnexternals/

You may also want to search the mailing list as this subject has often =
been=20
discussed.

Best regards,
Christian.
