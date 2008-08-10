From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 22:16:51 +0200
Message-ID: <20080810201651.GB14237@cuci.nl>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm> <20080810145019.GC3955@efreet.light.src> <20080810175735.GA14237@cuci.nl> <20080810181115.GA3906@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 10 22:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSHOI-0006Nj-5x
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 22:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbYHJUQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 16:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbYHJUQx
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 16:16:53 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:51474 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbYHJUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 16:16:52 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 7FF8B5465; Sun, 10 Aug 2008 22:16:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080810181115.GA3906@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91882>

Jan Hudec wrote:
>On Sun, Aug 10, 2008 at 19:57:35 +0200, Stephen R. van den Berg wrote:
>> Jan Hudec wrote:
>If git was to store anything for empty
>directories, it would be empty tree, not a tree containing empty blob called
>'.'. There was even a prototype patch to do that sent to the list (I believe

Ok, sounds reasonable.

With respect to the storage inside the tree, using a duplicate name with
mode 0 or a name with some kind of rare extension...
It should probably be investigated how much of the existing core needs
to be touched/changed to support the duplicate name.
I agree that using a custom rare extension would allow for almost no
change to git-core.
-- 
Sincerely,
           Stephen R. van den Berg.

Real programmers don't produce results, they return exit codes.
