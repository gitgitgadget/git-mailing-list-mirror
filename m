From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: re-licensing pkt-line.c code
Date: Thu, 25 Sep 2008 11:01:25 -0700
Message-ID: <20080925180125.GS3669@spearce.org>
References: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com> <48DBD114.80805@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Andreas Ericsson <ae@op5.se>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:02:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KivAh-0000kF-Gh
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 20:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYIYSB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYIYSB0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 14:01:26 -0400
Received: from george.spearce.org ([209.20.77.23]:60784 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYIYSB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 14:01:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 79AE03835F; Thu, 25 Sep 2008 18:01:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DBD114.80805@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96788>

Andreas Ericsson <ae@op5.se> wrote:
> Scott Chacon wrote:
>>
>> There are about 20-25 lines of code from pkt-line.c that I think were
>> originally written back in 2005 that I would like to use [...]
>>
>> I have to relicense this, since I can't legally distribute my source
>> code for the iphone app due to Apples f**king NDA.  I would like to
>> release my ObjectiveGit project under the MIT (or, alternately, LGPL).
>
>>  I could come up with an alternate way to
>> accomplish the same thing, but it seems like a waste of time to do so,
>> and helpful to nobody.
>
> Well, tracking down the original author(s) could turn out to be harder.

Its already cost more time to ask for permission to reuse these
20-25 lines of code than it would take to figure out how to write
it yourself, and code it.  And Linus still hasn't had a chance to
chime in on this thread.

My guess is you aren't going to get approval from him to relicense
his code.  But he doesn't hold a monopoly on int->hex conversion
algorithms so you should be able to implement something that produces
the same results, given the same inputs, and not have him sue you
in some Utah court.

-- 
Shawn.
