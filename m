From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-rebase.sh: Unchain the git-COMMAND into git COMMAND
Date: Tue, 05 Feb 2008 16:01:16 +0200
Organization: Private
Message-ID: <8x1zzemr.fsf@blue.sea.net>
References: <3as81nbn.fsf@blue.sea.net>
	<alpine.LSU.1.00.0802042050480.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 15:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOO0-0003a9-Oe
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYBEOCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbYBEOCK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:02:10 -0500
Received: from main.gmane.org ([80.91.229.2]:43914 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbYBEOCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:02:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMONB-00080w-J9
	for git@vger.kernel.org; Tue, 05 Feb 2008 14:02:05 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 14:02:05 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 14:02:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:Zm3Bqjbz0cwRdABvvt8qEPOhrSc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72655>

* Mon 2008-02-04 Johannes Schindelin <Johannes.Schindelin@gmx.de>
* Message-Id: alpine.LSU.1.00.0802042050480.8543@racer.site
> Hi,
>
> On Mon, 4 Feb 2008, Jari Aalto wrote:
>
>> -Example:       git-rebase master~1 topic
>> +Example:       git rebase master~1 topic
>
> From 36e5e70e0f40cf7ca4351b8159d68f8560a2805f(Start deprecating 
> "git-command" in favor of "git command"):
>
>     (For non-builtins, the "git xyzzy" format implies an extra execve(), so
>     this script leaves those alone).

Please elaborate. I'm not sure I understand. If the git-<command> syntax
is being phased out, it should be consistent decision accross the tools.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
