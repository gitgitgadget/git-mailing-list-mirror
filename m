From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 13/13] Remove the 'top' field
Date: Mon, 17 Sep 2007 09:30:29 +0200
Message-ID: <20070917073029.GA8657@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223215.7001.80066.stgit@morpheus.local> <20070915233632.GC25507@diana.vm.bytemark.co.uk> <CD668999-4CD3-416C-9205-CEB46FFA2398@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Sep 17 09:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXB4D-0005VU-6J
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 09:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXIQHao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbXIQHao
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 03:30:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3465 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbXIQHan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 03:30:43 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IXB3u-0002Fr-00; Mon, 17 Sep 2007 08:30:30 +0100
Content-Disposition: inline
In-Reply-To: <CD668999-4CD3-416C-9205-CEB46FFA2398@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58392>

On 2007-09-16 12:22:28 +0200, David K=E5gedal wrote:

> 16 sep 2007 kl. 01.36 skrev Karl Hasselstr=F6m:
>
> > And remove the top file, maybe? (Or I may be mistaken; I don't
> > have a copy of the surrounding code handy.)
>
> No, this is the code that updates from version 0 to version 1. The
> problem was that the update functionality used the update_top_ref()
> function in the Patch class which I changed. So I had to inline the
> code instead.

Ah. Right, you did say that you hadn't built an update function yet.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
