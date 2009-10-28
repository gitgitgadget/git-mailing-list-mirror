From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Getting Ensimag students to work on Git for a few weeks
Date: Wed, 28 Oct 2009 15:41:32 -0700 (PDT)
Message-ID: <m3r5sncfbv.fsf@localhost.localdomain>
References: <vpqocntxhzv.fsf@bauges.imag.fr>
	<20091027144405.GA12464@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3HD3-0005RK-ED
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbZJ1Wlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 18:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZJ1Wla
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:41:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:7571 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZJ1Wla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 18:41:30 -0400
Received: by fg-out-1718.google.com with SMTP id 16so713125fgg.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XTqG7KB1al0cF3i9fBiKkAEMuhEfqXlDLwOhy1nxUyI=;
        b=M4ujSencFXlreWQpQXW7xKRGG5B7HkMGT16wsBiwoKKr6ZNf2JwkrudAFX8UhRRyAY
         6e71lfKwweraalFG259pE/hfLarQzAt+kS5lhufkxcpkr/OOg+id8VkpbaNjdnQeYANU
         SeI3PKS70IkDsE7rtYeo4Km4tDLsZBS1UZelo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=sQHkGWZ8ipGHixRoYvaeMLckF9R2yfaP1qSXcie2JLxK7+o54cpa0672rRPscsgDsC
         4Z6Ms4kwtLwb1z4YC4/iGLAMyneAQboBD2Ilxc2NspGSup0jebZvDBdiWrdjpFxvbQdx
         dwLpMKDZsj1myjgC6LNgentXK+UJ5eRG4kAQo=
Received: by 10.86.214.34 with SMTP id m34mr1424758fgg.6.1256769693944;
        Wed, 28 Oct 2009 15:41:33 -0700 (PDT)
Received: from localhost.localdomain (abvm102.neoplus.adsl.tpnet.pl [83.8.210.102])
        by mx.google.com with ESMTPS id e3sm3344595fga.13.2009.10.28.15.41.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 15:41:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9SMeur7028599;
	Wed, 28 Oct 2009 23:41:04 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9SMeaf9028594;
	Wed, 28 Oct 2009 23:40:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20091027144405.GA12464@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131505>

Clemens Buchacher <drizzd@aon.at> writes:

> On Tue, Oct 27, 2009 at 11:12:52AM +0100, Matthieu Moy wrote:
> 
> > The students work full-time for about 3 weeks (May 20th to June 16th),
> > and are grouped by teams of 2 to 4 students. Given my bandwidth, I
> > plan to propose only one group of 4 students this year, but we may
> > scale up later, who knows.
> 
> That's not much time to get familiar with a complex project like git. So you
> will have to do something extremely simple, which probably means that it
> won't be anything exciting. If it were, someone else would have done it
> already.

Let's take a look at some projects from SoC2009Ideas and Wishlist:
* "smart" HTTP transport is being actively worked on
* narrow / sparse checkout is being worked on
* directory renames development stalled, I think last was in
  http://thread.gmane.org/gmane.comp.version-control.git/99529
* git-svnserver has supposedly partial Python implementation
* restartable clone, which should be fairly easy to add to "dumb"
  protocols, and quite challenging to add to "smart" protocols;
  even without a code, having fresh ideas would be nice
* (optional) support for empty directories, needs index extension,
  there were some patches, but the area might be muddy

It all depends on what you want to achieve in this short time.  Would
it be to get to know OSS development workflow (submitting patches,
answering reviews, etc.), or would it be solving interesting real-life
problem, or perhaps solving some problem from beginning to the end
(the code being accepted).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
