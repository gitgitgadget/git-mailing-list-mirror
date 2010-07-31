From: Walter Bright <boost@digitalmars.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Fri, 30 Jul 2010 23:24:34 -0700
Organization: Digital Mars
Message-ID: <i30fj8$cit$1@dough.gmane.org>
References: <i308gl$v6p$1@dough.gmane.org> <20100731044957.GA8920@burratino> <i30bg7$50k$1@dough.gmane.org> <20100731053918.GA19688@LK-Perkele-V2.elisa-laajakaista.fi> <i30da5$84d$1@dough.gmane.org> <20100731055735.GA19812@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 08:25:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5VI-00057T-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047Ab0GaGYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 02:24:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:43542 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906Ab0GaGYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:24:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Of5V2-00051L-03
	for git@vger.kernel.org; Sat, 31 Jul 2010 08:24:48 +0200
Received: from c-24-16-56-60.hsd1.wa.comcast.net ([24.16.56.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 08:24:47 +0200
Received: from boost by c-24-16-56-60.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 08:24:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-56-60.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20100731055735.GA19812@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152315>

Ilari Liusvaara wrote:
> On Fri, Jul 30, 2010 at 10:45:36PM -0700, Walter Bright wrote:
> 
>>> [1] But upon restore, the working copy cache will be wrong
>> Why? Is it someplace else?
> 
> It is inside .git directory and will be caught by full recursive
> backup. Unfortunately, it contains i-node numbers, which aren't
> preserved through backup and restore.
> 
> The wrong i-node numbers would then confuse git (false positives
> in modification detection). Fortunately, this data can be rebuilt
> with single command (see below).

Hmm. One thing I wanted to get away from from Windows was the inability to 
restore files by just copying the tree.


>>> and needs to be rebuilt (git update-index --refresh).

That's crucial to know. Thanks!
