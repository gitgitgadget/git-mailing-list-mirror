From: David Kastrup <dak@gnu.org>
Subject: Re: Stupid quoting...
Date: Mon, 18 Jun 2007 10:00:31 +0200
Message-ID: <86ir9l1ylc.fsf@lola.quinscape.zz>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 10:02:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0CBq-0002gt-BP
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 10:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXFRICN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 04:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbXFRICM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 04:02:12 -0400
Received: from main.gmane.org ([80.91.229.2]:51455 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbXFRICJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 04:02:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0CB6-0001iW-3h
	for git@vger.kernel.org; Mon, 18 Jun 2007 10:01:37 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 10:01:36 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 10:01:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:UOXWAPfiDOxPfZ4xKvokwmhjxFw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50387>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup wrote:
>
>> what is the point in quoting file names and their characters in
>> git-diff's output? 
>
> 7-bit email.

I think it can be reasonably safely assumed that people using 8-bit
characters in file names will not refrain from using them in the files
themselves: file names usually are chosen descriptive of the contents,
and so rarely are in a different language.  So I don't see what
quoting such characters in file names is supposed to buy with regard
to diff output in 7-bit email.

-- 
David Kastrup
