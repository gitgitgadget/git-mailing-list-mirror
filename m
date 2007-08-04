From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 20:00:00 +0200
Message-ID: <85hcnfdvtr.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804120243.GB9716@coredump.intra.peff.net>
	<85tzrfh3yg.fsf@lola.goethe.zz>
	<8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	<85r6mjdyl8.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0708041804260.13596@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <lh@elementstorage.no>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Aug 04 20:00:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNv7-0007oe-9I
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 20:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXHDSAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXHDSAG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 14:00:06 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:35381 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932212AbXHDSAE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 14:00:04 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 2967730309D;
	Sat,  4 Aug 2007 20:00:03 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 110AB1B8E41;
	Sat,  4 Aug 2007 20:00:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9D3C636E86A;
	Sat,  4 Aug 2007 20:00:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 182541C4F932; Sat,  4 Aug 2007 20:00:00 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0708041804260.13596@beast.quantumfyre.co.uk> (Julian Phillips's message of "Sat\, 4 Aug 2007 18\:19\:26 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54893>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Sat, 4 Aug 2007, David Kastrup wrote:
>
>> "Lars Hjemli" <lh@elementstorage.no> writes:
>>
>>> The magic setup that makes this happen is the following lines in .git/config:
>> It would be helpful.  Except that nothing whatsoever can be found in
>> .git/config concerning my local and my remote tracking branches.  So
>> where is that information _really_ hidden away?
>
>> What gives?
>
> It would appear that your repo was created with an old version of
> git. Which also explains why you were talking about origin as a
> branch - which it used to be (a real local branch too ...), rather
> than as a remote - which it is now.
>
> The whole remotes/tracking mechanism changed in 1.5.0 - now it's
> much more flexible (and probably more complicated too).

I think I am going to cry.  So I need to rebase my branches, pull out
the resulting patch sets, scrap my repository, clone it new from
upstream, reapply my branches, in order to have a system where the
documentation is somewhat in synch with the actual behavior?

[...]

No, it would seem that I can just
git-clone -l
my repository and be set up in the new order of things.  Nice.

However, it would appear from my experiments up to now that the
--track option _can't_ be made to work with a 1.4 repository.  I think
that is worth mentioning in the docs.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
