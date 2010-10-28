From: Eric Raible <raible@nextest.com>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 23:39:34 -0700
Message-ID: <4CC91AA6.2000301@nextest.com>
References: <20101027173644.GB15657@burratino> <0016e645b8c87a160804939cdc5e@google.com> <20101027180541.GA20527@burratino> <4CC87DE6.9090604@nextest.com> <4CC8E5B5.7050404@workspacewhiz.com> <78EBA946-B3BA-458B-9528-C5F80872B3E0@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Euguess@gmail.com" <Euguess@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 28 08:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBM9q-0004Yy-4D
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 08:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab0J1GkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 02:40:01 -0400
Received: from smtps.nextest.com ([12.96.234.114]:20210 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753972Ab0J1GkA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 02:40:00 -0400
Received: from [131.101.151.88] (131.101.151.88) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Wed, 27 Oct 2010 23:39:56 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b2 Thunderbird/3.1.5
In-Reply-To: <78EBA946-B3BA-458B-9528-C5F80872B3E0@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160159>

On 10/27/2010 8:27 PM, Kevin Ballard wrote:
> On Oct 27, 2010, at 7:53 PM, Joshua Jensen wrote:
> 
>> ----- Original Message -----
>> From: Eric Raible
>> Date: 10/27/2010 1:30 PM
>>>
>>> I would much prefer if branch.<name>.rebase was allowed to
>>> specify the arguments to be passed to rebase:
>>>
>>> 	git config branch.mybranch.rebase "-i --preserve-merges"
>>>
>>> Anyone else see the value of something like this?
>> When --preserve-merges actually preserves the merges (perhaps the rebase-i-p branch is on the way to finishing this feature??  I couldn't get it to apply...), I would like this facility very much.  By default, I think rebase *should* preserve merges, and the current flattening it does now should be an option.
> 
> Sure would be nice, but that sort of backwards-incompatible change would likely break a lot of people who rely on the current flattening behavior.
> 
> -Kevin Ballard.

But it's not backwards incompatible: only true/false are now
allowed so an arbitrary string would not currently be used.

In my proposal a string would imply true, and would mean
"append the specified value when running rebase".
