From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Do not crash if a patch log ref is missing
Date: Sun, 14 Sep 2008 10:08:39 +0200
Message-ID: <20080914080839.GA30664@diana.vm.bytemark.co.uk>
References: <20080912215449.10270.38860.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 09:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KemLL-0006qA-RM
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYINHqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYINHqh
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 03:46:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3735 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYINHqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 03:46:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kemet-00080U-00; Sun, 14 Sep 2008 09:08:39 +0100
Content-Disposition: inline
In-Reply-To: <20080912215449.10270.38860.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95821>

On 2008-09-12 22:54:58 +0100, Catalin Marinas wrote:

> Since we'll get rid of the individual patch logs, StGit should
> ignore if such a ref is missing when deleting the compatibility
> patch files.

I agree this is a good idea from a robustness perspective. Did you
encounter a case where the deletion actually failed?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
