From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 12:31:48 -0800
Message-ID: <20100203203148.GF14799@spearce.org>
References: <20100203174041.GC14799@spearce.org> <alpine.LFD.2.00.1002031311010.1681@xanadu.home> <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com> <20100203192658.GP9553@machine.or.cz> <9b18b3111002031143h63aaa6bpa4c91d140a769bb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcltN-0002vC-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655Ab0BCUbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:31:53 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:39608 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439Ab0BCUbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:31:51 -0500
Received: by iwn39 with SMTP id 39so2061436iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 12:31:50 -0800 (PST)
Received: by 10.231.79.12 with SMTP id n12mr191564ibk.59.1265229110629;
        Wed, 03 Feb 2010 12:31:50 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 21sm50289iwn.2.2010.02.03.12.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 12:31:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9b18b3111002031143h63aaa6bpa4c91d140a769bb0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138885>

demerphq <demerphq@gmail.com> wrote:
> On 3 February 2010 20:26, Petr Baudis <pasky@suse.cz> wrote:
> Right. The only solution i can see would have had to have been
> implemented already. And that would involved some headers being marked
> "pass through", some "marked throw away on cherry-pick" and some
> "choke horribly if you find this and dont know what it is".
> 
> And even with somethng like that one wonders if  notes arent really a
> better alternative to user defined headers anyway?

Yes, exactly.

I think notes turn out to be a much better way to store this extra
data, provided you are OK with them being disconnected during an
amend, cherry-pick, filter-branch, or rebase...  :-)

And unlike additional headers, git implementations will likely
support notes, because they are a good way to attach additional
user data onto commits.
 
-- 
Shawn.
