From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCHv3 GSoC] git-instaweb: Configure it to work with new gitweb structure
Date: Mon, 24 May 2010 11:55:30 +0200
Message-ID: <201005241155.30653.chriscool@tuxfamily.org>
References: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, normalperson@yhbt.net,
	pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 11:56:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUOV-000241-E1
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 11:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab0EXJ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 05:56:18 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51225 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629Ab0EXJ4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 05:56:18 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 545F2818043;
	Mon, 24 May 2010 11:56:09 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP;
	Mon, 24 May 2010 11:56:08 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147621>

Hi Pavan,

On Sunday 23 May 2010 09:32:48 Pavan Kumar Sunkara wrote:
> 
> This patch is based on 'jn/gitweb-install' in the next branch by Jakub
>  Nareski and my previous 2 patches:
> * gitweb: Move static files into seperate subdirectory
>  http://article.gmane.org/gmane.comp.version-control.git/147321
> * gitweb: Set default destination directory for installing gitweb in
>  Makefile http://article.gmane.org/gmane.comp.version-control.git/147160

I tried to apply your 2 patches on top of next I got some errors with the 
"Move static files into seperate subdirectory" patch.

Could you resend the 3 patches in a patch series after making sure that they 
apply on top of next?

And I think that it would be better if the web server logs would be in a 
directory with the web server name. For example 
"$fqgitdir/gitweb/$httpd/access.log" instead of "$fqgitdir/gitweb/access.log". 
But it would be nice if you make these changes (as well as the apache2 
confguration changes) in another patch.

Thanks in advance,
Christian.
