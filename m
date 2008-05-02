From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-bisect.sh: don't accidentally override existing branch "bisect"
Date: Fri, 2 May 2008 10:22:32 +0200
Message-ID: <20080502082232.GA20020@diana.vm.bytemark.co.uk>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri May 02 10:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrqYc-0004LE-OS
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 10:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbYEBIXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 04:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYEBIXG
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 04:23:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4777 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbYEBIXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 04:23:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JrqXI-0005H3-00; Fri, 02 May 2008 09:22:32 +0100
Content-Disposition: inline
In-Reply-To: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80969>

On 2008-04-30 16:46:13 +0000, Gerrit Pape wrote:

> If a branch named "bisect" or "new-bisect" already was created in
> the repo by other means than git bisect, doing a git bisect used to
> override the branch without a warning. Now if the branch "bisect" or
> "new-bisect" already exists, and it was not created by git bisect
> itself, git bisect start fails with an appropriate error message.
> Additionally, if checking out a new bisect state fails due to a
> merge problem, git bisect cleans up the temporary branch
> "new-bisect".

Makes me wonder why bisect has to use a branch at all, and not just a
detached HEAD ... I seem to recall this having been discussed before,
but I can't find it now.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
