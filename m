From: Marco <netuse@lavabit.com>
Subject: Compiling fails on SunOS
Date: Fri, 25 Feb 2011 10:09:54 +0100
Message-ID: <20110225100954.37c00fea@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 10:10:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pstgq-0006z3-Dc
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab1BYJKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:10:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:41604 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab1BYJKM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 04:10:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pstgh-0006ut-HX
	for git@vger.kernel.org; Fri, 25 Feb 2011 10:10:11 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 10:10:11 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 10:10:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167891>

Hi,

compiling on SunOS fails. configure runs without problems, make throws the
following error:

   SUBDIR perl
make: Warning: Ignoring DistributedMake -o option
Usage : make [ -f makefile ][ -K statefile ]... [ -d ][ -dd ][ -D ][ -DD ]
             [ -e ][ -i ][ -k ][ -n ][ -p ][ -P ][ -q ][ -r ][ -s ][ -S ][ -t ]
             [ -u ][ -w ][ -V ][ target... ][ macro=value... ][ "macro +=value"... ]
make: Fatal error: Unknown option `-C'
make: *** [perl/perl.mak] Error 1


System:	SunOS 5.10 i386
git:	git-1.7.4.1.tar.gz
Make:	GNU Make 3.82 (locally installed)

It seems that the building process invokes (the system wide installed) SunOS
make instead of the local GNU Make, since GNU Make does not display this error
message. Are there any known workarounds or solutions?


Marco
