From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Repository corruption
Date: Sun, 16 Mar 2008 06:49:05 +0100
Message-ID: <200803160649.05911.chriscool@tuxfamily.org>
References: <20070903165255.6CEC78B8B2@rover.dkm.cz> <20080315121903.GY10335@machine.or.cz> <20080315130441.GF4079@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@ucw.cz>, GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 06:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JalfG-0000Nu-7a
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 06:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYCPFnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2008 01:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYCPFna
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 01:43:30 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52965 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYCPFna convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 01:43:30 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A44501AB2B0;
	Sun, 16 Mar 2008 06:43:28 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7D0C51AB2AD;
	Sun, 16 Mar 2008 06:43:28 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080315130441.GF4079@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77353>

Hi Yann,

Le samedi 15 mars 2008, Yann Dirson a =E9crit :
> The corruptions were of several kinds:
> - commits for unapplied stgit patches were all lost, although they
> were reachable from refs/patches/master/*
> - seemingly-random objects in the history (commits, trees, probably
> blobs as well) were missing
>
> Does anyone have ideas about post-mortem analysis on that repo ?

Did you have a look at:

http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3DDocumentation/howto=
/recover-corrupted-blob-object.txt;h=3D323b513ed0e0ce8b749672f589a37507=
3a050b97;hb=3DHEAD

and

http://git.or.cz/gitwiki/GitFaq#head-ac11406480d09e2df98588e800e41b7256=
602074

Best regards,
Christian.
