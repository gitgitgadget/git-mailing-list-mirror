From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #08; Sun, 24)
Date: Tue, 26 Jan 2010 01:07:24 +0100
Message-ID: <201001260107.25796.jnareb@gmail.com>
References: <7vfx5u6bn9.fsf@alter.siamese.dyndns.org> <m3eildbydx.fsf@localhost.localdomain> <20100125231241.GA4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jan 26 01:07:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZYy2-0004da-PS
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab0AZAHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628Ab0AZAHd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:07:33 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44186 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0AZAHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:07:33 -0500
Received: by bwz27 with SMTP id 27so3202479bwz.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 16:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z8DPBaao8WBTpJilkilYCPQZCLEheUAx+1qMk9Q59lc=;
        b=hWOzif/O3CPLfetqgv6ncHBFQVSQigCa+jVWrueWJ8vFQbEWw6BLE98ZhhvAZvkLQY
         ECcKgWjl6OuuKSh38XnRGndK91j+8OKzG+jO3K1tKSs3GsPBaJErIzPCHe4zcfnu8tXJ
         q1kZuosCky/WYNQhyVIZQZfF35CAOHG88GzLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dxtaihSVbZBJrvQVgkcU1W9smqyG6Ao5G4d/7ptYOdYbMMSP4VKMiI8n2mJ8vIIZbX
         enKhjj5WVj8FqgDI7sbobw42jGrwdqhB3KQ46GnKHtxh9kc2xfL/Xc9YMijxf336iOWW
         SIpdktp8+iHENwngfVszVKLu6mb/ixu/1rw30=
Received: by 10.204.20.17 with SMTP id d17mr864727bkb.195.1264464451617;
        Mon, 25 Jan 2010 16:07:31 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id 13sm2412667bwz.10.2010.01.25.16.07.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 16:07:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100125231241.GA4159@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138009>

On Tue, Jan 26, 2010 at 00:12 +0100, Petr Baudis wrote:
> On Mon, Jan 25, 2010 at 02:43:01PM -0800, Jakub Narebski wrote:

> > You are right that actual caching support is in flux.  The discussion
> > continues: it is very good that we have the voice from Pasky, too.
> 
> Unfortunately, I can't give much time to it, or actual contributions.
> I think it would be great to apply at least the miscellanous-changes
> part to (i) move this further (ii) give jh some positive feedback. :)
> There are ugly minor things, but they can be patched up later. I think
> it's healthier for new gitweb stuff to develop more in-tree, even
> if that means few angry users annoyed about less-than-perfect UI stuff,
> rather than polish the diamond in infinite discussions; worse is better!
> The only thing we should be worried about is avoiding introducing new
> bad URL interfaces since we should keep backwards compatibility there.

I think that while some patches from the miscellaneous-changes part are
good now (and very nice to have, especially load checking and 
gitweb/Makefile), there needs to be one last, final reroll of those
patches.

I am waiting for response from (I guess busy) J.H.; I can do the re-roll
if he is too busy to work on it.

> For the main caching patch, it seems like good idea to take Jakub's
> split-up series instead, let's see what is J.H.'s opinion on the series?

Let me at least make them into proper patches, with commit messages and 
configureability at least of the original caching patch by J.H.

Also the question whether to create 'print -> print $out' patch, or to
manipulate *STDOUT instead must be solved, I think, before applying
those patches... well, at least beyond 'pu'.

I am waiting for promised J.H. comments, when he will have time for it...
-- 
Jakub Narebski
Poland
