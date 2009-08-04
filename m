From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: From P4 to Git
Date: Tue, 4 Aug 2009 14:35:08 +0200
Message-ID: <20090804123508.GA26373@m62s10.vlinux.de>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain> <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com> <85ljlzvjyp.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnaud Bailly <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 14:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJEg-00066J-ME
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbZHDMfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 08:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbZHDMfM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:35:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:34012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755423AbZHDMfL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 08:35:11 -0400
Received: (qmail invoked by alias); 04 Aug 2009 12:35:10 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp048) with SMTP; 04 Aug 2009 14:35:10 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+T+3YLdRWTi1f6nZ1aJKT0ihNVFzymzHZ9EYvIrS
	e4vhjpZ4XUMeZ/
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 1E45B8C0FB; Tue,  4 Aug 2009 14:35:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85ljlzvjyp.fsf@oqube.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124782>

On Tue, Aug 04, 2009 at 02:31:42PM +0200, Arnaud Bailly wrote:
> Thanks all for your detailed answers.
> 
> Playing with git on various environments, I have a couple more questions
> that I could not (quickly) find answers on the web.
>  1. when checkout-ing on NTFS, I got all my files marked as changed
>  because of file permissions set from 100644 to 100755. I see there is a
>  config flag about file permissions (core.sharedRepository ?) but not
>  sure how to use it

No, that config flag is for sharing a repository with other people. You want
something like core.filemode = false

-Peter
