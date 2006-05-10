From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 10 May 2006 08:48:08 +0200
Organization: At home
Message-ID: <e3s2b0$i1m$1@sea.gmane.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 10 08:48:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdiUW-0000hG-5g
	for gcvg-git@gmane.org; Wed, 10 May 2006 08:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWEJGsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 02:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWEJGsI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 02:48:08 -0400
Received: from main.gmane.org ([80.91.229.2]:13804 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750886AbWEJGsH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 02:48:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FdiUO-0000fa-N6
	for git@vger.kernel.org; Wed, 10 May 2006 08:48:04 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 May 2006 08:48:04 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 May 2006 08:48:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19879>

Junio C Hamano wrote:

>   - built-in grep (me)
> 
>     I think this is also ready, even though it robs users from
>     having funky "grep" on their $PATH and invoke it.  Compared
>     to GNU grep, it lacks -P (pcre), -Z (NUL-terminated output),
>     -q (totally quiet), -z (NUL-terminated input), but all the
>     commonly used ones including -f (from file), -F (fixed), -w
>     (word regexp), -l/-L (files with/without match) and -n (line
>     number) are implemented.  The same "stop me or else" comment
>     applies.

If there would be possible to use external grep (like one can use external
diff), then lack of some options wouldn't matter.

-- 
Jakub Narebski
Warsaw, Poland
