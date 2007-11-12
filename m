From: David Kastrup <dak@gnu.org>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:17:26 +0100
Message-ID: <86pryf7815.fsf@lola.quinscape.zz>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbzL-0006P9-G9
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbXKLQR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbXKLQR7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:17:59 -0500
Received: from main.gmane.org ([80.91.229.2]:36692 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbXKLQR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:17:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Irbym-0000PV-J0
	for git@vger.kernel.org; Mon, 12 Nov 2007 16:17:40 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:17:40 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:17:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:fC9zfuPwy+Sla8zHEl2yLrb4+aw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64649>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:

> A bare repository is the way to publish your changes to the public.
> git-daemon  and http-clones use a bare repository that only contains
> adminsitrative files.
>
> From man page
>        --bare Make a bare GIT repository. That is, instead of creating
>               <directory> and placing the administrative files in
>               <directory>/.git, make the <directory> itself the $GIT_DIR. This
>               obviously implies the -n because there is nowhere to check out
>               the working tree. Also the branch heads at the remote are copied
>               directly to corresponding local branch heads, without mapping
>               them to refs/remotes/origin/. When this option is used, neither
>               remote-tracking branches nor the related configuration variables
>               are created.

Fine.  So why don't the following commands complain?  Apart from
git-reset without arguments (which could probably get along without a
working dir), they are supposed to employ a working directory.

> On Mon, Nov 12, 2007 at 02:11:58PM +0100, David Kastrup wrote:
>> 
>> I have a repository declared as bare.  Some commands treat it as such,
>> other's don't.  For example, I get
>> 
>> git-diff [no complaint]
>> git-reset [no complaint]
>> git-reset --hard
>> HEAD is now at db862c1... installmanager.sh: setze GIT_WORK_TREE


-- 
David Kastrup
