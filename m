From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Missing files
Date: Wed, 19 Jul 2006 20:06:54 -0700
Message-ID: <20060720030653.GA13741@localdomain>
References: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com> <b6327a230607191909tf48c4f8nc551b732523cca3e@mail.gmail.com> <20060720024815.GC31763@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 05:07:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3Osx-0001YQ-Rd
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 05:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWGTDG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 23:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGTDG6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 23:06:58 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33724 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964895AbWGTDG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 23:06:58 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 589697DC022;
	Wed, 19 Jul 2006 20:06:54 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 19 Jul 2006 20:06:54 -0700
To: Ben Williamson <benw@pobox.com>
Content-Disposition: inline
In-Reply-To: <20060720024815.GC31763@localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24016>

Eric Wong <normalperson@yhbt.net> wrote:
> Ben Williamson <benw@pobox.com> wrote:
> > Oh. I just looked in git-svn and found this:
> > 
> > $VERSION = '1.1.1-broken';
> 
> Nevertheless, I'm running an import right now (with the SVN:: libraries enabled)
> and will make another run with them disabled (which is kind of slow).
> I'll keep you posted...

Ok, I think I've found the problem.  This problem only happens if you're
using the SVN:: libraries, right?

-- 
Eric Wong
