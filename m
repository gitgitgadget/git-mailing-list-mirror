From: Sebastian Bober <sbober@servercare.de>
Subject: Re: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 03:25:31 +0200
Message-ID: <20100417012531.GC32053@post.servercare.de>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com> <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com> <y2h2d460de71004161810p2c331099q4b2d7dabd01e5f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:25:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2wmw-0002Ke-Bc
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709Ab0DQBZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:25:33 -0400
Received: from tix64.net ([81.169.172.224]:56945 "EHLO
	h4945.serverkompetenz.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab0DQBZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:25:32 -0400
Received: from bob by h4945.serverkompetenz.net with local (Exim 4.69)
	(envelope-from <sbober@servercare.de>)
	id 1O2wmp-0007bb-Qz; Sat, 17 Apr 2010 03:25:31 +0200
Mail-Followup-To: Sebastian Bober <sbober@servercare.de>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <y2h2d460de71004161810p2c331099q4b2d7dabd01e5f8@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-bounce-key: tix64.net-1;sbober@servercare.de;1271467532;416473d2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145106>

On Sat, Apr 17, 2010 at 03:10:56AM +0200, Richard Hartmann wrote:
> On Sat, Apr 17, 2010 at 02:19, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> 
> > Assuming you do the import incrementally
> > using something like git-fast-import (feeding it with a custom
> > exporter that uses the dump as it's input) you shouldn't even need an
> > extraordinary machine to do it (although you'd need a lot of storage).
> 
> I am using a Python script [1] to import the XML dump.

There is also a version available at (plug):

  git://github.com/sbober/levitation-perl.git

That is a bit faster and consumes less memory (and is written in Perl).
But that, too, will not be able to handle enwiki at the moment.

> 
> 
> > Speaking of which, it might make sense to separate the
> > worktree by prefix, so articles starting with "aa" go under the "aa"
> > directory, etc?
> 
> Very good idea. What command would I need to send to
> git-fast-import to do that?

levitation does that already. 

> 
> > Hope that helps, and if you do convert it (and it turns out to be
> > usable, and you decide to keep it up to date somehow), put it up
> > somewhere! :)
> 
> It did.
> I will make it available if it turns out to be useful. Keeping it up to
> date might be harder unless they keep on releasing new
> (incremental) snapshots.

If desired, I could produce input files for git-fast-import for a larger
wiki (like german or japanese wikipedia), so that other people might
have a look at the performance.


bye,
  Sebastian
