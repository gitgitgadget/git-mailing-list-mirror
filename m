From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/1] git-send-email: Add a --suppress-all option
Date: Tue, 18 Sep 2007 16:15:05 +0200
Message-ID: <86bqc03vrq.fsf@lola.quinscape.zz>
References: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net> <46EF8107.1030607@op5.se> <20070918132251.GB12120@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 16:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXe7M-00065J-Gm
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 16:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbXIROby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 10:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbXIRObu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 10:31:50 -0400
Received: from main.gmane.org ([80.91.229.2]:57054 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbXIRObr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 10:31:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXdxc-0005tq-Do
	for git@vger.kernel.org; Tue, 18 Sep 2007 16:21:56 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 16:21:56 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 16:21:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:qzGumi20tkHra0Q1npg9tW7o/+s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58612>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Tue, Sep 18, 2007 at 09:40:55AM +0200, Andreas Ericsson wrote:
>> Felipe Balbi wrote:
>>> From: Felipe Balbi <felipe.lima@indt.org.br>
>>> This patch adds a --suppress-all option to avoid sending emails
>>> to everybody but the ones listed by --to option.
>>
>> To my minds eye, --suppress-all is equivalent to --dry-run. Could you
>> rename it to "--cc-nobody" or some such?
>>
>> On a side-note, I've never really understood why git-send-email *by 
>> default*
>> sends to a bazillion people. Does anybody ever use it without suppressing
>> most of the CC targets?
>
> Yes.  I never suppress the cc's.  The cc-everyone thing is standard on
> the kernel mailing lists.
>
> The one exception is if I'm just sending the series to myself as a test.

Wouldn't --no-cc be a nicer option name?

-- 
David Kastrup
