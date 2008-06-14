From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Patch to add  git-help--browse to .gitignore
Date: Sat, 14 Jun 2008 04:30:59 +0200
Message-ID: <200806140430.59312.chriscool@tuxfamily.org>
References: <1213396239.12920.2.camel@Varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: alejandro.riveira@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 14 04:27:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7LUV-0004Nq-ET
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 04:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbYFNC0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 22:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756225AbYFNC0s
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 22:26:48 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51445 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558AbYFNC0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 22:26:48 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BC0BB1AB2B8;
	Sat, 14 Jun 2008 04:26:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9FE281AB2B7;
	Sat, 14 Jun 2008 04:26:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1213396239.12920.2.camel@Varda>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84960>

Le samedi 14 juin 2008, Alejandro Riveira Fern=E1ndez a =E9crit :
> When i run =ABgit status=BB on a cloned git repo with
> build files around i get
>
> $ git status
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       git-help--browse
> nothing added to commit but untracked files present (use "git add" to
> track)
>
> So i think something like this is needed

Well, git-help--browse is not used any more. It has been replaced by=20
git-web--browse. (In fact git-help--browse.sh was renamed=20
git-web--browse.sh see:=20
http://git.kernel.org/?p=3Dgit/git.git;a=3Dhistory;f=3Dgit-web--browse.=
sh)

So you can safely delete it.

Thanks,
Christian.
