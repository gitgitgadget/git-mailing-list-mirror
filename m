From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] replace: use a GIT_NO_REPLACE_OBJECTS env variable
Date: Wed, 18 Nov 2009 07:49:47 +0100
Message-ID: <200911180749.47243.chriscool@tuxfamily.org>
References: <20091117051125.3588.91072.chriscool@tuxfamily.org> <4B026DE8.9070905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 07:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAeKL-00006g-Ji
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbZKRGra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZKRGra
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:47:30 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:52473 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbZKRGra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 01:47:30 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 59031818050;
	Wed, 18 Nov 2009 07:47:26 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7591B8180BC;
	Wed, 18 Nov 2009 07:47:24 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4B026DE8.9070905@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133146>

On mardi 17 novembre 2009, Michael J Gruber wrote:
> Christian Couder venit, vidit, dixit 17.11.2009 06:11:
> > This environment variable is set when the --no-replace-objects
> > flag is passed to git, and it is read when other environment
> > variables are read.
> >
> > It is useful for example for scripts, as the git commands used in
> > them can now be aware that they must not read replace refs.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
>
> :) This works, thanks, as well as the gitk patch 2/2, which is difficult
> to cover by test scripts. Some OSes (or rather certain setenv/putenv
> variants) have problems distinguishing an unset variable from an empty
> one. I think we've worked around this, but avoiding it is safer, as J6t
> pointed out.

Ok.

Thanks for testing,
Christian.
