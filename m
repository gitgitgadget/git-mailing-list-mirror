From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: cpio command not found
Date: Wed, 31 Oct 2007 14:30:39 +0100
Message-ID: <20071031133039.GA29065@diana.vm.bytemark.co.uk>
References: <18216.31314.990545.518458@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 14:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InDfB-0002fE-EB
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 14:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbXJaNbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 09:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXJaNbA
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 09:31:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4265 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbXJaNbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 09:31:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1InDea-0007jl-00; Wed, 31 Oct 2007 13:30:40 +0000
Content-Disposition: inline
In-Reply-To: <18216.31314.990545.518458@lisa.zopyra.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62827>

On 2007-10-31 06:51:30 -0600, Bill Lear wrote:

> I don't remember this dependence from earlier versions of git. I
> have been running git 1.4.xx on this machine for a while...

When you clone with -l, git uses cpio to hardlink to the original
repository. What has changed is that -l is now used by default when
cloning a repository that's accessed via the file system (as opposed
to over some network protocol).

To work around this, specify the repository location with file://, and
git won't try to hardlink (and hence won't try to use cpio).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
