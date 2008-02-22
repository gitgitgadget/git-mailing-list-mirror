From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/4] git.el: Support for showing unknown/ignored directories.
Date: Fri, 22 Feb 2008 16:30:51 +0100
Message-ID: <20080222153051.GA20984@diana.vm.bytemark.co.uk>
References: <87zludorqs.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:31:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSZsG-00038W-T0
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 16:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYBVPbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYBVPbG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 10:31:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2510 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbYBVPbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 10:31:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSZrP-0005VC-00; Fri, 22 Feb 2008 15:30:51 +0000
Content-Disposition: inline
In-Reply-To: <87zludorqs.fsf@wine.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74729>

On 2008-02-07 13:50:19 +0100, Alexandre Julliard wrote:

> Instead of recursing into directories that only contain unknown
> files, display only the directory itself. Its contents can be
> expanded with git-find-file (bound to C-m).

I have a bunch of directories in my tree with only ignored files in
them. They used to not show up at all, but now they do. If I press
return with the cursor on top of one of them, it vanishes (which is
equivalent to expanding to all the 0 non-ignored files in that
directory, I guess).

I presume this wasn't the intended behavior? I like the idea for
subdirectories that actually contain non-ignored files, but
directories with only ignored files should really not be shown at all.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
