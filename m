From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 11:11:33 +0200
Message-ID: <9019207B-77A5-4595-8499-807DA0460EF0@zib.de>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de> <7vodfnqndc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 11:20:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbC0x-0008PB-UT
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653AbXI1JTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 05:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbXI1JTl
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:19:41 -0400
Received: from mailer.zib.de ([130.73.108.11]:41940 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbXI1JTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:19:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8S99wWQ016187;
	Fri, 28 Sep 2007 11:09:58 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8S99vwW011659
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 28 Sep 2007 11:09:57 +0200 (MEST)
In-Reply-To: <7vodfnqndc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59379>


On Sep 28, 2007, at 9:07 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> When "remote.<name>.push" is set I'd expect "git push" to
>> choose only the 'right' remote.<name>.push lines, that is
>> the lines that have the current branch as the local ref.
>
> That would break the existing setup so it would not fly as a
> default, although it could be added as an option.

Do you mean 'not now' or never, i.e. not in git 1.6?

What does 'break the existing setup' means? Pushing all branches
that are configured in "remote.<name>.push" could be done by
"git push <name>". This would be in the line with the idea that
"git push" should only operate on the current branch and operations
involving other local refs should be explicitly stated.

	Steffen
