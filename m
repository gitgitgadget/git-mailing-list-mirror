From: sylvain@demarque.qc.ca
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 15:08:26 -0400
Message-ID: <20091012150826.p1v0gnnvokg0oggg@webmail.demarque.qc.ca>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
	<20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
	<f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com>
	<81b0412b0910121115s26c6c08s1ea54c28851faf05@mail.gmail.com>
	<20091012142017.vrs4v2cc8wgws8g4@webmail.demarque.qc.ca>
	<20091012183519.GA10686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Steven Noonan <steven@uplinklabs.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxQHT-0001BQ-RQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 21:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbZJLTJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbZJLTJK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 15:09:10 -0400
Received: from secure01.megaquebec.net ([199.202.64.88]:37289 "EHLO
	mqplesk1l.megaquebec.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918AbZJLTJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 15:09:09 -0400
Received: (qmail 8133 invoked by uid 48); 12 Oct 2009 15:08:26 -0400
Received: from modemcable009.10-130-66.mc.videotron.ca
	(modemcable009.10-130-66.mc.videotron.ca [66.130.10.9]) by
	webmail.demarque.qc.ca (Horde MIME library) with HTTP; Mon, 12 Oct 2009
	15:08:26 -0400
In-Reply-To: <20091012183519.GA10686@coredump.intra.peff.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130054>

Quoting Jeff King <peff@peff.net>:

> On Mon, Oct 12, 2009 at 02:20:17PM -0400, sylvain@demarque.qc.ca wrote:
>
> I think that it sort of works, actually. It seems to do OK if you do
> something like:
>
>   $ GIT_DIR=/path/to/store/repo; export GIT_DIR
>   $ GIT_WORK_TREE=/; export GIT_WORK_TREE
>   $ git init
>   $ cd /etc/whatever
>   $ git add .
>
> So probably the bug is in detecting the location of the work tree when
> it is not explicitly given. You can use the explicit style as a
> workaround for now.
>
> -Peff

Thank you! Great idea!

export GIT_DIR=/root/.git
export GIT_WORK_TREE=/
echo "*" >> /root/.git/info/exclude

The Golden Solution of the Gods! :-D
