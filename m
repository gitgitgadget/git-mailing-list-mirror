From: Jason McMullan <jason.mcmullan@gmail.com>
Subject: Re: "failed to read delta base object at..."
Date: Tue, 26 Aug 2008 16:43:48 -0400
Message-ID: <48B46B04.70102@gmail.com>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org> <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bfields@fieldses.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 22:51:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5VP-0004q2-H3
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 22:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbYHZUuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYHZUuG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 16:50:06 -0400
Received: from main.gmane.org ([80.91.229.2]:35791 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYHZUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 16:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KY5UI-0006Jr-WA
	for git@vger.kernel.org; Tue, 26 Aug 2008 20:50:03 +0000
Received: from 209.195.169.219 ([209.195.169.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 20:50:02 +0000
Received: from jason.mcmullan by 209.195.169.219 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 20:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 209.195.169.219
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93816>

Linus Torvalds wrote:
> So the corrupt data looks like
> 
> [snip]
> 
> And as far as I can tell, that's the _only_ corruption in the whole file, 
> but I didn't really double-check.
> 
> Does anybody see a pattern?
> 

Was this pack created on a journaled file system? Reiserfs? Ext3?

If there's journal corruption in a commonly used filesystem,
That Would Be Bad.

I would suspect the Reiserfs 'file tail' behavour and journalling
have something to do with it, only because I still use and like
ReiserV3+LVM (dynamic grow and offline shrink baby!).

Only something like silently knifing files in the back would cause me
to leave my beloved RedrumFS.

Which I probably should. Eventually. Once ZFS changes it's license. HA!

- Jason McMullan
