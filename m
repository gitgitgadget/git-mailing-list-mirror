From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: parsecvs tool now creates git repositories
Date: Tue, 04 Apr 2006 10:55:37 +1000
Message-ID: <pan.2006.04.04.00.55.35.724626@progsoc.org>
References: <1143956188.2303.39.camel@neko.keithp.com> <20060403140348.GE16823@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 04 02:56:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQZqN-0000zH-3z
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 02:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWDDA4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 20:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWDDA4T
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 20:56:19 -0400
Received: from main.gmane.org ([80.91.229.2]:5513 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964928AbWDDA4S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 20:56:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FQZq3-0000ti-41
	for git@vger.kernel.org; Tue, 04 Apr 2006 02:56:07 +0200
Received: from 203.7.227.147 ([203.7.227.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 02:56:07 +0200
Received: from wildfire by 203.7.227.147 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Apr 2006 02:56:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203.7.227.147
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18366>

On Mon, 03 Apr 2006 16:03:48 +0200, Erik Mouw wrote:

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

cvsclone, recently released, might be what you are after.

I've only used it on my own CVS repositories so I've no idea just how hard
it hits the remote side.

<http://freshmeat.net/projects/cvsclone/>

Anand
