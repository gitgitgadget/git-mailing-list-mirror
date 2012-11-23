From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Fri, 23 Nov 2012 11:29:39 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121123162939.GA23962@thyrsus.com>
References: <20121122053012.GA17265@thyrsus.com>
 <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 23 17:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbw9P-0000LJ-1b
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 17:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab2KWQa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 11:30:29 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59172
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab2KWQa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 11:30:28 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C117A4065F; Fri, 23 Nov 2012 11:29:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210265>

Shawn Pearce <spearce@spearce.org>:
> Nope, it just has to be executable. We don't have any current Python
> code. IIRC the last Python code was the implementation of
> git-merge-recursive, which was ported to C many years ago.

This turns out not to be quite true.  The tree currently includes 
two Python scripts, a Perforce importer and a test helper.

I'm in he process of writing up a document on command integration
based on your answers. I will submit it for incusion in the tree
shortly.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
