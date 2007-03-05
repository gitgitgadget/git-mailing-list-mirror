From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Use non-interactive function to byte-compile files
Date: Mon, 5 Mar 2007 10:51:01 +0100
Message-ID: <20070305095101.GA792@diana.vm.bytemark.co.uk>
References: <200703050823.l258NgT9008266@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 10:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO9qe-0006vl-Bj
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 10:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXCEJvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 04:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXCEJvN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 04:51:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4289 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbXCEJvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 04:51:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HO9qQ-0000KF-00; Mon, 05 Mar 2007 09:51:02 +0000
Content-Disposition: inline
In-Reply-To: <200703050823.l258NgT9008266@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41430>

On 2007-03-05 09:23:42 +0100, Xavier Maillard wrote:

> Hi,
>
> Ihope this one is more closed to what you expect to see in a
> commit log.
>
> * contrib/emacs/Makefile: add git-blame as a candidate to the
>    	    byte-compilation.  batch-byte-compile is the prefered way
>    	    to byte-compile files in batch mode. Use it instead of the
>    	    interactive function.
>
> Signed-off-by: Xavier Maillard <zedek@gnu.org>
> ---
>  contrib/emacs/Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile

Unless you intended the "hi, I hope this is better" part to be part of
the commit message, you should put it after the "---"; otherwise,
Junio will have to fix it up by hand.

Yes, Documentation/SubmittingPatches is a loooong text ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
