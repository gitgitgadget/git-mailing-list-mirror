From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH] Document 'git bisect fix'.
Date: Wed, 16 Mar 2011 14:34:02 +0100
Organization: Bertin Technologies
Message-ID: <20110316143402.69e66f16@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <christian.couder@gmail.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:53:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzrAh-00086H-Sf
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 14:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab1CPNxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 09:53:40 -0400
Received: from blois.bertin.fr ([195.68.26.9]:64165 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab1CPNxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 09:53:36 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id B28205432F
	for <git@vger.kernel.org>; Wed, 16 Mar 2011 14:53:34 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 720CF54330
	for <git@vger.kernel.org>; Wed, 16 Mar 2011 14:53:34 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LI500ENTL99WZ10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 16 Mar 2011 14:53:34 +0100 (CET)
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.5.0.1024-18014.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169152>

>I'd say the replace method is perfect for transporting an existing fix
>"back in time" when the range of non-bisectable commits is limited. But
>since you have to replace the right (most recent) commit in that range
>it is less convenient when you have a fix due to a changed/exotic build
>environment or such which you do not want in your mainline.
>
>Also, you have to rebase the whole history back to the commit which
>introduced the problem

Right, and that makes it much more difficult when you want to be
selective about which fixes you want to apply.

-- 
Yann Dirson - Bertin Technologies
