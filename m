From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 17:05:31 +0000
Message-ID: <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
References: <20120629124122.GG1258@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 19:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkedV-00050f-SG
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 19:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab2F2RFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 13:05:33 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:44885 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab2F2RFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 13:05:33 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 716D81B40A0
	for <git@vger.kernel.org>; Fri, 29 Jun 2012 17:05:32 +0000 (UTC)
Received: (qmail 6029 invoked by uid 10000); 29 Jun 2012 17:05:31 -0000
Content-Disposition: inline
In-Reply-To: <20120629124122.GG1258@camk.edu.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200817>

On Fri, Jun 29, 2012 at 02:41:22PM +0200,  Kacper Kornet wrote:
> I try to import some repositories into git and one of the developers has
> asked his name to be presented as: Name 'Nick' <email>.
> However git commit --author="Name 'Nick' <email>" strips the last
> apostrophe and produces a commit authored by: Name 'Nick <email>.
> 
> Maybe the function  strbuf_addstr_without_crud in ident.c should strip
> the trailing apostrophe only when it removed it also from the beginning
> of the string?
Which version of Git? And is it being stripped by git, or one of the
import tools?

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
