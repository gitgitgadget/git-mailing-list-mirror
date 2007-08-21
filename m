From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 17:02:01 +0200
Message-ID: <867inpexsm.fsf@lola.quinscape.zz>
References: <46C97D26.9090102@brefemail.com> <20070821124949.GH768@genesis.frugalware.org> <46CAE41C.4614FDF4@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 17:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INVGX-0001FP-Qy
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 17:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761731AbXHUPC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761721AbXHUPC2
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 11:02:28 -0400
Received: from main.gmane.org ([80.91.229.2]:40864 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761710AbXHUPC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 11:02:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INVFJ-0004Hf-Dv
	for git@vger.kernel.org; Tue, 21 Aug 2007 17:02:17 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 17:02:17 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 17:02:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:7usLvdUny5xQLF+LBZFyIP/NbIY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56299>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Miklos Vajna wrote:
>> +-p::
>> +       For commits, show the change the commit introduces in a patch form.
>
> This is already documented by referencing git-diff-tree a few lines
> above:
>
> 	The command takes options applicable to the git-diff-tree[1]
> 	command to control how the changes the commit introduces are
> 	shown.
>
> The man page of git-diff-tree talks about -p, and a lot more
> options.

I am not really convinced this is a good idea: at the current point of
time, man-pages are not pulled into they user manual or any other
complete reference tome.  So they are basically standalone.  Even if
they weren't, I think it does not make all too much sense for a
porcelain command to point to the documentation of a plumbing command
for much of its functionality.

-- 
David Kastrup
