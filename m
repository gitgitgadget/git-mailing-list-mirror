From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 21:15:01 +0100
Message-ID: <20160329201501.GE1578@serenity.lan>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
 <01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
 <20160329105402.GB1578@serenity.lan>
 <CAPig+cSUr1FK68qhHOf+M_tHqELW_ocJFU4-4kpjGVFV0R+F2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Zhang <zhanglei002@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al02u-00010C-AP
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbcC2UPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:15:16 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45152 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbcC2UPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:15:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 11BDACDA521;
	Tue, 29 Mar 2016 21:15:12 +0100 (BST)
X-Quarantine-ID: <CzM0DqKnGaZR>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CzM0DqKnGaZR; Tue, 29 Mar 2016 21:15:11 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A7D8DCDA523;
	Tue, 29 Mar 2016 21:15:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAPig+cSUr1FK68qhHOf+M_tHqELW_ocJFU4-4kpjGVFV0R+F2g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290182>

On Tue, Mar 29, 2016 at 02:04:38PM -0400, Eric Sunshine wrote:
> On Tue, Mar 29, 2016 at 6:54 AM, John Keeping <john@keeping.me.uk> wrote:
> > On Tue, Mar 29, 2016 at 10:11:01AM +0000, Ray Zhang wrote:
> >>       With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
> >>       in linkgit:git-checkout[1].
> >>
> >> +--[no-]checkout::
> >
> > This should be:
> >
> > --checkout::
> > --no-checkout::
> >
> > (see for example --progress in Documentation/merge-options.txt).
> 
> [1] suggested either form without stating a preference since existing
> Git documentation uses a mixture of the two. See, for instance,
> git-format-patch.txt. However, I see now that --[no-]-option is the
> minority.
> 
> [1]: http://article.gmane.org/gmane.comp.version-control.git/289840

I tend to skim the mailing list so I didn't register that at the time.

Having gone looking, I can't find a reference but I for some reason I
was convinced the separate version was preferred in the option
descriptions.  Note that AsciiDoc does handle this specially, at least
when outputting troff (HTML seems to show both on separate lines).
