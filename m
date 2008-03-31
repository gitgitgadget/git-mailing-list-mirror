From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 12:05:20 +0200
Message-ID: <62D616ED-83C8-4AB7-9113-98688732DE09@orakel.ntnu.no>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com> <47EECF1F.60908@vilain.net> <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no> <47EFD253.6020105@vilain.net> <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no> <47EFF5BE.7030502@vilain.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 12:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGu5-0002yP-2s
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 12:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYCaKFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 06:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753721AbYCaKFa
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 06:05:30 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:49815 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYCaKFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 06:05:30 -0400
Received: from ivilhamac.dhcp.ad.fast.no (pat-gw.osl.fast.no [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id AE38215A0BC;
	Mon, 31 Mar 2008 12:05:28 +0200 (CEST)
In-Reply-To: <47EFF5BE.7030502@vilain.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78579>

On 30. mars. 2008, at 22.19, Sam Vilain wrote:

> Eyvind Bernhardsen wrote:
>> Well, the point of "submodule push" was to avoid having to push in
>> each submodule manually; not enforcing the requirement that commits  
>> in
>> submodules must be publicly available before pushing from the main
>> module is a recipe for disaster, or at least annoyance.  And nobody
>> likes an annoying git.
>
> ok.  so, refuse to push without forcing, don't do something dumb.

I think you misunderstood: what I'm saying is that submodules'  
_current_ behaviour is annoying, since you're guaranteed to forget to  
push a submodule before pushing the main module at least once.  My  
attempt to solve that became too complicated, so I dropped it, and  
since the current behaviour is annoying, I gave up on submodules  
entirely.

>> Pushing to a branch works except that I couldn't figure out what to  
>> do
>> if the push doesn't succeed, ie, the branch has advanced on the  
>> remote
>> end.
>
> It's simple.  You just fail and tell the user what happened, and let
> them decide what to do.

Sure, that solves the annoyance problem, but I wanted something more  
automatic.

>> It's a reflog, not a branch, because a submodule can be changed to a
>> different branch, rewound, etc between commits in the main module;
>> there's no requirement that the old commit is in the new commit's
>> history.
>
> If it is a rewind there is no issue, because you don't even need to  
> push.
>
> But again it comes back to - let the user sort it out, don't try to be
> too clever.

Yep, my problem was wanting to be cleverer than my limited git skills  
will allow.
-- 
Eyvind Bernhardsen
