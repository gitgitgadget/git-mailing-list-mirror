From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH 2/2] gitweb: Option to not display information about
 owner
Date: Thu, 26 Apr 2012 18:35:02 +0200
Message-ID: <20120426163502.GH16489@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <20120416213938.GB22574@camk.edu.pl>
 <201204180136.08570.jnareb@gmail.com>
 <201204191807.32410.jnareb@gmail.com>
 <20120424174114.GC15600@camk.edu.pl>
 <xmqqy5pj9kew.fsf@junio.mtv.corp.google.com>
 <20120426150721.GG16489@camk.edu.pl>
 <xmqqaa1ya3rh.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNRf9-0006Eg-GK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 18:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296Ab2DZQfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 12:35:17 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:39033 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756335Ab2DZQfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 12:35:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 5202E5F004C;
	Thu, 26 Apr 2012 18:36:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SZBT38dVvXrt; Thu, 26 Apr 2012 18:35:56 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2D40A5F0049;
	Thu, 26 Apr 2012 18:35:56 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 8BDB44671C; Thu, 26 Apr 2012 18:35:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqaa1ya3rh.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196381>

On Thu, Apr 26, 2012 at 08:53:22AM -0700, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> >> I am guessing both #5401 and #5551 are $it->{'category'} of @projects[]
> >> elements.

> > Yes, I have tested the tree with:

> > gitweb: Improve repository verification
> > gitweb: Option to omit column with time of the last change
> > gitweb: Option to not display information about owner

> > applied on top of v1.7.10. And all tests except 't91??' are passed.
> > Could you write on top of which revision have you applied these three
> > patches?

> Let's see...

> $ git log --oneline --first-parent --boundary master..kk/gitweb-omit-expensive
> 37e2621 gitweb: Option to not display information about owner
> 5710be4 gitweb: Option to omit column with time of the last change
> 75e0dff gitweb: Don't set owner if got empty value from projects.list
> - fdec2eb Merge branch 'maint-1.7.9' into maint

> I replayed these three on v1.7.10^0

> $ git checkout v1.7.10^0
> $ git format-patch --stdout fdec2eb..kk/gitweb-omit-expensive | git am -s3c

> and the result fails exactly the same way, though.

Appereantly I have managed to send the different patch then I have
applied in my private tree. I'm sorry for my mistake. In a short time I
will send the correct one.

-- 
  Kacper Kornet
