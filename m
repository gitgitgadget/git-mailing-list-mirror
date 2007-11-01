From: Alexander Skwar <listen@alexander.skwar.name>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 1 Nov 2007 13:06:54 +0000 (UTC)
Message-ID: <loom.20071101T130539-416@post.gmane.org>
References: 18216.31314.990545.518458@lisa.zopyra.com <1193861145-20357-1-git-send-email-mh@glandium.org> <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 14:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZoU-0006xa-Uo
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbXKANKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXKANKH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:10:07 -0400
Received: from main.gmane.org ([80.91.229.2]:59718 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbXKANKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:10:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1InZoA-00053J-RU
	for git@vger.kernel.org; Thu, 01 Nov 2007 13:10:02 +0000
Received: from zy-rieter.cyberlink.ch ([212.55.215.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 13:10:02 +0000
Received: from listen by zy-rieter.cyberlink.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 13:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.55.215.153 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.8.1.8) Gecko/20071023 Firefox/2.0.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62953>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> 
> 
> On Wed, 31 Oct 2007, Mike Hommey wrote:
> > +	if type cpio > /dev/null 2>&1; then
> > +		local=yes
> > +	fi
> 
> Isn't "type" a bashism?

ksh also has type. But SUS states, that "command -v" can be used.

   Options

[...]

   -v
       (On systems supporting the User Portability Utilities option.)
       Write a string to standard output that indicates the pathname or
       command that will be used by the shell, in the current shell
       execution environment (see Shell Execution Environment ), to
       invoke command_name, but do not invoke command_name.

           * Utilities, regular built-in utilities, command_names
             including a slash character, and any implementation-defined
             functions that are found using the PATH variable (as
             described in Command Search and Execution ), shall be
             written as absolute pathnames.

           * Shell functions, special built-in utilities, regular
             built-in utilities not associated with a PATH search, and
             shell reserved words shall be written as just their names.

           * An alias shall be written as a command line that represents
             its alias definition.

           * Otherwise, no output shall be written and the exit status
             shall reflect that the name was not found.

Regards,
Alexander
