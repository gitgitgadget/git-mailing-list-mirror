From: Xavier Maillard <zedek@gnu.org>
Subject: Re: Publishing on a simple HTTP server
Date: Wed, 14 Feb 2007 11:59:25 +0100
Message-ID: <4127.1171450765@localhost>
References: <14870.1171311025@localhost> <Pine.LNX.4.63.0702130009010.22628@wbgn013.biozentrum.uni-wuerzburg.de> <19695.1171344721@localhost> <Pine.LNX.4.63.0702131106230.1300@wbgn013.biozentrum.uni-wuerzburg.de> <23628.1171367140@localhost> <Pine.LNX.4.63.0702131256430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: Xavier Maillard <zedek@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 12:02:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHHtk-0001mj-4t
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 12:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbXBNLCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 06:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbXBNLCA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 06:02:00 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:50823 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbXBNLB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 06:01:59 -0500
Received: from localhost.localdomain (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2725527C82;
	Wed, 14 Feb 2007 12:01:58 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1EAxP0T004128;
	Wed, 14 Feb 2007 11:59:25 +0100
In-reply-to: <Pine.LNX.4.63.0702131256430.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
Comments: In-reply-to Johannes Schindelin <Johannes.Schindelin@gmx.de>
   message dated "Tue, 13 Feb 2007 12:57:40 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39632>

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > I thought this:
> > 
> > git --bare --git-dir=/tmp/my-cloned.git update-server-info
> > 
> > was supposed to achieve this. Doesn't it ?
> 
> If you mirror /tmp/my-cloned.git to the HTTP server, then yes, this should 
> do it. Make sure that /tmp/my-cloned.git/info/refs is really updated and 
> mirrored out, though.

I double checked and yes, info/refs is really updated and yes, it
is mirrored but it still fails when I try to clone my repository
with this:

 git clone http://zedek01.free.fr/projetcs/your-proj2.git

(you can try by yourself).

What can I do ?

Regards,

Xavier
