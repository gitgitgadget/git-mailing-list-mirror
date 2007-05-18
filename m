From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC PATCH] Add new git-cp command, transposed from stgit.
Date: Fri, 18 May 2007 09:57:00 +0200
Message-ID: <20070518075700.GA14813@diana.vm.bytemark.co.uk>
References: <20070517204129.17502.21864.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri May 18 09:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoxLA-0004cy-2q
	for gcvg-git@gmane.org; Fri, 18 May 2007 09:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbXERH5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 03:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755174AbXERH5Z
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 03:57:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1077 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbXERH5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 03:57:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HoxKe-0003rN-00; Fri, 18 May 2007 08:57:00 +0100
Content-Disposition: inline
In-Reply-To: <20070517204129.17502.21864.stgit@gandelf.nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47575>

On 2007-05-17 22:49:00 +0200, Yann Dirson wrote:

> A known annoying limitation of this version (very quickly adapted)
> is that quoted files in the "git ls-files" output trigger the
> assert() clause. I'd use "-z", but it looks like noone wrote a
> zero-separated file reader for python (how that makes me regret perl
> ;).
>
> I can surely write one, but do we want this to be in python after
> all ? At least in perl it would be easy to fix this issue, but do we
> even accept perl scripts for such features ? OTOH, I'm not sure it
> is worth rewriting in C...

I was under the impression that perl was somewhat acceptable, while
python is not used in git anymore?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
