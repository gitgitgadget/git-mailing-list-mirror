From: Sam Hocevar <sam@zoy.org>
Subject: Re: git-p4 workflow suggestions?
Date: Fri, 20 Mar 2009 11:31:25 +0100
Message-ID: <20090320103125.GP27280@zoy.org>
References: <20090309142108.GK12880@zoy.org> <20090311125805.GA28155@padd.com> <20090316180108.GE27280@zoy.org> <20090317151815.GA2451@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 11:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkc4Z-0002zk-Dh
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761786AbZCTKbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758814AbZCTKbe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:31:34 -0400
Received: from poulet.zoy.org ([80.65.228.129]:32927 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763018AbZCTKbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:31:33 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 28666120386; Fri, 20 Mar 2009 11:31:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090317151815.GA2451@padd.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113936>

On Tue, Mar 17, 2009, Pete Wyckoff wrote:

> Can you take a look at the attached.  Its goal is purely to allow
> you to clone a complex spec like yours above.  You may have to merge
> this in with your perrformance changes.
> 
> Edit your ~/.gitconfig to add a section:
> 
> 	[git-p4]
> 		useClientSpec = true
> 
> Then copy a good P4ENV from a p4 client that has a client spec
> checked out as you like.  git-p4 clone will do "p4 client -o",
> reading that spec, and use the results to import, hopefully as
> you have things laid out in the spec.
> 
> If this seems to work for you, we can figure out how to clean up
> the patch so it can be used generally by people with and without
> client specs.

   I am afraid I don't know what a "P4ENV" is. However, our P4
repository is set up in such a way that "p4 client -o" shows the
expected mappings, so I just commented out the P4ENV check and I finally
managed to clone my gigantic repository.

   One concern: git-p4 clone creates .git in the current directory and
it caused me to do at least one unfortunate "rm -rf .git". I would
expect clone to create a subdirectory.

   Apart from that, "clone" seems to work rather well. I haven't tried
to submit a commit yet, though.

-- 
Sam.
