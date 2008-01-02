From: Charles Bailey <charles@hashpling.org>
Subject: Re: Stitching together private svn repo and public git repo
Date: Wed, 2 Jan 2008 22:46:11 +0000
Message-ID: <20080102224611.GA14984@hashpling.org>
References: <C3A195B5.10839%jefferis@gmail.com> <20080102214005.GA10924@hashpling.org> <37fcd2780801021413g5f2a602dkb9fc289a13517375@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Jefferis <jefferis@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JACMG-0007mT-W0
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYABWqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbYABWqS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:46:18 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:50343 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYABWqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 17:46:17 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JACLm-0000aC-R6; Wed, 02 Jan 2008 22:46:15 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m02MkB59015339;
	Wed, 2 Jan 2008 22:46:11 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m02MkB1F015338;
	Wed, 2 Jan 2008 22:46:11 GMT
Content-Disposition: inline
In-Reply-To: <37fcd2780801021413g5f2a602dkb9fc289a13517375@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69500>

On Thu, Jan 03, 2008 at 01:13:54AM +0300, Dmitry Potapov wrote:
> I believe there is a much easier way to do that using .git/info/grafts
> The first step is to create .git/info/grafts, which specifies commit-id
> and its parents for each commit that you want to change. Then you
> can check the result using gitk, and if you are satisfied with what
> you see then you run git filter-branch on it to convert 'fake' parents
> into real ones.
> 
> Dmitry
> 

Oh yes, this is much easier.  Unless I'm missing something, the
documentation on grafts is fairly sparse, though.  They are mentioned
(almost in passing) in git help filter-branch but the file format is
only documented in repository-layout.txt which seems more developer
than user oriented.

Charles.
