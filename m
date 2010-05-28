From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH GSoC 1/4] gitweb: Move static files into seperate subdirectory
Date: Fri, 28 May 2010 18:56:27 +0200
Message-ID: <201005281856.27438.chriscool@tuxfamily.org>
References: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, jnareb@gmail.com
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 18:56:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI2rU-0001QL-LD
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 18:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab0E1Q4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 12:56:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:43152 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab0E1Q4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 12:56:38 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B8E728180E2;
	Fri, 28 May 2010 18:56:29 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147930>

On Friday 28 May 2010 08:25:49 Pavan Kumar Sunkara wrote:
> Create a new subdirectory called 'static' in gitweb/, and move
> all static files required by gitweb.cgi when running, which means
> styles, images and Javascript code. This should make gitweb more
> readable and easier to maintain.
> 
> Update t/gitweb-lib.sh to reflect this change.The install-gitweb
> now also include moving of static files into 'static' subdirectory
> in target directory: update Makefile, gitweb's INSTALL, README and
> Makefile accordingly.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Petr Baudis <pasky@ucw.cz>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

That's nice but you should probably have sent the patch series to Junio too 
according to this part of the SubmittingPatches document:

"- send the patch to the list (git@vger.kernel.org) and the maintainer 
(gitster@pobox.com) if (and only if) the patch is ready for inclusion."

Thanks,
Christian.
