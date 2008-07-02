From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 01:46:44 +0200
Message-ID: <20080702234644.GC21297@leksak.fem-net>
References: <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org> <g4gho9$g42$1@ger.gmane.org> <20080702143519.GA8391@cuci.nl> <20080702183701.GE16235@cuci.nl> <20080702193157.GA21297@leksak.fem-net> <37fcd2780807021342j75f351a5sa525b892caedf965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 01:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEC37-00040u-Jl
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYGBXqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbYGBXqs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 19:46:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:52302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751386AbYGBXqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 19:46:48 -0400
Received: (qmail invoked by alias); 02 Jul 2008 23:46:46 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp024) with SMTP; 03 Jul 2008 01:46:46 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX196nhkt/cZ6siVZBAx4cTk8MbXsI7gBPkV2ljZqiW
	1/6U6jwk6jS8mV
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEC28-0002xt-5J; Thu, 03 Jul 2008 01:46:44 +0200
Content-Disposition: inline
In-Reply-To: <37fcd2780807021342j75f351a5sa525b892caedf965@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87205>

Hi,

On Thu, Jul 03, 2008 at 12:42:30AM +0400, Dmitry Potapov wrote:
> On Wed, Jul 2, 2008 at 11:31 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> > I wonder if grafts can be used in combination with sequencer in such a
> > way that you rewrite foo~20000..foo~19950 and then fake the parents of
> > foo~19949 to be the rewritten once.
> 
> I don't think it is a good idea. During the normal work you should never
> use grafts.

I have written this in the context that Stephen only changes some commits
from a long time ago (foo~20000) and then I showed a way how to avoid that
sequencer rewrites the rest which takes so long.
This is not related to "normal work", but to Stephen's use case (if I
got it right).

What I've meant, was:
Instead of faking a lot of parents, changes and even merges using an
extended grafts file, he could rewrite some patches - which can be fast -
and then use _only one_ graft to change the parent to the changed and
rewritten commit.
This can be done iteratively and seems to be a good agreement in speed
and reliability.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
