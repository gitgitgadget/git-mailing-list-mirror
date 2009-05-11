From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Mon, 11 May 2009 22:11:31 +0200
Message-ID: <EDAB1A7F-628A-47F6-BAEB-89935E86546A@orakel.ntnu.no>
References: <86prekfv7z.fsf@blue.stonehenge.com> <20090508023028.GA1218@coredump.intra.peff.net> <F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no> <7vk54rvb8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Yuval Kogman <nothingmuch@woobling.org>,
	Sverre Hvammen Johansen <hvammen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 22:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bqk-0005yZ-8F
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 22:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbZEKULe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbZEKULd
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 16:11:33 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:64208 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbZEKULd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 16:11:33 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.221])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 5B68623A4CD;
	Mon, 11 May 2009 22:11:31 +0200 (CEST)
In-Reply-To: <7vk54rvb8x.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118840>

On 8. mai. 2009, at 17.57, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:
>
>> I read it as a request for pull/merge --ff-only (based on "abort if
>> the workdir is dirty or is not a fast-forward update").  This feature
>> has been implemented twice, but never included:
>
> Interesting.  Do you mean twice they were both found lacking,  
> substandard,
> useless, uninteresting, buggy, incorrect, or all of the above?  Or  
> was it
> just somebody simply forgot to apply a perfect patchset twice?

Sorry, I should have summarised.

I guess Yuval explained what happened to his patch himself.  Sverre's  
was dropped after a fair amount of discussion and several rounds, but  
his series added multiple fast-forward strategies, not just "ff-only".

The last reference I can find to it in the archives is Dscho asking  
for the feature to be held off pending the builtinification of git- 
merge (http://article.gmane.org/gmane.comp.version-control.git/ 
82623).  Sverre probably lost interest in following up after that.

It looks like there's some interest behind the "--ff=only" feature  
now, at least.  I remembered the thread because of it; I wanted to  
replace a "git reset --hard" in my workflow with something slightly  
safer, and --ff=only would have fit.
-- 
Eyvind Bernhardsen
