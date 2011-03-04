From: Alexander Miseler <alexander@miseler.de>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 4 Mar 2011 20:14:01 +0000 (UTC)
Message-ID: <loom.20110304T210337-216@post.gmane.org>
References: <4D70EBC3.3010400@colin.guthr.ie> <7vr5am7p30.fsf@alter.siamese.dyndns.org> <7vei6m7muw.fsf@alter.siamese.dyndns.org> <7v39n27llq.fsf@alter.siamese.dyndns.org> <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com> <7vy64u65ta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 21:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvbOG-0000hB-Qd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 21:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab1CDUOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 15:14:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:41825 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760107Ab1CDUOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 15:14:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PvbO9-0000d6-R3
	for git@vger.kernel.org; Fri, 04 Mar 2011 21:14:13 +0100
Received: from g227005127.adsl.alicedsl.de ([92.227.5.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 21:14:13 +0100
Received: from alexander by g227005127.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 21:14:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.227.5.127 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Iron/5.0.381.0 Chrome/5.0.381 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168465>

It's a bit intimidating for a newbie to chime in on a discussion between the 
creator and the maintainer, but:
IMHO the biggest problem here isn't the incorrectly, but rather the silently. 
Reducing the chance of guessing incorrectly is good, but git-am still has to 
guess sometimes and it should warn/inform the user when it does that.
