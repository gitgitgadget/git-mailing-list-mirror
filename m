From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] filter-branch: introduce convenience function "skip_commit"
Date: Fri, 31 Aug 2007 21:19:21 +0200
Message-ID: <20070831191921.GB2151@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0708312005420.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRC1q-0003UC-H6
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbXHaTTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 31 Aug 2007 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbXHaTTf
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:19:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4281 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbXHaTTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 15:19:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IRC1Z-0000h8-00; Fri, 31 Aug 2007 20:19:21 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708312005420.28586@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57198>

On 2007-08-31 20:06:27 +0100, Johannes Schindelin wrote:

> It does _not_ undo the changeset corresponding to that commit, but
> it _skips_ the revision. IOW its ancestors' tree objects remain the
> same.

While this is true too, I'm guessing you intended to say that its
_descendants'_ tree objects remain the same. Right?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
