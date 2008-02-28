From: Paul Donohue <stgit-bug@topquark.net>
Subject: Re: Minor bug in 'stg edit' ?
Date: Thu, 28 Feb 2008 16:54:15 -0500
Message-ID: <20080228215415.GO2222@TopQuark.net>
References: <20080227224756.GK2222@TopQuark.net> <b0943d9e0802281343l7c3190a1va564a87afce1ea06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqiL-0003f1-QW
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898AbYB1VyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756888AbYB1VyR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:54:17 -0500
Received: from god.thegod.com ([128.8.96.75]:37034 "EHLO Mail1.TopQuark.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135AbYB1VyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:54:17 -0500
Received: by Mail1.TopQuark.net (8.12.6/8.11.3, from userid 1000)
	id 38EA915AB2; Thu, 28 Feb 2008 16:54:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0802281343l7c3190a1va564a87afce1ea06@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75467>

The only problem it causes is that it shows up as an untracked file if you run 'git status'

I guess this doesn't really matter since you should be using 'stg status' instead, but 'git status' supports colors, so I generally use that instead of 'stg status', since I can interpret the colored output slightly faster than I can scan for ? flags when I want to know if I need to 'stg add' any files before I 'stg refresh'...

Thanks.
-Paul

On Thu, Feb 28, 2008 at 09:43:53PM +0000, Catalin Marinas wrote:
> On 27/02/2008, Paul Donohue <stgit-bug@topquark.net> wrote:
> > I'm running StGIT 0.14.1
> >
> >  After running 'stg edit', the file '.stgit-edit.txt' is always left behind.
> >
> >  Is this supposed to happen?  I would have assumed the file would be automatically removed after the changes were committed.
> 
> I wouldn't say it's a bug as I never thought it would cause any
> problems if left. Anyway, we could remove it if the operation was
> successful.
> 
> -- 
> Catalin
> 
