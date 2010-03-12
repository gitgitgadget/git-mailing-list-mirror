From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Do not strip empty lines / trailing spaces from a commit
 message template
Date: Fri, 12 Mar 2010 18:07:22 +0100
Message-ID: <4B9A74CA.4080507@gmail.com>
References: <4B97C157.4020806@gmail.com> <20100311081213.GA13575@sigill.intra.peff.net> <20100311083148.GA13786@sigill.intra.peff.net> <7vaaueziv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 18:08:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8LA-0002o7-3l
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120Ab0CLRHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:07:55 -0500
Received: from lo.gmane.org ([80.91.229.12]:38792 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab0CLRHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:07:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nq8L3-0002iw-De
	for git@vger.kernel.org; Fri, 12 Mar 2010 18:07:53 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 18:07:53 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 18:07:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <7vaaueziv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142057>

On 11.03.2010 21:46, Junio C Hamano wrote:

> I suspect that the attached would be much easier to read and understand.

It is, indeed, easier to read. Thanks.

>> How about a test to check the new behavior?
>
> Speaking of tests, t2203 will segfault with your patch.  I don't think the
> following does, though.

Hmm, t2203 does neither segfault here with my nor your patch, but I'm 
running the test on msysGit.

Anyway, Junio, do you think it would be necessary to introduce a new 
test for this, or can I resend with just your improvements applied?

-- 
Sebastian Schuberth
