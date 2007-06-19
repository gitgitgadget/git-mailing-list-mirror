From: Bill Lear <rael@zopyra.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 08:51:07 -0500
Message-ID: <18039.57163.667319.439210@lisa.zopyra.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0e73-0003dA-FS
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXFSNvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXFSNvP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:51:15 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61997 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbXFSNvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:51:15 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JDpDf24564;
	Tue, 19 Jun 2007 08:51:13 -0500
In-Reply-To: <Pine.LNX.4.64.0706191359160.4059@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50481>

On Tuesday, June 19, 2007 at 14:00:07 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Tue, 19 Jun 2007, Bill Lear wrote:
>
>> Also breaks (tar fails) if I do the 'make configure; ./configure'
>> route.
>
>Then there is a test missing in configure.

Here is the particular error:

install git '/opt/git-1.5.2.2/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/home/blear/build/git-1.5.2.2/templates'
install -d -m755 '/opt/git-1.5.2.2/share/git-core/templates/'
(cd blt && gtar cf - .) | \
	(cd '/opt/git-1.5.2.2/share/git-core/templates/' && gtar xf -)
gtar: This does not look like a tar archive
gtar: Skipping to next header
gtar: Archive contains obsolescent base-64 headers
gtar: Error exit delayed from previous errors
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/blear/build/git-1.5.2.2/templates'
make: *** [install] Error 2


Bill
