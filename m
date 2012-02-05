From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: git-svn: t9155 fails against subversion 1.7.0
Date: Sun, 5 Feb 2012 21:25:21 +0000
Message-ID: <robbat2-20120205T212444-523294742Z@orbis-terrarum.net>
References: <op.v4neh4q20aolir@keputer>
 <op.v4pu1zcq0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:25:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9aQ-0007MJ-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab2BEVZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 16:25:22 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:53294 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab2BEVZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 16:25:22 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id C3ACB1B4010
	for <git@vger.kernel.org>; Sun,  5 Feb 2012 21:25:21 +0000 (UTC)
Received: (qmail 22914 invoked by uid 10000); 5 Feb 2012 21:25:21 -0000
Content-Disposition: inline
In-Reply-To: <op.v4pu1zcq0aolir@keputer>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189967>

On Thu, Nov 10, 2011 at 07:02:13AM +0100,  Frans Klaver wrote:
> I missed $gmane/184644 in my search for this issue.
Did you make any progress in fixing this?

> On Tue, 08 Nov 2011 23:09:30 +0100, Frans Klaver <fransklaver@gmail.com>  
> wrote:
> 
> > For kicks I decided to run the tests and noticed that on master  
> > t9155-git-svn-fetch-deleted-tag fails against svn 1.7.0. We hit an  
> > assertion in subversion's dirent_uri.c, stating that we don't provide a  
> > canonical url. I haven't tested against other subversion versions. I  
> > dare assume that this issue doesn't arise on earlier versions. It  
> > probably won't affect a lot of users right now, but it will in the  
> > future.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
