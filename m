From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: What's cooking in git.git (May 2015, #04; Mon, 11)
Date: Mon, 11 May 2015 22:13:46 -0400
Message-ID: <20150512021346.GF18112@tsaunders-iceball.corp.tor1.mozilla.com>
References: <xmqqk2we20mu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 04:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrzhm-000288-0M
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 04:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbELCNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 22:13:53 -0400
Received: from tbsaunde.org ([66.228.47.254]:44037 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbbELCNx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 22:13:53 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 09449C072;
	Tue, 12 May 2015 02:13:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqk2we20mu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268839>

On Mon, May 11, 2015 at 03:46:33PM -0700, Junio C Hamano wrote:
> * nd/untracked-cache (2015-03-12) 24 commits
>  - git-status.txt: advertisement for untracked cache
>  - untracked cache: guard and disable on system changes
>  - mingw32: add uname()
>  - t7063: tests for untracked cache
>  - update-index: test the system before enabling untracked cache
>  - update-index: manually enable or disable untracked cache
>  - status: enable untracked cache
>  - untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
>  - untracked cache: mark index dirty if untracked cache is updated
>  - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
>  - untracked cache: avoid racy timestamps
>  - read-cache.c: split racy stat test to a separate function
>  - untracked cache: invalidate at index addition or removal
>  - untracked cache: load from UNTR index extension
>  - untracked cache: save to an index extension
>  - ewah: add convenient wrapper ewah_serialize_strbuf()
>  - untracked cache: don't open non-existent .gitignore
>  - untracked cache: mark what dirs should be recursed/saved
>  - untracked cache: record/validate dir mtime and reuse cached output
>  - untracked cache: make a wrapper around {open,read,close}dir()
>  - untracked cache: invalidate dirs recursively if .gitignore changes
>  - untracked cache: initial untracked cache validation
>  - untracked cache: record .gitignore information and dir hierarchy
>  - dir.c: optionally compute sha-1 of a .gitignore file
> 
>  Need extra sets of eyes to review this.

I can't usefully comment on the code.  However it makes it more pleasent
to deal with several big repos I use regularly, and I haven't noticed
any bugs yet.

Trev
