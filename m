From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 11:42:11 +0000 (UTC)
Organization: disorganised!
Message-ID: <gi2rej$1mn$1@ger.gmane.org>
References: <200812090956.48613.thomas@koch.ro>
 <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
 <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org>
 <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
 <4944D4F7.7050501@siamect.com>
 <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 12:43:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBpNq-00021V-Jw
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYLNLmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbYLNLmU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:42:20 -0500
Received: from main.gmane.org ([80.91.229.2]:42597 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbYLNLmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:42:20 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LBpMY-0003yW-Cc
	for git@vger.kernel.org; Sun, 14 Dec 2008 11:42:18 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 11:42:18 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 11:42:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103074>

On 2008-12-14, david@lang.hm <david@lang.hm> wrote:
> On Sun, 14 Dec 2008, martin wrote:
>> Why do you trust VPN more than the SSH?
> in part it's that a VPN is a single point of control for all remote 
> access.
>
> If you use ssh you end up exposing all the individual machines

Need not be true.  None of my internal servers aer even
accessible from the outside world; they're all in RFC1918
space and there's only one gateway.  This *is* my single
point of control.

I can setup different port numbers to forward to different
internal servers (ssh, http, whatever I wish); that may
sound like a form of "exposing" but in reality it's a lot
*more* restrictive than setting up a VPN and granting access
to it.

I actually don't like VPNs; they imply that you're "inside"
the network in some way, and I hate blurring that
distinction.  If I'm outside, I want to be acutely aware of
it, and the fact that I can't even ping one of the inside
hosts or see what's on it, or do anything other than what is
specifically allowed by the gateway, is one way of ensuring
this.
