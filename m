X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 11:23:38 +0100
Message-ID: <20061206102338.GA28894@xp.machine.xx>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com> <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de> <slrnend551.arq.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.63.0612061111340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 10:23:55 +0000 (UTC)
Cc: Peter Baumann <Peter.B.Baumann@informatik.stud.uni-erlangen.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <Peter.B.Baumann@informatik.stud.uni-erlangen.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612061111340.28348@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33428>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrtwK-0002HL-G8 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760441AbWLFKXp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760452AbWLFKXp
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:23:45 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:38655
 "HELO mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with SMTP id S1760440AbWLFKXo (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:23:44 -0500
Received: (qmail 20789 invoked by uid 0); 6 Dec 2006 10:23:41 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost)
 (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135) by
 mail.hofmann.stw.uni-erlangen.de with SMTP; 6 Dec 2006 10:23:41 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 11:14:01AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 6 Dec 2006, Peter Baumann wrote:
> 
> > On 2006-12-06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > You can have the same effect as what Junio wrote with the config:
> > >
> > > $ git repo-config remote.origin.url git://git.kernel.org/pub/scm/git/git.git
> > > $ git repo-config remote.origin.fetch \
> > > 	refs/heads/master:refs/remotes/origin/master
> > > $ git repo-config remote.origin.fetch \
> > > 	refs/heads/next:refs/remotes/origin/next ^$
> > > $ git repo-config remote.origin.fetch \
> > > 	+refs/heads/pu:refs/remotes/origin/pu ^$
> > >
> > 
> > What's that ^$ for?
> 
> We misuse the "nice" ini format a little bit in git: we allow multiple 
> values for certain keys, like "remote.origin.fetch".
> 
> The normal mode for repo-config is to replace the value for the given key. 
> By appending a regular expression, you can limit the replacement to 
> certain matching _values_. And since "^$" means empty string, it does not 
> match any, ensuring an append instead of a replace.
> 
> Ciao,
> Dscho
> 

Another new thing learned today!
Thanks for the info.

