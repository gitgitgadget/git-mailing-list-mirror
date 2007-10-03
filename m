From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 12:52:21 +0200
Message-ID: <20071003105221.GA11409@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <7vprzwhkgd.fsf@gitster.siamese.dyndns.org> <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com> <85abr0y5ua.fsf@lola.goethe.zz> <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com> <85k5q4v6jb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id1oy-0007HQ-Qh
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 12:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbXJCKux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 06:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbXJCKux
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 06:50:53 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:56234 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbXJCKuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 06:50:52 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 48451801E4C;
	Wed,  3 Oct 2007 12:50:51 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 9B99C580D2; Wed,  3 Oct 2007 12:52:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85k5q4v6jb.fsf@lola.goethe.zz>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59819>

Hi David.
> 
> But it is not all _all_ easily writeable the moment you try to do
> something with _structural_ impact.  In fact, it is pretty much
> impossible for anybody except wizards to do that.  And when the
> wizards do it, they can't actually document what they have been doing
> since that would mean cluttering the purported "plain text
> documentation" with formatting comments.
When I converted part of the kbuild documentation to ascii doc
is was a strightforward excercise.
The txt file was equally readable before and after,
and the generated HTML looks OK.

Up until 3.6 in following link were properly converted:
http://www.ravnborg.org/kbuild/makefiles.html

But I did not convince asciidoc to generate an index - is it this
you refer to as magic?

Using the kbuild doc as my background I would say that with
or without asciidoc there were a requirment for a consistent
style used throughout the file.
And that style was and are simple to use just by copying
relevant examples.

What asciidoc gave me was a simple syntax chack of what I did.
I found wrong references when playing with asciidoc as
one example.

If the asciidoc replacement prove a success for git I would
consider suggesting it for the kernel too.
It would be good to generate some nicer loking online documentation
and here an asii tool like thing would be a help.

	Sam
