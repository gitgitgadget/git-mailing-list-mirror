From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: rename detection limit checking, cherry picking, and git am -3
Date: Mon, 17 Sep 2007 11:58:29 +0200
Message-ID: <20070917095829.GD8657@diana.vm.bytemark.co.uk>
References: <46EDF54F.5030503@gmail.com> <20070917034742.GG3099@spearce.org> <7v3axd5325.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXDNb-0002ax-4d
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbXIQJ6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 05:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbXIQJ6y
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:58:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2053 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbXIQJ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:58:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IXDN7-0002jH-00; Mon, 17 Sep 2007 10:58:29 +0100
Content-Disposition: inline
In-Reply-To: <7v3axd5325.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58423>

On 2007-09-16 21:27:46 -0700, Junio C Hamano wrote:

> I think it would make sense to do the consolidated backend for
> rebase, revert, cherry-pick and am (I have been tentatively calling
> this "git replay") primarily based on the "patch with fallback to
> 3-way" like format-patch piped to "am -3", with an option to do
> merge-recursive.

I guess such a backend would be useful for StGit as well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
