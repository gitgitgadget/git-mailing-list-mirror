From: David Lang <david@lang.hm>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 16:22:57 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1211271620220.16794@nftneq.ynat.uz>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com> <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com> <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:24:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVRd-0005QH-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2K1AXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:23:50 -0500
Received: from mail.lang.hm ([64.81.33.126]:51467 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab2K1AXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:23:49 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id qAS0NZkx017919;
	Tue, 27 Nov 2012 16:23:35 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20121128001231.GA27971@thyrsus.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210641>

On Tue, 27 Nov 2012, Eric S. Raymond wrote:

> Shawn Pearce <spearce@spearce.org>:
>> Well... if we added a fractional seconds to a commit, older versions
>> of Git will scream loudly and refuse to work with the new commit. That
>> would create a fork of Git.
>
> So much for that idea, I guess.
>
> Unless..I don't know how git's database representations work.  Are they
> version-stamped in any way?  If so, some slightly painful hackery would
> get around that problem.
>
> I'm being exploratory, here. No proposal to code anything is in the
> offing.

Apologies if this was covered earlier in the thread (I missed the beginning)

remember that git is dealing with timestamps generated across different 
machines, and since the times are not assumed to be in sync, let alone to the 
millisecond level, there's not much value to git in that level of presision.

git routinely deals with timestamps that are off by days. If the timestamps are 
within a minute or so, you are in pretty good shape.

David Lang
