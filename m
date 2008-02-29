From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: When to repack?
Date: Fri, 29 Feb 2008 12:47:35 +0100
Message-ID: <20080229114735.GA17416@diana.vm.bytemark.co.uk>
References: <47C7E4AD.6030509@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 12:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV3jM-00033E-Cx
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 12:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYB2LsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 06:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYB2LsL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 06:48:11 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4717 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYB2LsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 06:48:10 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JV3iB-0004Y8-00; Fri, 29 Feb 2008 11:47:35 +0000
Content-Disposition: inline
In-Reply-To: <47C7E4AD.6030509@glidos.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75525>

On 2008-02-29 10:55:41 +0000, Paul Gardiner wrote:

> There's advantage to repacking a repository after using
> git-fast-import. If that repacked repository is then git-pushed to
> another, is there any point in repacking the other afterwards? I'm
> guessing not, but just checking.

No, there isn't. The pack is essentially sent unmodified over the
wire. (IIRC, packs were originally conceived as a way of reducing
transfer bandwidth, and were later adopted for on-disk storage as
well. But I might be mistaken.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
