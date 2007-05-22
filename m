From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 5/5] Add --binary flag to commands that generate diffs
Date: Tue, 22 May 2007 15:31:29 +0200
Message-ID: <20070522133129.GB12626@diana.vm.bytemark.co.uk>
References: <20070519000451.4906.87089.stgit@yoghurt> <20070519001012.4906.86287.stgit@yoghurt> <b0943d9e0705220515m7eb380cdw277847cf07382761@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 14:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTYu-0005Yp-Vr
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbXEVMd4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 08:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757137AbXEVMd4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:33:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4304 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbXEVMdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:33:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HqUSX-0003f4-00; Tue, 22 May 2007 14:31:29 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705220515m7eb380cdw277847cf07382761@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48100>

On 2007-05-22 13:15:13 +0100, Catalin Marinas wrote:

> On 19/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > This just passes the --binary option to git-diff-*, which causes
> > the generated diffs to contain an applyable diff even when binary
> > files differ. It's necessary to do this if you want to mail
> > patches to binary files.
>
> I applied this patch but is there anything wrong if we have this
> option on by default, at least for some commands? Maybe we don't
> need it for 'show' and 'diff' but we definitely need it for 'mail'
> and 'export'.

I'd be fine with that.

> There is also git.apply_diff() which calls git.diff(). This is first
> tried when pushing a patch and followed by a three-way merged if it
> fails. I think we should always have the --binary option in this
> case.

Yes, that sounds good.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
