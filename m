From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 16:21:10 +0200
Organization: At home
Message-ID: <e0rb0j$ml9$1@sea.gmane.org>
References: <1143956188.2303.39.camel@neko.keithp.com> <20060403140348.GE16823@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Apr 03 16:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQPwH-0004DS-SL
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDCOVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDCOVm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:21:42 -0400
Received: from main.gmane.org ([80.91.229.2]:38358 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751072AbWDCOVm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:21:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQPvj-000452-LO
	for git@vger.kernel.org; Mon, 03 Apr 2006 16:21:19 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 16:21:19 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 16:21:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18329>

Erik Mouw wrote:

> On Sat, Apr 01, 2006 at 09:36:28PM -0800, Keith Packard wrote:
>> The UI is a total disaster, sufficient for testing. You must create an
>> Authors file in the current directory which looks like the git-cvsimport
>> authors file. You must also have a edit-change-log program in your path
>> which edits the commit message in place. /bin/true will work if you
>> don't need to edit the messages.
>> 
>> I should clearly steal the existing git-cvsimport command line arguments
>> and use those.
> 
> What is the current way to use it? I get the impression it reads raw ,v
> files, but how do I get along with a remote CVS repository?

>From the comments on #git, parsecvs reads raw ,v files for creating history
tree, then uses 'cvs co ...' for getting the contents.

If you have access to remote CVS repository, it was suggested to use either
cvsclone or cvsup.

-- 
Jakub Narebski
Warsaw, Poland
