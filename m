From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-grep --relative: show pathnames relative to the current directory
Date: Fri, 11 Aug 2006 14:03:34 +0200
Message-ID: <20060811120334.GA6713@diana.vm.bytemark.co.uk>
References: <7vpsf7u2x7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 11 14:04:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBVk4-0007ue-Dz
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 14:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHKMDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 Aug 2006 08:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWHKMDj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 08:03:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:62226 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932173AbWHKMDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 08:03:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GBVji-0002AW-00
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 13:03:34 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vpsf7u2x7.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25226>

On 2006-08-11 00:50:12 -0700, Junio C Hamano wrote:

> By default, the command shows pathnames relative to the project
> root, even when run from a subdirectory. With --relative flag,
> however, the command outputs pathnames relative to the current
> directory.
>
> This makes it very pleasant to run in Emacs compilation (or
> "grep-find") buffer.

[...]

>  * Now the question is, shouldn't this be the default, with the
>    current output available as an option --full-name, just like
>    ls-files?
>
>    Changing the default always risks breaking people's habit and
>    scripts, but I tend to think the current output is a misfeature
>    which we'd better fix sooner rather than later.

I think this behavior should be the default, precisely because it
otherwise breaks the habits formed during use of plain "grep".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
