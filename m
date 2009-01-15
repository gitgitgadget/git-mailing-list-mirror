From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] import --mail/--mbox question
Date: Thu, 15 Jan 2009 10:49:12 +0100
Message-ID: <20090115094912.GC24890@diana.vm.bytemark.co.uk>
References: <496E0656.2090705@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 10:50:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNOsE-0006mQ-5u
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 10:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760463AbZAOJtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 04:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760358AbZAOJtX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 04:49:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1261 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760206AbZAOJtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 04:49:20 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LNOqe-0006rN-00; Thu, 15 Jan 2009 09:49:12 +0000
Content-Disposition: inline
In-Reply-To: <496E0656.2090705@ruby.dti.ne.jp>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105776>

On 2009-01-15 00:35:50 +0900, Shinya Kuribayashi wrote:

> Question: when importing Mozilla Thunderbird mails (eml or mbox),
> the imported patch always have committer's date in git log, not
> submitter's date. However, if importing the same mails with git am,
> we could see submitter's date in git log.
>
> Is this intentionally-designed log management of StGit? I would
> expect the submitter's date & locale is kept when importing patches
> from e-mails.

Hmm. I agree with you that the expected behavior when importing
patches from e-mails is that the author date is set to the date in the
e-mail, the way git-am does it.

Looking at the code, it looks like the intention is that it should
work that way, too. So I guess it's simply a bug. Catalin, do you have
a clue?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
