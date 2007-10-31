From: Bill Lear <rael@zopyra.com>
Subject: Re: cpio command not found
Date: Wed, 31 Oct 2007 07:54:02 -0600
Message-ID: <18216.35066.259686.376571@lisa.zopyra.com>
References: <18216.31314.990545.518458@lisa.zopyra.com>
	<20071031133039.GA29065@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 14:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InE1Y-0002Ma-Ph
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 14:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbXJaNyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756973AbXJaNyK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 09:54:10 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61866 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756275AbXJaNyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 09:54:09 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l9VDs4209398;
	Wed, 31 Oct 2007 07:54:04 -0600
In-Reply-To: <20071031133039.GA29065@diana.vm.bytemark.co.uk>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62830>

On Wednesday, October 31, 2007 at 14:30:39 (+0100) Karl Hasselstr=F6m w=
rites:
>On 2007-10-31 06:51:30 -0600, Bill Lear wrote:
>
>> I don't remember this dependence from earlier versions of git. I
>> have been running git 1.4.xx on this machine for a while...
>
>When you clone with -l, git uses cpio to hardlink to the original
>repository. What has changed is that -l is now used by default when
>cloning a repository that's accessed via the file system (as opposed
>to over some network protocol).
>
>To work around this, specify the repository location with file://, and
>git won't try to hardlink (and hence won't try to use cpio).

Hmm, thanks for the workaround, but I don't altogether like leaving
things like this.

If the system does not have cpio, I think the build of git should
complain and fail, or it should activate code that treats any
repository accessed over the file system as it would file://.

No sense in leaving this surprise to the user so late in the cycle.


Bill
