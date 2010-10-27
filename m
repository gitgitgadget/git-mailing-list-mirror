From: Yann Dirson <ydirson@free.fr>
Subject: Re: Bulk move and some of its close relatives
Date: Wed, 27 Oct 2010 09:05:01 +0200
Organization: Bertin Technologies
Message-ID: <20101027090501.71980573@chalon.bertin.fr>
References: <20101026181314.GA5695@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 09:22:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB0LV-0003Ji-7P
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0J0HWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 03:22:48 -0400
Received: from blois.bertin.fr ([195.68.26.9]:59601 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205Ab0J0HWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 03:22:47 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 03:22:47 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 7C77D5450C
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:14:53 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 5ACED54506
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:14:53 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LAX00L10TGS0N10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 27 Oct 2010 09:14:53 +0200 (CEST)
In-reply-to: <20101026181314.GA5695@home.lan>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160023>

Oh, and another I forgot to mention is detection of bulk copies.  It is
somewhat tricky: while --find-copies-harder will properly work in
combination with --detect-bulk-copies, for the standard case we will
need to use find-copies-harder for those cases where not all of the
copied files have been modified.

For this, maybe it could help to store the unmodified src files in a
separate list to avoid pref degradation for the common case (similar to
my plans to avoid the need of the i_am_not_single flag in the current
bulkmove series by using a separte list for dst files).

-- 
Yann
