From: Jamie Border <jborder@gmail.com>
Subject: Re: StGit patchname numeric prefix?
Date: Tue, 03 Apr 2007 16:31:56 +0100
Message-ID: <874pnxqxsj.fsf@gmail.com>
References: <87odm5r833.fsf@gmail.com> <tnx648d5xs9.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 17:32:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYkzS-00067A-2n
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 17:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbXDCPcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 11:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbXDCPcE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 11:32:04 -0400
Received: from public2-cosh5-6-cust175868.cosh.static.ntl.com ([80.6.88.252]:64920
	"EHLO jamieb-laptop.bellfruit.local" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030332AbXDCPcB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2007 11:32:01 -0400
Received: from jamieb by jamieb-laptop.bellfruit.local with local (Exim 4.63)
	(envelope-from <jborder@gmail.com>)
	id 1HYkzE-0008JW-Ho
	for git@vger.kernel.org; Tue, 03 Apr 2007 16:31:56 +0100
In-Reply-To: <tnx648d5xs9.fsf@arm.com> (Catalin Marinas's message of "Tue\, 03 Apr 2007 15\:37\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43624>

Catalin Marinas <catalin.marinas@arm.com> writes:

> Jamie Border <jborder@gmail.com> wrote:
>> Is there a switch to have stgit prepend a numeric prefix to the
>> patch name?
>>
>> I'm trying to stg uncommit -n <large_number> from a repository, and
>> due to the excellent log messages, half of the patches get called
>> 'empty-log-message'.
>>
>> I'm sure when I played with stg a while ago I found a switch to do
>> that.
>
> It automatically adds a suffix if a patch with the same name already
> exists, i.e. empty-log-message-0, -1, ..., -n. No extra switch is
> needed.
>
> What StGIT version are you using?

0.11, which doesn't do that <g>.

Just changed to 0.12, which works great.

Many thanks, saved me hours and hours :-)

Jamie

>
> -- 
> Catalin
