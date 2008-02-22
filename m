From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 08:31:57 +0100
Message-ID: <20080222073157.GA6630@diana.vm.bytemark.co.uk>
References: <87odaa4tcl.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>,
	Git Mailing List <git@vger.kernel.org>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 22 08:33:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSSP6-0004uk-Pw
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 08:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbYBVHcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 02:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYBVHcc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 02:32:32 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2950 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbYBVHcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 02:32:31 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSSNy-0001pW-00; Fri, 22 Feb 2008 07:31:58 +0000
Content-Disposition: inline
In-Reply-To: <87odaa4tcl.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74698>

On 2008-02-19 14:03:18 +0100, David K=E5gedal wrote:

> This works for me, but before including it someone else should try
> it. It might only work in Emacs 22, for instance.

It works for me (also using emacs 22).

I was a bit confused about the filename pattern selection, though: the
promt suggested "ch", which, when I accepted it, was converted to
"*.[ch]". However, manually specifying "*.c" works as well. I'm not
sure if this is specific to your patch or something affecting all grep
stuff in emacs (though I can't recall seeing it before).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
