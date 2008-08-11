From: Eric Raible <raible@gmail.com>
Subject: Re: Help reverting a particular file
Date: Mon, 11 Aug 2008 23:33:17 +0000 (UTC)
Message-ID: <loom.20080811T232642-623@post.gmane.org>
References: <3f81a4240808111600u78c5eeefu588a6b1250a0dd02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSguJ-0006J2-EO
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbYHKXdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbYHKXdd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:33:33 -0400
Received: from main.gmane.org ([80.91.229.2]:50835 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbYHKXdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:33:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KSgtE-0003N7-Jn
	for git@vger.kernel.org; Mon, 11 Aug 2008 23:33:28 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 23:33:28 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 23:33:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92024>

Bryan Richardson <btricha <at> gmail.com> writes:

> 
> Hello all,
> 
> Can anyone tell me how to revert a particular file using git?  I
> executed a commit, then froze my Rails application to the latest Rails
> version.  This caused my custom config/boot.rb file to be overwritten
> and I would like to restore it without rolling back to the previous
> commit (which would roll back the rails freeze).  In general I need to
> know how to do this anyway. :)
> 
> Please help!
> 
> --
> Thanks!
> Bryan
> 

See corresponding man page for full details, but briefly:

# Updates index as well
git checkout HEAD^ -- config/boot.rb

or

# Output can be redirected
git show HEAD^:config/boot.rb

- Eric
