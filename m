From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: gitignore patterns
Date: Tue, 9 Sep 2008 16:28:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0809091627550.15561@shark.he.net>
References: <Pine.LNX.4.64.0809091521120.15561@shark.he.net>
 <7vprnc3nr7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCef-00044h-4x
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbYIIX2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYIIX2q
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:28:46 -0400
Received: from xenotime.net ([66.160.160.81]:58441 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753663AbYIIX2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:28:46 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <git@vger.kernel.org>; Tue, 9 Sep 2008 16:28:40 -0700
X-X-Sender: rddunlap@shark.he.net
In-Reply-To: <7vprnc3nr7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95460>

On Tue, 9 Sep 2008, Junio C Hamano wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > In the kernel tree, I see 2 .gitignore files that use "+pattern":
> >
> > ./arch/blackfin/include/asm/.gitignore:+mach
> > ./arch/blackfin/boot/.gitignore:+vmImage
> >
> > However, I can't find anything about '+' on the gitignore(5) man page
> > at http://www.kernel.org/pub/software/scm/git/docs/gitignore.html .
> >
> > Does the '+' mean something special or is it just a character in the
> > filename/dir pattern?
> 
> AFAIR, this should be just a shell glob fnmatch(3) understands, so perhaps
> their build procedure leaves temporary droppings in a file whose filename
> is prefixed with './+'?

OK, I'll ask the blackfin developers/maintainers about it.

Thanks.
-- 
~Randy
