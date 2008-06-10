From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 11:53:49 +0200
Message-ID: <20080610095349.GA30119@diana.vm.bytemark.co.uk>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <alpine.DEB.1.10.0806092335420.17180@swallowtail> <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Clark Williams <clark.williams@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 11:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K60a9-0003mC-VC
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 11:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYFJJy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 05:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758432AbYFJJy1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 05:54:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1246 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451AbYFJJyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 05:54:25 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K60Y1-0007ri-00; Tue, 10 Jun 2008 10:53:49 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84488>

On 2008-06-10 10:07:25 +0200, Sverre Rabbelier wrote:

> How about adding in '.tar' decompression as well, -after- the '.gz'
> decompression? That way you can have .tar.gz's and still be fine.

A tar file would presumably contain more than one patch -- it'd be
more like a directory of patches than a single patch file.

I'm not saying it wouldn't be nice to support it, but it's not what
the original poster needed, and building it would be a bunch of extra
work.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
