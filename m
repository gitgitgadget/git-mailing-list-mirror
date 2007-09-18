From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/3] git-apply: fix whitespace stripping
Date: Tue, 18 Sep 2007 16:18:14 +0200
Message-ID: <867imo3vmh.fsf@lola.quinscape.zz>
References: <11899829424040-git-send-email-bfields@citi.umich.edu> <11899829424173-git-send-email-bfields@citi.umich.edu> <86r6kw4aki.fsf@lola.quinscape.zz> <20070918131237.GA12120@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 16:35:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXeAU-0007Os-P3
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 16:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbXIROfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 10:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbXIROfJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 10:35:09 -0400
Received: from main.gmane.org ([80.91.229.2]:39682 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990AbXIROfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 10:35:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXe3X-0006tX-Dc
	for git@vger.kernel.org; Tue, 18 Sep 2007 16:28:03 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 16:28:03 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 16:28:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:iS9DgYBailaNEfPdrdeVYnmN//0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58614>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Tue, Sep 18, 2007 at 10:55:25AM +0200, David Kastrup wrote:
>> As far as I can see, this does not really work since it does not
>> maintain an idea of a current column.
>> 
>> If you have
>> 
>> abcd<four spaces><tab><four spaces><tab>
>> 
>> then indeed the resulting conversion needs to be <tab><tab><tab>
>> whereas with
>> 
>> abc<four spaces><tab><four spaces><tab>
>> 
>> the resulting conversion needs to be just <tab><tab>
>
> Note that this code *only* handles whitespace in the initial indent;
> processing stops as soon as it hits anything other than a tab or an
> indent.
>
> Given that, I believe the proposed patch is correct.  Am I missing
> something else?

Don't think so.  Sorry for the noise.

-- 
David Kastrup
