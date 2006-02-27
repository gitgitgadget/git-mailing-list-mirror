From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 4/4] Read author names and emails from a file
Date: Tue, 28 Feb 2006 00:00:13 +0100
Message-ID: <20060227230013.GA3466@diana.vm.bytemark.co.uk>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com> <20060226051131.24860.15804.stgit@backpacker.hemma.treskal.com> <440195D4.7080905@op5.se> <7vbqwt1h9r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 00:00:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDrLo-0007fh-Iv
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWB0XAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 18:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWB0XAP
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:00:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:53772 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750938AbWB0XAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:00:13 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FDrLh-0000zo-00; Mon, 27 Feb 2006 23:00:13 +0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqwt1h9r.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16888>

On 2006-02-26 21:51:12 -0800, Junio C Hamano wrote:

> Andreas Ericsson <ae@op5.se> writes:
>
> > This is a good thing, but wouldn't it be better to use the same
> > format as that of cvsimport's -A flag?
>
> If both CVS and SVN have their own native format to express things
> like this, and if the format they use are different, then that is a
> valid reason for git-{cvs,svn}import to use different file format.
>
> But if that is not the case, I tend to agree that it might be easier
> for users if we had just one format. I do not think, however, any
> single project is likely to have to deal with both CVS and SVN
> upstream, importing into the same git repository, so reusing the
> mapping file would not be an issue, but having to learn how to write
> the mapping just once is a good thing.
>
> I do not offhand recall if SVN has its own native format; if it has,
> it may be better to use that, instead of matching what git-cvsimport
> does, since I do not think of a reason why the version with an equal
> sign is preferrable over the version with a space. If the version
> with '=3D' were the CVS native format then that might be a reason to
> prefer it, but if I recall correctly that is not the case. so...

I don't know of any SVN native format for this, so it seems silly to
use a different format than git-cvsimport. I've also made a patch that
saves the author information, again just like git-cvsimport.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
