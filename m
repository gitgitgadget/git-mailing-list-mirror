From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: Where has "git ls-remote" reference pattern matching gone?
Date: Sun, 9 Dec 2007 16:38:03 +0100
Message-ID: <135A5AE4-45F9-47BC-8727-68C6680B6EEF@orakel.ntnu.no>
References: <4E5E5B1E-A303-45C9-9944-57D54FD50F80@orakel.ntnu.no> <7vve78tzw1.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712082048570.5349@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 16:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1OEf-0006pG-BF
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 16:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbXLIPiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 10:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXLIPiG
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 10:38:06 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:61170 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXLIPiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 10:38:05 -0500
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 40AB662ECF0;
	Sun,  9 Dec 2007 16:38:03 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0712082048570.5349@iabervon.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67627>

On 9. des.. 2007, at 03.20, Daniel Barkalow wrote:

> On Sat, 8 Dec 2007, Junio C Hamano wrote:
>
>> Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:
>>
>>> ls-remote was recently made a builtin; was reference filtering
>>> deliberately removed, or was it just lost in translation from the
>>> shell script?
>>
>> I suspect that to be the case.  Daniel, I think this is yours.
>
> Ah, sure enough. I didn't see that feature there, I guess. Am I  
> right that
> it's supposed to have "git ls-remote origin db/*" return refs of the
> form "*/db/*", interpreted as for globs?
>
> Eyvind: can I get a test case? I haven't ever used this feature, and  
> I'm
> not sure I'll implement it correctly.

I've noticed that a fix made it to master already; that's fast work by  
you and Junio!  Unfortunately, it fails the test case I was going to  
suggest, which is the one in the ls-remote manpage (see my response in  
the patch thread).

I haven't used the ref matching for anything (yet), so I don't have  
any other test cases.

Eyvind Bernhardsen
